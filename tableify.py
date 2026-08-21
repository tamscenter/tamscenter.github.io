import os
import subprocess
import sys
from collections import Counter
from datetime import datetime, timedelta, timezone

from jinja2 import Template

HOSTED_DIR = "hosted_files"

# Files added within this window are highlighted as new in the table.
NEW_WINDOW = timedelta(days=365)


def human_size(n):
    """Format a byte count as e.g. '12 B', '34 KB', '5.6 MB'."""
    if n < 1024:
        return "{} B".format(int(n))
    size = float(n)
    for unit in ("KB", "MB", "GB", "TB"):
        size /= 1024
        if size < 1024:
            return "{:.1f} {}".format(size, unit)
    return "{:.1f} PB".format(size / 1024)


def build_date_maps():
    """Map each current path under hosted_files/ to two ISO 8601 timestamps:
    when it was last modified, and when it was first added.

    Returns ``(mtimes, ctimes)`` where ``mtimes[path]`` is the date of the most
    recent commit that added or modified the file's content and
    ``ctimes[path]`` is the date of the oldest commit that added it.

    Follows renames so that moving a file (even without ``git mv``) resets
    neither date. Pure-rename commits (status ``R``) are deliberately ignored;
    only ``A`` (add) and ``M`` (modify) update the modified date, and only
    ``A`` updates the added date.

    Returns empty dicts if git is unavailable or no history exists for
    the tree."""
    try:
        result = subprocess.run(
            ["git", "log", "--name-status", "--format=__DATE__%cI", "--", HOSTED_DIR],
            capture_output=True,
            text=True,
            check=False,
            timeout=30,
        )
    except (OSError, subprocess.TimeoutExpired) as e:
        print(
            "git log unavailable, date data will be blank: {}".format(e),
            file=sys.stderr,
        )
        return {}, {}

    if result.returncode != 0:
        print(
            "git log failed (exit {}): {}".format(
                result.returncode, result.stderr.strip()
            ),
            file=sys.stderr,
        )
        return {}, {}

    # Walk commits newest-first. When we see a rename (R<sim>\told\tnew),
    # remember that `old` is the historical name of whatever `new` is
    # currently known as (transitively, through later renames). When we see
    # an Add or Modify on a path, record this commit's date for the path's
    # *current* name -- but only on first (newest) occurrence.
    alias = {}   # past_path -> present_path (after all later renames)
    mtimes = {}  # present_path -> iso timestamp of newest add/modify
    ctimes = {}  # present_path -> iso timestamp of oldest add
    current_iso = None

    for line in result.stdout.splitlines():
        if line.startswith("__DATE__"):
            current_iso = line[len("__DATE__"):]
            continue
        if not line or current_iso is None:
            continue
        parts = line.split("\t")
        if len(parts) < 2:
            continue
        status = parts[0]
        if status.startswith("R") and len(parts) >= 3:
            old_path, new_path = parts[1], parts[2]
            present = alias.get(new_path, new_path)
            alias[old_path] = present
        elif status in ("A", "M"):
            path = parts[1]
            present = alias.get(path, path)
            mtimes.setdefault(present, current_iso)
            if status == "A":
                # Overwrite: walking newest-first, the last add we see is the
                # oldest one, i.e. when the file first appeared.
                ctimes[present] = current_iso
        # Skip D (deleted), T (type change), U (unmerged), C (copy), etc.

    return mtimes, ctimes


def normalize_mtime(iso):
    """Convert a git %cI timestamp to (sort_key, display_string).

    Sort key is the UTC-normalized ISO 8601 string (lexicographically
    chronological). Display string is e.g. 'Mar 2024'. Unknown timestamps
    return ('0', '\u2014') so they sort below any real date."""
    if not iso:
        return "0", "\u2014"
    try:
        dt = datetime.fromisoformat(iso).astimezone(timezone.utc)
    except ValueError:
        return "0", "\u2014"
    return dt.isoformat(), dt.strftime("%b %Y")


def is_recent(iso, now):
    """True if a git %cI timestamp falls within NEW_WINDOW of ``now``.

    Unknown or unparseable timestamps are not recent."""
    if not iso:
        return False
    try:
        dt = datetime.fromisoformat(iso).astimezone(timezone.utc)
    except ValueError:
        return False
    return now - dt <= NEW_WINDOW


def annotate(base, mtime_map, ctime_map, now):
    """Add size and git-date metadata to a file dict (in place)."""
    try:
        size_bytes = os.path.getsize(base["link"])
    except OSError:
        size_bytes = 0
    mtime_iso, mtime_display = normalize_mtime(mtime_map.get(base["link"]))
    base["size_bytes"] = size_bytes
    base["size_human"] = human_size(size_bytes)
    base["mtime_iso"] = mtime_iso
    base["mtime_display"] = mtime_display
    base["is_new"] = is_recent(ctime_map.get(base["link"]), now)
    return base


now = datetime.now(timezone.utc)
mtime_map, ctime_map = build_date_maps()
files = []

for item in os.listdir(HOSTED_DIR):
    print(item)
    if "." in item:
        name, extension = item.rsplit(".", 1)
        base = {
            "name": name.replace("_", " "),
            "section": "Top Level",
            "type": extension.replace("_", " "),
            "link": "hosted_files/{}".format(item),
        }
        files.append(annotate(base, mtime_map, ctime_map, now))
    else:
        try:
            subitems = os.listdir("hosted_files/" + item)
        except OSError as e:
            print(
                "Skipping subdirectory {!r}: {}".format(item, e),
                file=sys.stderr,
            )
            continue

        for subitem in subitems:
            print("SUBITEM: {}".format(subitem))
            if "." in subitem:
                name, extension = subitem.rsplit(".", 1)
                base = {
                    "name": name.replace("_", " "),
                    "section": item.replace("_", " "),
                    "type": extension.replace("_", " "),
                    "link": "hosted_files/{}/{}".format(item, subitem),
                }
                files.append(annotate(base, mtime_map, ctime_map, now))

files = [
    f for f in files if "desktop.ini" not in f["link"] and "DS_Store" not in f["link"]
]

section_counts = Counter(f["section"] for f in files)
sections = sorted(
    [{"name": name, "count": count} for name, count in section_counts.items()],
    key=lambda s: s["name"].lower(),
)

template = Template(open("templates/index.tpl").read())

last_updated = now.strftime("%Y-%m-%d %H:%M UTC")
new_count = sum(1 for f in files if f["is_new"])

with open("index.html", "w+") as f:
    f.write(
        template.render(
            files=files,
            sections=sections,
            last_updated=last_updated,
            new_count=new_count,
        )
    )
