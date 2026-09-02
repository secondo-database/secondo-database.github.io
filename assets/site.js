/* Progressive enhancements for the SECONDO site.
 *
 * Everything here is additive: with JS disabled the pages render exactly as
 * they do in the HTML, minus the copy buttons and the heading anchors.
 * Nothing in the layout depends on this file running.
 */
(function () {
  'use strict';

  /* ---------------------------------------------------------------- */
  /* Copy-to-clipboard on code blocks                                   */
  /* ---------------------------------------------------------------- */

  function initCopyButtons() {
    if (!navigator.clipboard || !navigator.clipboard.writeText) return;

    var main = document.querySelector('main');
    if (!main) return;

    /* A Rouge block is <figure class="highlight"><pre>; a plain block is a
       bare <pre>. Take the figure where there is one so the button sits
       outside the scrolling <pre>. */
    var blocks = [];
    main.querySelectorAll('figure.highlight, pre').forEach(function (el) {
      if (el.tagName === 'PRE' && el.closest('figure.highlight')) return;
      blocks.push(el);
    });

    blocks.forEach(function (block) {
      var wrap = document.createElement('div');
      wrap.className = 'code-block';
      block.parentNode.insertBefore(wrap, block);
      wrap.appendChild(block);

      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'copy-btn';
      btn.textContent = 'Copy';
      btn.setAttribute('aria-label', 'Copy code to clipboard');

      var timer = null;
      btn.addEventListener('click', function () {
        /* innerText, not textContent: it respects rendered line breaks and
           leaves the Rouge token spans behind */
        navigator.clipboard.writeText(block.innerText).then(function () {
          btn.textContent = 'Copied';
          btn.classList.add('copied');
          clearTimeout(timer);
          timer = setTimeout(function () {
            btn.textContent = 'Copy';
            btn.classList.remove('copied');
          }, 1500);
        }, function () {
          btn.textContent = 'Press ⌘C';
          clearTimeout(timer);
          timer = setTimeout(function () { btn.textContent = 'Copy'; }, 1500);
        });
      });

      wrap.appendChild(btn);
    });
  }

  /* ---------------------------------------------------------------- */
  /* Heading anchors                                                    */
  /* ---------------------------------------------------------------- */

  function slugify(text) {
    return text
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '');
  }

  function initHeadingAnchors() {
    var main = document.querySelector('main');
    if (!main) return;

    /* Hand-written ids are load-bearing -- content_dsecondo.html's page-toc
       links to them -- so existing ids are never rewritten, only reused. */
    var used = {};
    document.querySelectorAll('[id]').forEach(function (el) { used[el.id] = true; });

    main.querySelectorAll('h2, h3').forEach(function (h) {
      if (!h.id) {
        var base = slugify(h.textContent) || 'section';
        var id = base;
        var n = 2;
        while (used[id]) { id = base + '-' + n++; }
        h.id = id;
        used[id] = true;
      }

      var a = document.createElement('a');
      a.className = 'heading-anchor';
      a.href = '#' + h.id;
      a.textContent = '¶';
      a.setAttribute('aria-label', 'Link to this section');
      h.appendChild(a);
    });
  }

  initCopyButtons();
  initHeadingAnchors();
})();
