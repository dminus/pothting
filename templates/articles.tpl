{% extends "layouts/base.tpl" %}
{% block title %}Articles - Pothting{% endblock %}
{% block content %}
	{% for article in articles %}
	<article id="article_{{ article.id }}">
	<h2><a href="/article/{{ article.id }}">{{ article.title }}</a></h2>
		<em>by {{ article.author-nick }} at {{ article.created-at }}</em>
    </article>
      {% endfor %}
    </ul>
{% endblock %}
