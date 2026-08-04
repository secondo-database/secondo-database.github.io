# SECONDO Website

Source for the [SECONDO](https://secondo-database.github.io/) database system website, published via GitHub Pages. Static Jekyll site — no build step is required for deployment, GitHub Pages builds it automatically on push.

## Running locally

Requires Ruby 3.0+ (macOS's built-in system Ruby is too old; install a current one via [Homebrew](https://brew.sh/)):

```sh
brew install ruby
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"
```

Add the `export PATH` line to your shell profile (`~/.zshrc`) so it's set automatically in new terminals, then install the gems and start the dev server:

```sh
bundle install
bundle exec jekyll serve
```

The site is served at `http://127.0.0.1:4000/` and rebuilds automatically as files change.

## Structure

- `_layouts/default.html` — shared page shell (head, sidebar nav, main content)
- `_includes/nav.html` — the sidebar navigation menu
- `secondo.css` — the site's single stylesheet
- `content_*.html` — page content, each with Jekyll front matter (`layout`, `title`, `description`)
- `index.html` — homepage
- `BerlinMOD/`, `ParallelSecondo/`, `DSecondo/` — sub-project pages, integrated into the shared layout
