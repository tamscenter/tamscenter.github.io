# Tribal Air Monitoring Center

### Data Tools

### GO TO http://datatools.tamscenter.com/

Static hosted site for TAMS center file & procedure hosting.

## Updating the site

`index.html` is generated automatically by a GitHub Action
(`.github/workflows/tableify.yml`) that runs `tableify.py` whenever
`hosted_files/`, `templates/`, `tableify.py`, or `requirements.txt`
change on `main`. The action commits the regenerated `index.html` back
to `main`, which is then published by GitHub Pages.

Do **not** hand-edit `index.html` — your changes will be overwritten
the next time the workflow runs.

Checklist:

- [ ] Add or remove files in the `hosted_files` folder
- [ ] Change text in `index.tpl` template file in the `templates` folder
- [ ] Commit changes to `main` (the workflow regenerates `index.html` for you)

The workflow can also be triggered manually from the GitHub Actions tab
via **Run workflow** (`workflow_dispatch`).

## Running locally

```sh
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python tableify.py
```


Uses Basscss: http://www.basscss.com/
