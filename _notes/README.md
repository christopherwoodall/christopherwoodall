---
layout: default
title: Notes
permalink: /notes/
---

# Notes
A collection of deep-dives, cheat sheets, and research notes.

{% assign topics = site.notes | group_by_exp: "item", "item.relative_path | split: '/' | slice: 1 | first" %}

<div class="notes-grid">
  {% for topic in topics %}
    {% if topic.name != "README.md" %}
      
      {% assign topic_readme_url = "" %}
      {% for item in topic.items %}
        {% assign filename = item.relative_path | split: "/" | last | downcase %}
        {% if filename == "readme.md" %}
          {% assign topic_readme_url = item.url %}
        {% endif %}
      {% endfor %}

      <div class="topic-card">
        <h3>
          {% if topic_readme_url != "" %}
            <a href="{{ topic_readme_url | relative_url }}">{{ topic.name | replace: "-", " " | capitalize }}</a>
          {% else %}
            {{ topic.name | replace: "-", " " | capitalize }}
          {% endif %}
        </h3>
        <ul class="post-list">
          {% for note in topic.items %}
            {% assign filename = note.relative_path | split: "/" | last | downcase %}
            {% unless filename == "readme.md" %}
            <li>
              <a href="{{ note.url | relative_url }}">{{ note.title | default: note.relative_path | split: "/" | last }}</a>
            </li>
            {% endunless %}
          {% endfor %}
        </ul>
      </div>
    {% endif %}
  {% endfor %}
</div>
