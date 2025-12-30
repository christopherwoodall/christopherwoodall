## Welcome.

This is a collection of notes, projects, and occasional deep dives into whatever I’m currently curious about. Thanks for stopping by.

---

## Recent Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span>({{ post.date | date: "%B %d, %Y" }})</span>
    </li>
  {% endfor %}
</ul>
