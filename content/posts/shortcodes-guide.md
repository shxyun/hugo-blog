+++
title = "Content Components Toolbox"
date = 2026-10-10T10:00:00+08:00
draft = false
tags = ["Toolbox", "Guide"]
categories = ["Site Guide"]
summary = "A live demo of every shortcode component on this site: affiliate product cards, coupon codes, download cards, YouTube, Spotify, media players, callouts and more."
language = "en"
+++

This page demonstrates **every content component** available on this site. When writing a post, copy the markup from any code block below, paste it into your Markdown draft, and replace the sample values with your own. All components support light and dark mode.

## 1. Affiliate Product Card

A mobile-friendly product card for Amazon Associates or any affiliate program. The outbound link is automatically tagged with `rel="nofollow sponsored noopener"`.

**Syntax:**

```
{{</* product img="https://example.com/product.jpg" badge="Best Pick" title="Product Name" desc="A one-line description of the product." old="$99.99" price="$69.99" rating="4.7" link="https://www.amazon.com/" btn="Check Price on Amazon" */>}}
```

All parameters except `title` and `link` are optional. `badge`, `old` (strikethrough price), and `rating` can be omitted.

**Result:**

{{< product img="/images/shortcodes-demo-product.jpg" badge="Best Pick" title="Aurora Wireless Noise-Cancelling Headphones" desc="40-hour battery, plush memory-foam ear cups, and class-leading ANC for travel and home office." old="$99.99" price="$69.99" rating="4.7" link="https://www.amazon.com/" btn="Check Price on Amazon" >}}

{{< alert type="info" title="Affiliate disclosure" >}}
If you earn commissions, add a short FTC-style disclosure near the card, for example: *"As an Amazon Associate I earn from qualifying purchases."*
{{< /alert >}}

## 2. Coupon Code

A one-click copyable coupon or promo code — a familiar pattern for Shopify, Gumroad and online-store readers.

**Syntax:**

```
{{</* coupon code="SAVE20" title="20% off your first order" note="Enter the code at checkout. Click to copy." */>}}
```

**Result:**

{{< coupon code="SAVE20" title="20% off your first order" note="Enter the code at checkout. Click to copy." >}}

## 3. Download Card

A resource card for file sharing on Google Drive, Dropbox, OneDrive, MEGA, Gumroad, GitHub, iCloud, MediaFire, TeraBox or a direct link. Each platform gets its own brand-colored badge.

**Syntax:**

```
{{</* drive platform="Google Drive" name="Free Resource Pack (PDF, 42 MB)" url="https://drive.google.com/" code="AB12-CD34" */>}}
```

Parameters: `platform` (drives the badge color), `name`, `url`, `code` (optional access code), `btn` (optional, defaults to **Download**).

**Result:**

{{< drive platform="Google Drive" name="Free Resource Pack (PDF, 42 MB)" url="https://drive.google.com/" code="AB12-CD34" >}}

{{< drive platform="Dropbox" name="Bonus Templates (ZIP, 18 MB)" url="https://www.dropbox.com/" >}}

## 4. YouTube Video

Pass either a video `id` or a full `url`. The player is responsive (16:9).

**Syntax:**

```
{{</* youtube id="jNQXAC9IVRw" title="Me at the zoo" */>}}
```

**Result:**

{{< youtube id="jNQXAC9IVRw" title="Me at the zoo" >}}

## 5. Spotify Player

Embed a Spotify `track`, `album`, `playlist`, `episode` or `show`. The ID is the last part of the Spotify share URL.

**Syntax:**

```
{{</* spotify type="playlist" id="37i9dQZF1DXcBWIGoYBM5M" */>}}
```

**Result:**

{{< spotify type="playlist" id="37i9dQZF1DXcBWIGoYBM5M" >}}

## 6. Local Video and Audio

Put media files in your `static/` folder (for example `static/media/demo.mp4`) and reference them with an absolute path. Audio files (`.mp3`, `.m4a`, `.wav`, `.ogg`, `.aac`, `.flac`) render as an audio player automatically.

**Syntax:**

```
{{</* video src="/media/demo.mp4" poster="/media/poster.jpg" */>}}
{{</* video src="/media/demo.mp3" */>}}
```

**Result (hosted samples used for demonstration):**

{{< video src="https://media.w3.org/2010/05/sintel/trailer.mp4" >}}

{{< video src="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3" >}}

{{< alert type="warning" title="Tip" >}}
Avoid committing large media files to Git — repositories quickly become slow. Host big videos on YouTube and embed them instead.
{{< /alert >}}

## 7. Callout Boxes

Highlight notes, warnings, tips or successes. Types: `info`, `success`, `warning`, `error`.

**Syntax:**

```
{{</* alert type="warning" title="Heads up" */>}}
This is the callout body. **Markdown is supported.**
{{</* /alert */>}}
```

**Result:**

{{< alert type="info" title="Note" >}}
This is a neutral info callout.
{{< /alert >}}

{{< alert type="success" title="Done" >}}
Your changes were saved successfully.
{{< /alert >}}

{{< alert type="warning" >}}
A warning without a title.
{{< /alert >}}

{{< alert type="error" title="Error" >}}
Something went wrong. Please try again.
{{< /alert >}}

## 8. Collapsible Block (FAQ)

A native `<details>` block, perfect for FAQ sections or optional extra content. Add `open="true"` to expand it by default.

**Syntax:**

```
{{</* collapse title="Do I need to know any code?" */>}}
No — just copy the snippet and change the text.
{{</* /collapse */>}}
```

**Result:**

{{< collapse title="Do I need to know any code?" >}}
No. Every component is plain copy-and-paste Markdown — paste the snippet, swap the sample values, and publish.
{{< /collapse >}}

{{< collapse title="Can I change the colors?" >}}
Yes. Each component has its own file under `layouts/shortcodes/`; edit the CSS variables at the bottom of the file.
{{< /collapse >}}

## 9. Newsletter Form

A Buttondown-powered subscribe box. Readers can opt in without leaving the page.

**Syntax:**

```
{{</* subscribe */>}}
```

Optional parameters: `title`, `desc`, `ph` (placeholder), `btn`.

**Result:**

{{< subscribe >}}

---

That is the full toolbox. New components will be added to this page as they are built.
