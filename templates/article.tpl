{% extends "layouts/base.tpl" %}
{% block title %}
  {{ viewed-article.title }} - Pothting
{% endblock %}
{% block content %}
<article id="viewed-article">
<h2 style="margin-bottom: 0px;">
  {{ viewed-article.title }}
</h2>
<hr size="50%">
  {{ viewed-article.body | md2html | safe }}
<footer><small><em>
	by <a href="/profile/{{ viewed-article.author-id }}">{{ viewed-article.author-nick }}</a>
	@ {{ viewed-article.updated-at }}
</em></small></footer>
</article>
{% endblock %}
