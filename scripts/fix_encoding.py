import re
from pathlib import Path

path = Path(__file__).resolve().parent.parent / "index.html"
c = path.read_text(encoding="utf-8")

c = re.sub(r'\.feature-list li::before \{ content: "[^"]*";', r'.feature-list li::before { content: "\\2713 ";', c)
c = re.sub(r'\.path-list li::before \{ content: "[^"]*";', r'.path-list li::before { content: "\\2022 ";', c)
c = re.sub(r'\.plan-list li::before \{ content: "[^"]*";', r'.plan-list li::before { content: "\\2713 ";', c)
c = re.sub(r'<span class="brand-mark">[^<]*</span>', '<span class="brand-mark">PN</span>', c)
c = re.sub(r'class="testimonial-stars">[^<]*<', 'class="testimonial-stars">★★★★★<', c)

replacements = [
    (r"facturaci.n electr.nica", "facturación electrónica"),
    (r"Operaci.n", "Operación"),
    (r"Importaci.n", "Importación"),
    (r"Reportes b.sicos", "Reportes básicos"),
    (r"Facturaci.n", "Facturación"),
    (r"M.ltiples", "Múltiples"),
    (r"Fidelizaci.n y cat.logo", "Fidelización y catálogo"),
    (r"exportaci.n", "exportación"),
    (r"d.as gratis", "días gratis"),
    (r"tambi.n", "también"),
    (r"<td>S.</td>", "<td>Sí</td>"),
    (r"\+IVA .\s*", "+IVA · "),
    (r"plan .+ datos mínimos .+ Mercado Pago .+ activación", "plan → datos mínimos → Mercado Pago → activación"),
    (r"v1\.0\.3 . Windows", "v1.0.3 — Windows"),
    (r"decidir . sin saltar", "decidir — sin saltar"),
    (r"misma caja . con lenguaje", "misma caja — con lenguaje"),
]
for pat, rep in replacements:
    c = re.sub(pat, rep, c)

c = re.sub(r"<h3>.+Si falla internet.+</h3>", "<h3>«Si falla internet, la caja se cae.»</h3>", c)
c = re.sub(r"<h3>.+AFIP me complica.+</h3>", "<h3>«AFIP me complica cada venta.»</h3>", c)
c = re.sub(r"<h3>.+No sé qué se vende.+</h3>", "<h3>«No sé qué se vende, qué se repone y quién vuelve.»</h3>", c)

c = re.sub(r'<div class="side-item active">[^<]*</div>', '<div class="side-item active">Cobrar (POS)</div>', c, count=1)
for label in ["Arqueo y turno", "Artículos", "Clientes", "Informes", "Centro fiscal AFIP", "Sistema"]:
    c = re.sub(r'<div class="side-item">[^<]*</div>', f'<div class="side-item">{label}</div>', c, count=1)

for label in ["CAJA", "STOCK", "CLI", "KPI"]:
    c = re.sub(r'<div class="feature-screen">[^<]*</div>', f'<div class="feature-screen">{label}</div>', c, count=1)

for label in ["CAE", "CAEA", "NC", "GUIA"]:
    c = re.sub(r'<div class="afip-icon">[^<]*</div>', f'<div class="afip-icon">{label}</div>', c, count=1)

c = re.sub(r'<span>[^<]*7 días gratis</span>', "<span>7 días gratis</span>", c)
c = re.sub(r'<span>[^<]*30 días de garantía</span>', "<span>30 días de garantía</span>", c)
c = re.sub(r'title="Ingresá con tu email[^"]*"', 'title="Ingresá con tu email — te enviamos un enlace seguro"', c)
c = re.sub(r'<div class="guarantee-icon">[^<]*</div>', '<div class="guarantee-icon">🛡️</div>', c)
c = re.sub(r"Empezar 7 días gratis[^<]*</a>", "Empezar 7 días gratis →</a>", c)
c = re.sub(r"<!-- SECCI.N TESTIMONIOS -->", "<!-- SECCIÓN TESTIMONIOS -->", c)

path.write_text(c, encoding="utf-8", newline="\n")
print(f"Fixed {path}")
