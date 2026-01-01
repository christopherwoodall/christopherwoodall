---
layout: default
title: "Miscellaneous Musimgs"
date: 2025-12-30
tags: [ "miscellaneous" ]
---

# Thoughts with no home

{% assign current_path = page.path | split: "/" %}
{% assign current_dir = current_path[1] %}

### Notes in {{ current_dir | capitalize }}

<ul class="post-list">
  {% assign category_notes = site.notes | where_exp: "item", "item.path contains current_dir" | sort: "date" | reverse %}
  
  {% for note in category_notes %}
    {% unless note.path contains "README.md" %}
      <li>
        <a href="{{ note.url | relative_url }}">
          {{ note.title | default: note.relative_path }}
        </a>
        <span class="post-date">{{ note.date | date: "%Y.%m.%d" }}</span>
      </li>
    {% endunless %}
  {% else %}
    <li><small>No notes found in this category.</small></li>
  {% endfor %}
</ul>
