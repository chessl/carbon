# carbon

A dark, minimal, text-first blog theme for [Bowen](https://github.com/chessl/bowen)
and [Zola](https://www.getzola.org/), adapted from
[~chess/carbon](https://git.sr.ht/~chess/carbon).

> **carbon**
> noun
>
> 1. A small static-site theme for writing-focused personal sites.

## Features

- [x] Bowen and Zola compatible templates
- [x] Minimal responsive layout
- [x] Automatic light and dark mode through `prefers-color-scheme`
- [x] Homepage recent-post listing
- [x] Section post listing
- [x] Tag taxonomy pages
- [x] Optional table of contents per page
- [x] Optional page changelog
- [x] RSS and Atom footer links
- [x] Optional inline Content Security Policy
- [x] Configurable header menu, favicon, keywords, copyright, and author email

## Contents and Configuration Guide

- [Installation](#installation)
  - [Bowen](#bowen)
  - [Zola](#zola)
- [Options](#options)
  - [Header Menu](#header-menu)
  - [Favicon](#favicon)
  - [SEO Metadata](#seo-metadata)
  - [Author Email](#author-email)
  - [Copyright](#copyright)
  - [Content Security Policy](#content-security-policy)
  - [Syntax Highlighting](#syntax-highlighting)
  - [Taxonomies](#taxonomies)
- [Content](#content)
  - [Posts](#posts)
  - [Table of Contents](#table-of-contents)
  - [Post Changelog](#post-changelog)
- [Development](#development)
- [Acknowledgements](#acknowledgements)

## Installation

### Bowen

Bowen can use this theme directly because it keeps Zola-compatible templates and
configuration.

First download the theme to your site's `themes` directory:

```bash
cd themes
git clone https://github.com/chessl/carbon
```

Then enable it in your `config.toml`:

```toml
theme = "carbon"
```

Run the site with Bowen:

```bash
bowen serve
```

Build the site with:

```bash
bowen build
```

This repository also includes a Nix development shell that provides a pinned
Bowen build:

```bash
nix develop
bowen serve
```

### Zola

The theme metadata declares Zola `0.19.0` as the minimum supported version.

Download the theme to your site's `themes` directory:

```bash
cd themes
git clone https://github.com/chessl/carbon
```

Enable it in `config.toml`:

```toml
theme = "carbon"
```

Run the site with Zola:

```bash
zola serve
```

The example `config.toml` in this repository includes Bowen-oriented Markdown
options such as `typst_math` and `render_d2`. If vanilla Zola rejects an option,
remove that option from your site config or use Bowen for those extensions.

---

## Options

Most theme options live under `[extra]` in `config.toml`.

```toml
[extra]
favicon = "/favicon.png"
author_email = "hello@example.com"
copyright = 'Content is <a href="https://creativecommons.org/licenses/by/4.0/">CC BY 4.0</a>.'
keywords = "blog, zola, carbon"
security = true
```

### Header Menu

Set the links shown in the header with `extra.menus`:

```toml
[[extra.menus]]
name = "Home"
url = "/"

[[extra.menus]]
name = "Posts"
url = "/posts/"

[[extra.menus]]
name = "About"
url = "/about/"
```

### Favicon

Set `extra.favicon` to the public path of your favicon:

```toml
[extra]
favicon = "/favicon.png"
```

Place the file under `static/`:

```text
static/
`-- favicon.png
```

### SEO Metadata

The theme reads standard site metadata from the root config:

```toml
title = "carbon"
description = "Minimalist blog theme"
author = "Chess Luo"
```

It also reads comma-separated keywords from `[extra]`:

```toml
[extra]
keywords = "blog, zola, carbon"
```

### Author Email

The footer includes a `mailto:` link using `extra.author_email`:

```toml
[extra]
author_email = "hello@example.com"
```

### Copyright

The footer renders `extra.copyright` as HTML:

```toml
[extra]
copyright = 'Content is <a href="https://creativecommons.org/licenses/by/4.0/">CC BY 4.0</a>.'
```

Only use trusted markup here because the value is rendered with `safe`.

### Content Security Policy

Set `extra.security = true` to emit a strict inline Content Security Policy:

```toml
[extra]
security = true
```

The built-in policy disables scripts and only allows self-hosted images:

```text
default-src 'none'; img-src 'self'; object-src 'none'; script-src 'none'; style-src 'unsafe-inline'
```

Set it to `false` if your site needs external images, scripts, analytics, or
embeds.

### Syntax Highlighting

The example config uses inline syntax highlighting:

```toml
[markdown.highlighting]
style = "inline"
theme = "catppuccin-mocha"
```

Bowen users can also keep the extra Markdown options shown in this repository's
sample config:

```toml
[markdown]
typst_math = true
render_d2 = true
render_emoji = true
github_alerts = true
insert_anchor_links = "heading"
```

For vanilla Zola, keep only the Markdown options supported by your installed
Zola version.

### Taxonomies

The theme includes templates for tag lists and tag detail pages. Enable the
`tags` taxonomy in `config.toml`:

```toml
taxonomies = [
  { name = "tags", feed = true },
]
```

---

## Content

### Posts

Put posts under `content/posts/` and create a section file at
`content/posts/_index.md`:

```text
content/
|-- _index.md
`-- posts/
    |-- _index.md
    `-- hello-world.md
```

A basic post:

```toml
+++
title = "Hello World"
date = 2026-06-14

[taxonomies]
tags = ["notes"]
+++
```

### Table of Contents

Enable a table of contents on a page by setting `toc = true` in front matter:

```toml
+++
title = "Long Post"
date = 2026-06-14
toc = true
+++
```

### Post Changelog

Pages can show a small changelog after the content:

```toml
+++
title = "Post With Changelog"
date = 2026-06-14

[extra]
changelog = [
  { date = "2026-06-14", commit = "Initial publication" },
  { date = "2026-06-15", commit = "Clarified setup notes" },
]
+++
```

---

## Development

Run the local demo with Bowen:

```bash
bowen serve
```

Check the site without rendering output:

```bash
bowen check
```

Build the static site:

```bash
bowen build
```

If you use Nix, enter the repository shell first:

```bash
nix develop
```

## Acknowledgements

- Original carbon theme by [chess](https://git.sr.ht/~chess/carbon)
- [Bowen](https://github.com/chessl/bowen), a Zola fork with additional
  Markdown and search capabilities
- [Zola](https://www.getzola.org/), the static site generator this theme remains
  compatible with
