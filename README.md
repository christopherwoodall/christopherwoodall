## Welcome.

This is a collection of notes, projects, and occasional deep dives into whatever I’m currently curious about.

---

## Recent Posts
{% comment %} 
  Pulling only items with 'layout: post' from the _notes collection
{% endcomment %}
{% assign blog_posts = site.notes | where: "layout", "post" | sort: "date" | reverse %}

<ul class="post-list">
  {% for post in blog_posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title | default: post.relative_path }}</a>
      <span>{{ post.date | date: "%B %d, %Y" }}</span>
    </li>
  {% else %}
    <li><small>No posts tagged with <em>layout: post</em> yet.</small></li>
  {% endfor %}
</ul>