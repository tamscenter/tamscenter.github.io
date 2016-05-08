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
  <body>
    <div class="">
      <div class="px3 lg-px4">
      <!--This is where your title section goes!-->
      <header class="py4">
        <div class="flex flex-wrap items-center mt4">
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
      <nav id="nav" class="pl2 my2 border-left border-thick border-darken" style="max-width:768px;">
        <div class="mxn2 flex flex-wrap">
          <div class="px2 col-6 sm-col-4 md-col-3">
            <a href="#getting-started" class="h6 caps bold inline-block py1 color-inherit text-decoration-none hover-underline">Getting Started</a>
          </div>
          <div class="px2 col-6 sm-col-4 md-col-3  "><a href="#hosted-files" class="h6 caps bold inline-block py1 color-inherit text-decoration-none hover-underline">Hosted Files</a>
          </div>
        </div>
      </nav>
      <section id="getting-started" class="py4">
        <h2 class="h1">
          <a href="#getting-started" class="color-inherit text-decoration-none hover-underline">Getting Started</a>
        </h2>
        <p class="h1">Hello you.</p></br>
        <p class="h3">there will soon be more here.</p>
      </section>

      <section id="hosted-files" class="py4">
                <h2 class="h1">
          <a href="#hosted-files" class="color-inherit text-decoration-none hover-underline">Hosted Files</a>
        </h2>
<div id="hosted-files-section">
  <input class="search" placeholder="Search Text" />
  <button class="sort;display:none" data-sort="download">
  </button>
  <button class="sort" data-sort="name">
    Sort by name
  </button>
  <button class="sort" data-sort="section">
    Sort by section
  </button>
  <button class="sort" data-sort="type">
    Sort by type
  </button>
  <table>
    <!-- IMPORTANT, class="list" have to be at tbody -->
    <tbody class="list">
      <tr>
        <th>Download Link</th>
        <th>Name</th>
        <th>Section</th>
        <th>Type</th>
      </tr>
      {% for file in files %}
      <tr>
        <td class="download"><a href="{{ file.link }}">Download</a></td>
        <td class="name">{{ file.name }}</td>
        <td class="section">{{ file.section }}</td>
        <td class="type">{{ file.type }}</td>
      </tr>
      {% endfor %}
    </tbody>
  </table>

</div>
</section>


      </div>
      </div>
    </div>
  </body>
  <script src="js/list.js"></script>
  <script>
    var options = {
    valueNames: [ 'download', 'name', 'section', 'type' ]
    };

    var userList = new List('hosted-files-section', options);
    </script>
</html>
