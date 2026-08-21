<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>TAMS Center: Data Tools</title>
    <meta name="description" content="Data Tools released by NAU's Tribal Air Monitoring Center">
    <meta name="author" content="TAMS Center">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="theme-color" content="#28a8e0">
    <link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="192x192" href="favicon-192x192.png">
    <link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
    <meta name="msapplication-TileImage" content="mstile-270x270.png">
    <link href="css/list-css.css" rel="stylesheet">
    <link href="css/basscss.8.0.1.min.css" rel="stylesheet">
  </head>
  <body>
    <div class="px3 lg-px4">
      <header class="py3">
        <h1 class="m0">TAMS Center Data Tools</h1>
        <p class="h3 mt1 mb2">Tribal Air Monitoring Tools and Procedures</p>
        <img src="img/img_idxTabs_tams.png" alt="TAMS Center logo" class="block mb2">
        <a class="btn-primary" href="https://itep.nau.edu/tams/" target="_blank" rel="noopener noreferrer">
          Visit NAU TAMS Center
          <span class="sr-only">(opens in a new tab)</span>
        </a>
      </header>
      <section id="hosted-files" class="py2">
        <h2 class="h1 mt0">Shareable Resources</h2>
        <p>These files have been generously provided by tribal environmental professionals, states, counties, and the EPA.</p>
        <p>They represent the experience and generosity of many people, especially the <a href="https://itep.nau.edu/tams/sc-home/">Tribal Air Monitoring Support Center Steering Committee</a>.</p>
        <p class="h4">
          Click on blue headers to sort
        </p>
        {% if new_count %}
        <p class="h5"><span class="new-badge">New</span> Highlighted rows were added in the past year ({{ new_count }}).</p>
        {% endif %}
        <div class="callout p2 my2 border rounded">
          <h3 class="m0">
            <a href="windrose/">Windrose Creation Utility</a>
          </h3>
          <p class="m0 mt1">Create a windrose from any Excel file directly in your browser.</p>
        </div>
        <div id="table-wrapper" class="overflow-scroll">
          <div class="chip-bar" role="group" aria-label="Filter by section">
            <button type="button" class="chip is-active" data-section="" aria-pressed="true">
              All <span class="chip-count">{{ files|length }}</span>
            </button>
            {% for s in sections %}
            <button type="button" class="chip" data-section="{{ s.name }}" aria-pressed="false">
              {{ s.name }} <span class="chip-count">{{ s.count }}</span>
            </button>
            {% endfor %}
          </div>
          <label for="resource-search" class="sr-only">Search resources</label>
          <input id="resource-search" class="search" type="search" placeholder="Search Text" aria-label="Search resources" />
          <table class="table-light">
            <caption class="sr-only">Shareable resources, sortable by file name, section, file type, size, or modified date.</caption>
            <thead>
              <tr>
                <th scope="col" class="sort" data-sort="name">File Name</th>
                <th scope="col" class="sort" data-sort="section">Section</th>
                <th scope="col" class="sort" data-sort="type">File Type</th>
                <th scope="col" class="sort right-align" data-sort="size">Size</th>
                <th scope="col" class="sort" data-sort="mtime">Modified</th>
              </tr>
            </thead>
            <tbody class="list">
              {% for file in files %}
              <tr{% if file.is_new %} class="is-new"{% endif %}>
                <td><span class="name"><a href="{{ file.link }}">{{ file.name }}</a></span>{% if file.is_new %} <span class="new-badge">New</span>{% endif %}</td>
                <td class="section">{{ file.section }}</td>
                <td class="type">{{ file.type }}</td>
                <td class="size right-align" data-bytes="{{ file.size_bytes }}">{{ file.size_human }}</td>
                <td class="mtime" data-mtime="{{ file.mtime_iso }}">{{ file.mtime_display }}</td>
              </tr>
              {% endfor %}
            </tbody>
          </table>
        </div>
        <p class="h6 mt2 text-muted">
          Page last updated: {{ last_updated }}
        </p>
      </section>
    </div>
    <script src="js/list.2.3.1.min.js"></script>
    <script>
      var options = {
          valueNames: [
              'name',
              'section',
              'type',
              { name: 'size',  attr: 'data-bytes' },
              { name: 'mtime', attr: 'data-mtime' }
          ]
      };
      var contactList = new List('table-wrapper', options);

      document.querySelectorAll('.chip').forEach(function (chip) {
        chip.addEventListener('click', function () {
          document.querySelectorAll('.chip').forEach(function (c) {
            c.classList.remove('is-active');
            c.setAttribute('aria-pressed', 'false');
          });
          chip.classList.add('is-active');
          chip.setAttribute('aria-pressed', 'true');
          var section = chip.dataset.section;
          if (!section) {
            contactList.filter();
          } else {
            contactList.filter(function (item) {
              return item.values().section === section;
            });
          }
        });
      });
    </script>
  </body>
</html>
