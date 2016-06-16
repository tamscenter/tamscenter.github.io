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
    <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-77807386-1', 'auto');
    ga('send', 'pageview');
    </script>
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
            <div class="flex flex-wrap items-center mb2">
              <a href="http://www7.nau.edu/itep/main/tams/Home/" class="my1">
                http://www7.nau.edu/itep/main/tams/Home/
              </a>
            </div>
      </header>
      <section id="hosted-files" class="py2">
        <h2 class="h1" style="margin-top:0;">
          <a href="#hosted-files" style="color:black" class="text-decoration-none hover-underline">Shareable Resources</a>
        </h2>
        These files have been generously provided by tribal environmental professionals, states, counties, and the EPA. </br>
        They represent the experience and generosity of many people, especially the <a href="http://www7.nau.edu/itep/main/tams/SCommittee/SC_members">Tribal Air Monitoring Support Center Steering Committee</a>.</br>
        Please email us if you have ideas for files to share or files you are looking for.</br>
        Contact: <a class="atag" href="mailto:Melinda.Ronca-Battista@nau.edu">Melinda.Ronca-Battista@nau.edu</a>
        <h4>
          <a href="https://www.youtube.com/c/melindaroncabattista">YouTube Videos</a>
        </h4>
        <h2 class="h4">
          Click on blue headers to sort
        </h4>
        <div id="table-wrapper" class="overflow-scroll">
          <input class="search" placeholder="Search Text" />
          <table class="table-light">
            <thead>
              <tr>
                <th class="sort" style="background-color:white;" data-sort="download2">Download</th></br>
                <th class="sort" data-sort="name">File Name</th>
                <th class="sort" data-sort="section">Section</th>
                <th class="sort" data-sort="type">File Type</th>
              </tr>
            </thead>
            <tbody class="list">
              {% for file in files %}
              <tr>
                <td ><a href="{{ file.link }}" onclick="var that=this;ga('send','event','FileDownload','{{file.name}}');setTimeout(function(){location.href=that.href;},200);return false;">Download</a></td>
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
