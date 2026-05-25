# Tribal Air Monitoring Center

### Data Tools

### GO TO http://datatools.tamscenter.com/

Static hosted site for TAMS center file & procedure hosting.

## Updating the site

`index.html` is generated automatically by a GitHub Action
(`.github/workflows/tableify.yml`) that runs `tableify.py` whenever
`hosted_files/`, `templates/`, `tableify.py`, `pyproject.toml`, or
`uv.lock` change on `main`. The action commits the regenerated
`index.html` back to `main`, which is then published by GitHub Pages.

Do **not** hand-edit `index.html` — your changes will be overwritten
the next time the workflow runs.

Checklist:

- [ ] Add or remove files in the `hosted_files` folder
- [ ] Change text in `index.tpl` template file in the `templates` folder
- [ ] Commit changes to `main` (the workflow regenerates `index.html` for you)

The workflow can also be triggered manually from the GitHub Actions tab
via **Run workflow** (`workflow_dispatch`).

## Running locally

This project uses [uv](https://docs.astral.sh/uv/) for Python and
dependency management. Install uv once (e.g. `brew install uv` on macOS
or `curl -LsSf https://astral.sh/uv/install.sh | sh`), then:

```sh
uv sync
uv run python tableify.py
```

`uv sync` reads `pyproject.toml` and `uv.lock` to create a `.venv`
with the exact pinned dependencies used in CI. Both `pyproject.toml`
and `uv.lock` must stay in sync — if you change a dependency, run
`uv lock` and commit the updated lockfile.

Uses Basscss: http://www.basscss.com/
