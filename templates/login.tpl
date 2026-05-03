
{% extends "layouts/base.tpl" %}
{% block title %}
   Login - Pothting
{% endblock %}
{% block content %}
<form method="POST" action="/login">
<input type="email" 	placeholder="who@are.you?" name="login[username]" />
<input type="password"  placeholder="password" name="login[password]" />
<input type="submit" value="Login" />
</form>
{% endblock %}
