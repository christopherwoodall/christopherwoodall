## Welcome.

This is a collection of notes, projects, and occasional deep dives into whatever I’m currently curious about. Thanks for stopping by.

---

## Recent Posts
{% comment %} Filter notes by type: post and sort by date descending {% endcomment %}
{% assign blog_posts = site.notes | where: "type", "post" | sort: "date" | reverse %}

<ul class="post-list">
  {% for post in blog_posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span>{{ post.date | date: "%B %d, %Y" }}</span>
    </li>
  {% endfor %}
</ul>
