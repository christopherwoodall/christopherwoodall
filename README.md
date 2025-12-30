## Welcome.

This is a collection of notes, projects, and occasional deep dives into whatever I’m currently curious about. Thanks for stopping by.

---

## Recent Posts

<ul class="post-list">
  {% assign blog_posts = site.notes | where: "type", "post" | sort: "date" | reverse %}
  {% for post in blog_posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span>{{ post.date | date: "%B %d, %Y" }}</span>
    </li>
  {% endfor %}
</ul>


<hr>

{% assign topics = site.notes | group_by_exp: "item", "item.relative_path | split: '/' | slice: 1 | first" %}

<div class="notes-grid">
  {% for topic in topics %}
    {% comment %} Skip the root README.md of the notes folder {% endcomment %}
    {% if topic.name != "README.md" %}
    <div class="topic-card">
      <h3>{{ topic.name | replace: "-", " " | capitalize }}</h3>
      <ul class="topic-note-list">
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

