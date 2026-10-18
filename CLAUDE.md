# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Static portfolio site for Yuriko Goto (visual designer / illustrator), served by GitHub Pages at https://gotoyuriko.github.io from the `main` branch root. No build step, package manager, linter, or tests — pushing to `main` deploys.

Preview locally with any static server, e.g. `python3 -m http.server 8000`, then open http://localhost:8000.

## Architecture

- **Pages**: flat `*.html` files at the repo root. There are no templates or includes, so the header, burger-menu overlay (`#myMenu.overlay`), and footer are copy-pasted into every page. A nav/footer change must be made in all ten HTML files.
- **Styles**: one stylesheet, `assets/style.css`, shared by every page. It is split into banner-commented sections per page or component (`/* ===== GOODS ===== */` and so on), followed by three responsive blocks at the end: `max-width: 1024px`, `768px`, and `480px`. Put mobile overrides in those blocks, not inline.
- **Design tokens** (from the CSS header comment): font `'made_sunflower'` (a local OTF in `assets/made_sunflower/`, licensed for personal use only) and colors `#F3EEE8` and `#B60033`.
- **Script**: every page loads jQuery 3.6.0 from the Google CDN, then `assets/main.js`. That one file holds every page's behavior in separate `$(function(){...})` blocks (burger menu, gallery modal, `#community` parallax, contact/sign-up form handlers, fade-in, scroll-reveal via the `.left-to-right` / `.down-to-top` → `.scrollin` classes), and they all run on every page. So:
  - A selector that is missing on a page must not throw. The parallax block calls `$('#community h2').offset().top` with no guard, and it throws on pages that have no `#community`.
  - `$('div').hide().fadeIn(2000)` fades in every `<div>` on load.
- **No backend**: the forms are front-end only. The contact form shows a thank-you message and cancels submission. Login and sign-up are plain GET forms whose `action` is `inside-community.html`; sign-up only checks in JS that the two passwords match.
- **SEO**: `<head>` carries hand-written meta, Open Graph, and JSON-LD (`Person`) tags. Keep them consistent when adding pages.
