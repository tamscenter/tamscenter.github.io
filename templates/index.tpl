<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>TAMS Center: Data Tools</title>
    <meta name="description" content="Data Tools released by NAU's Tribal Air Monitoring Center">
    <meta name="author" content="TAMS Center">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono" rel="stylesheet" type="text/css">
    <link href="css/list-css.css" rel="stylesheet">
    <link href="css/basscss.8.0.1.min.css" rel="stylesheet">
  </head>
  <body>
    <div class="px3 lg-px4">
      <header class="py3">
        <h1 class="m0">TAMS Center Data Tools</h1>
        <p class="h3 mt1 mb2">Tribal Air Monitoring Tools and Procedures</p>
        <img src="img/img_idxTabs_tams.png" alt="TAMS Center logo" class="block mb2">
        <a class="btn-primary" href="https://itep.nau.edu/tams/">
          Visit NAU TAMS Center
        </a>
      </header>
      <section id="hosted-files" class="py2">
        <h2 class="h1 mt0">Shareable Resources</h2>
        <p>These files have been generously provided by tribal environmental professionals, states, counties, and the EPA.</p>
        <p>They represent the experience and generosity of many people, especially the <a href="https://itep.nau.edu/tams/sc-home/">Tribal Air Monitoring Support Center Steering Committee</a>.</p>
        <p>Please email us if you have ideas for files to share or files you are looking for.</p>
        <p class="h4">
          Click on blue headers to sort
        </p>
        <div class="callout p2 my2 border rounded">
          <h3 class="m0">
            <a href="windrose/">Windrose Creation Utility</a>
          </h3>
          <p class="m0 mt1">Create a windrose from any Excel file directly in your browser.</p>
        </div>
        <div id="table-wrapper" class="overflow-scroll">
          <label for="resource-search" class="sr-only">Search resources</label>
          <input id="resource-search" class="search" type="search" placeholder="Search Text" aria-label="Search resources" />
          <table class="table-light">
            <caption class="sr-only">Shareable resources, sortable by file name, section, or file type.</caption>
            <thead>
              <tr>
                <th scope="col" class="sort sort-inactive" data-sort="download2">Download</th>
                <th scope="col" class="sort" data-sort="name">File Name</th>
                <th scope="col" class="sort" data-sort="section">Section</th>
                <th scope="col" class="sort" data-sort="type">File Type</th>
              </tr>
            </thead>
            <tbody class="list">
              {% for file in files %}
              <tr>
                <td><a href="{{ file.link }}">Download</a></td>
                <td class="name">{{ file.name }}</td>
                <td class="section">{{ file.section }}</td>
                <td class="type">{{ file.type }}</td>
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
    <script src="js/list.1.1.1.min.js"></script>
    <script>
      var options = {
          valueNames: ['download', 'name', 'section', 'type']
      };
      var contactList = new List('table-wrapper', options);
    </script>
  </body>
</html>
