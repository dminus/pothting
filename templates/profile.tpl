{% extends "layouts/base.tpl" %}
{% block title %}
Profile - {{ target_user.nick }} - Pothting
{% endblock %}

{% block content %}
<h3>
<img src="data:image/png;base64,{{ target_user.avatar }}" alt="Avatar" width=64px height=64px> {{ target_user.nick }} (#{{ target_user.id }})</h3>
<ul>
<li>{{ target_user.bio }}
<li>Email: {{ target_user.email }}

{% endblock %}
