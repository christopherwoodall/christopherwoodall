---
layout: default
title: Notes
permalink: /notes/
tags: notes
---

# Technical Knowledge Base
A collection of deep-dives, cheat sheets, and research notes.

{% assign topics = site.notes | group_by_exp: "item", "item.relative_path | split: '/' | slice: 1 | first" %}

<div class="notes-grid">
  {% for topic in topics %}
    {% if topic.name != "README.md" %}
    <div class="topic-card">
      <h3>{{ topic.name | replace: "-", " " | capitalize }}</h3>
      <ul class="post-list">
        {% for note in topic.items %}
          {% assign filename = note.relative_path | split: "/" | last %}
          {% unless filename == "README.md" %}
          <li>
            <a href="{{ note.url | relative_url }}">{{ note.title | default: filename }}</a>
          </li>
          {% endunless %}
        {% endfor %}
      </ul>
    </div>
    {% endif %}
  {% endfor %}
</div>
