{% extends "layouts/base.tpl" %}

{% block title %}
Create post
{% endblock %}

{% block content %}
<form action="/article/new" method="POST">
	  <input type="text" name="title" id="title" placeholder="Title of post"/>
	  <input type="textarea" name="body" id="body" placeholder="Body of post" rows="15"/>
	  <input type="submit" value="Submit" width="30px"/>
</form>
{% endblock %}
