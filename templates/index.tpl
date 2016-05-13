<html>
  <head>
    <meta charset="utf-8"></meta>
    <title>TAMS Center: Data Tools</title>
    <meta name="description" content="Data Tools released by NAU's Tribal Air Monitoring Center"></meta>
    <meta name="author" content="TAMS Center"></meta)
    <meta name="keywords" content="native american, air quality monitoring, tribal air monitoring, data tools"></meta>
    <meta name="viewport" content="width=device-width,initial-scale=1"></meta>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono" rel="stylesheet" type="text/css">
    <link href="css/list-css.css" rel="stylesheet">
    <link href="css/basscss.8.0.1.min.css" rel="stylesheet">
  </head>
  <body style="height:3000px">
    <div class="">
      <div class="px3 lg-px4">
      <header>
        <div class="flex flex-wrap items-center">
          <div class="">
            <h1 class="m0">TAMS Center Data Tools</h1>
            <p class="h3 mt1 mb1">Tribal Air Monitoring Tools and Procedures</p>
            <div class="flex flex-wrap items-center mb2">
              <a href="http://www7.nau.edu/itep/main/tams/Home/" class="my1">
                <img src="img/img_idxTabs_tams.png" class="block" alt="TAMS Logo">
              </a>
            </div>
          </div>
      </header>
      <section id="hosted-files" class="py2">
        <h2 class="h1">
          <a href="#hosted-files" style="color:black" class="text-decoration-none hover-underline">Hosted Files</a>
        </h2>
        <div id="table-wrapper">
          <input class="search" placeholder="Search Text" />
          <table>
            <thead>
              <tr>
                <th class="sort" data-sort="download2">Download</th>
                <th class="sort" data-sort="name">File Name</th>
                <th class="sort" data-sort="section">Section</th>
                <th class="sort" data-sort="type">File Type</th>
              </tr>
            </thead>
            <tbody class="list">
              {% for file in files %}
              <tr>
                <td ><a href="{{ file.link }}">Download</a></td>
                <td class="name">{{ file.name }}</td>
                <td class="section">{{ file.section }}</td>
                <td class="type">{{ file.type }}</td>
              </tr>
              {% endfor %}
            </tbody>
          </table>
        </div>
      </div>
      </div>
    </div>
  </body>
  <script src="js/list.1.1.1.min.js"></script>
  <script type="text/javascript">
    var options = {
        valueNames: [ 'download', 'name', 'section', 'type' ]
    };
    var contactList = new List('table-wrapper', options);
  </script>
</html>
