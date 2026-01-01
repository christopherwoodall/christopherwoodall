---
layout: post
title: "Configuring Jekyll and Github Pages"
date: 2025-12-30
tags: [ "github", "pages", "jekyll" ]
---

Enabling a Jekyll blog is pretty straight forward. Create a repository with the same name as your user name and add a [`_config.yaml`](https://docs.github.com/en/pages/quickstart) to the root of that repository.

If you want to display a separate page on GitHub then the one rendered as your default page then move your `README.md` to the `.github/` directory and create an `index.html` file (make sure to translate any markdown to html) in the root of the repository.


## Themes
- [Themes](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll)
