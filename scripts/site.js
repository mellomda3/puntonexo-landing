(function () {
  'use strict';

  // ── Mobile nav ──
  const menuBtn = document.getElementById('mobileMenuBtn');
  const mobileMenu = document.getElementById('mobileMenu');
  if (menuBtn && mobileMenu) {
    menuBtn.addEventListener('click', function () {
      const open = mobileMenu.classList.toggle('open');
      menuBtn.classList.toggle('open', open);
      menuBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    mobileMenu.querySelectorAll('a').forEach(function (a) {
      a.addEventListener('click', function () {
        mobileMenu.classList.remove('open');
        menuBtn.classList.remove('open');
        menuBtn.setAttribute('aria-expanded', 'false');
      });
    });
  }

  // ── FAQ ──
  window.toggleFaq = function (el) {
    const item = el.parentElement;
    const wasOpen = item.classList.contains('open');
    document.querySelectorAll('.faq-item.open').forEach(function (i) {
      i.classList.remove('open');
      const q = i.querySelector('.faq-q');
      if (q) q.setAttribute('aria-expanded', 'false');
    });
    if (!wasOpen) {
      item.classList.add('open');
      el.setAttribute('aria-expanded', 'true');
    } else {
      el.setAttribute('aria-expanded', 'false');
    }
  };

  // ── Config / versión / botón de descarga ──
  function applyConfig() {
    try {
      const cfg = window.PN_CONFIG || {};
      const version = cfg.releaseVersion || '2.8.15';
      const url =
        cfg.releaseDownloadUrl ||
        'https://github.com/mellomda3/puntonexo-releases/releases/latest';

      document.querySelectorAll('[data-version]').forEach(function (el) {
        el.textContent = version;
      });

      const dlBtn = document.getElementById('dl-btn');
      if (dlBtn && cfg.releaseDownloadUrl) {
        dlBtn.href = cfg.releaseDownloadUrl;
        dlBtn.textContent = 'Descargar gratis — v' + version;
      }

      const dlTitle = document.getElementById('dl-title');
      if (dlTitle) dlTitle.textContent = 'PuntoNexo Installer ' + version;
    } catch (e) {
      /* ignore */
    }
  }

  window.trackDownload = function () {
    if (typeof gtag === 'undefined') return;
    const btn = document.getElementById('dl-btn');
    if (!btn || !btn.href) return;
    gtag('event', 'file_download', {
      file_name: btn.href.split('/').pop(),
    });
  };

  window.toggleSha = function () {
    const box = document.getElementById('sha-box');
    if (box) box.classList.toggle('visible');
  };

  applyConfig();

  // ── Nav activo al scroll (solo en home) ──
  if (document.body.dataset.page === 'home') {
    const sections = ['como-funciona', 'funciones', 'precios', 'faq', 'descargar'];
    const links = document.querySelectorAll('.nav-links a[data-nav], .nav-mobile-menu a[data-nav]');

    function updateNav() {
      let current = '';
      const offset = 120;
      sections.forEach(function (id) {
        const el = document.getElementById(id);
        if (el && window.scrollY >= el.offsetTop - offset) current = id;
      });
      links.forEach(function (a) {
        a.classList.toggle('is-active', a.dataset.nav === current);
      });
    }

    window.addEventListener('scroll', updateNav, { passive: true });
    updateNav();
  }
})();
