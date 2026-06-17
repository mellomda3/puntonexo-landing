const fs = require('fs');
const path = require('path');

const file = path.join(__dirname, '..', 'index.html');
let c = fs.readFileSync(file, 'utf8');

c = c.replace(/\.feature-list li::before \{ content: "[^"]*";/g, '.feature-list li::before { content: "\\2713 ";');
c = c.replace(/\.path-list li::before \{ content: "[^"]*";/g, '.path-list li::before { content: "\\2022 ";');
c = c.replace(/\.plan-list li::before \{ content: "[^"]*";/g, '.plan-list li::before { content: "\\2713 ";');
c = c.replace(/<span class="brand-mark">[^<]*<\/span>/g, '<span class="brand-mark">PN</span>');
c = c.replace(/class="testimonial-stars">[^<]*</g, 'class="testimonial-stars">★★★★★<');

const textFixes = [
  [/facturaci.n electr.nica/g, 'facturación electrónica'],
  [/Operaci.n/g, 'Operación'],
  [/Importaci.n/g, 'Importación'],
  [/Reportes b.sicos/g, 'Reportes básicos'],
  [/Facturaci.n/g, 'Facturación'],
  [/M.ltiples/g, 'Múltiples'],
  [/Fidelizaci.n y cat.logo/g, 'Fidelización y catálogo'],
  [/exportaci.n/g, 'exportación'],
  [/d.as gratis/g, 'días gratis'],
  [/tambi.n/g, 'también'],
  [/<td>S.<\/td>/g, '<td>Sí</td>'],
  [/\+IVA .\s*/g, '+IVA · '],
  [/plan .+ datos mínimos .+ Mercado Pago .+ activación/g, 'plan → datos mínimos → Mercado Pago → activación'],
  [/v1\.0\.3 . Windows/g, 'v1.0.3 — Windows'],
  [/decidir . sin saltar/g, 'decidir — sin saltar'],
  [/misma caja . con lenguaje/g, 'misma caja — con lenguaje'],
  [/<h3>.+Si falla internet.+<\/h3>/g, '<h3>«Si falla internet, la caja se cae.»</h3>'],
  [/<h3>.+AFIP me complica.+<\/h3>/g, '<h3>«AFIP me complica cada venta.»</h3>'],
  [/<h3>.+No sé qué se vende.+<\/h3>/g, '<h3>«No sé qué se vende, qué se repone y quién vuelve.»</h3>'],
  [/<span>[^<]*7 días gratis<\/span>/g, '<span>7 días gratis</span>'],
  [/<span>[^<]*30 días de garantía<\/span>/g, '<span>30 días de garantía</span>'],
  [/title="Ingresá con tu email[^"]*"/g, 'title="Ingresá con tu email — te enviamos un enlace seguro"'],
  [/<div class="guarantee-icon">[^<]*<\/div>/g, '<div class="guarantee-icon">🛡️</div>'],
  [/Empezar 7 días gratis[^<]*<\/a>/g, 'Empezar 7 días gratis →</a>'],
  [/<!-- SECCI.N TESTIMONIOS -->/g, '<!-- SECCIÓN TESTIMONIOS -->'],
];
for (const [re, rep] of textFixes) c = c.replace(re, rep);

c = c.replace(/<div class="side-item active">[^<]*<\/div>/, '<div class="side-item active">Cobrar (POS)</div>');
for (const label of ['Arqueo y turno', 'Artículos', 'Clientes', 'Informes', 'Centro fiscal AFIP', 'Sistema']) {
  c = c.replace(/<div class="side-item">[^<]*<\/div>/, `<div class="side-item">${label}</div>`);
}
for (const label of ['CAJA', 'STOCK', 'CLI', 'KPI']) {
  c = c.replace(/<div class="feature-screen">[^<]*<\/div>/, `<div class="feature-screen">${label}</div>`);
}
for (const label of ['CAE', 'CAEA', 'NC', 'GUIA']) {
  c = c.replace(/<div class="afip-icon">[^<]*<\/div>/, `<div class="afip-icon">${label}</div>`);
}

fs.writeFileSync(file, c, 'utf8');
console.log('Fixed', file);
