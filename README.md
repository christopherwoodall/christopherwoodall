---
layout: default
title: Home
---

## Welcome.

This is a collection of notes, projects, and occasional deep dives into whatever I’m currently curious about. Thanks for stopping by.

---

## Notes

{% assign topics = site.notes | group_by_exp: "item", "item.relative_path | split: '/' | slice: 1 | first" %}

<div class="notes-grid">
  {% for topic in topics %}
    {% if topic.name != "README.md" %}
      
      {% comment %} Find the README for this specific topic {% endcomment %}
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
        <ul class="topic-note-list">
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