<html>
  <head>
  <link rel="stylesheet" type="text/css" href="/css/pico.min.css" />
  <title>
  {% block title %}Pothting{% endblock %}
  </title>
  </head>
  <body>
	<header class="container">
		<nav style="align: left">
		<ul>
		<hgroup>
			<li><h1>Pothting</h1></li>
		</hgroup>
		</ul>
		<ul>
			<li><a href="/">Home</a></li>
			<li><a href="/about">About</a></li>
			<li><a href="/login">Login</a></li>
		</ul>
		</nav>
	</header>
	<main>
    <div class="container" id="content">
    {% block content %} {% endblock %}
    </div>
	</main>
	<footer class="container" id="footer">
		<small>
		copyleft - George D. Hamilton (dminus) - 2026
		</small>
	</footer>
    {% debug %}
  </body>
  </html>
