$ErrorActionPreference = 'Stop'
$path = Join-Path (Split-Path -Parent $PSScriptRoot) 'index.html'
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$content = $content -replace '\.feature-list li::before \{ content: "[^"]*";', '.feature-list li::before { content: "\2713 ";'
$content = $content -replace '\.path-list li::before \{ content: "[^"]*";', '.path-list li::before { content: "\2022 ";'
$content = $content -replace '\.plan-list li::before \{ content: "[^"]*";', '.plan-list li::before { content: "\2713 ";'
$content = $content -replace '<span class="brand-mark">[^<]*</span>', '<span class="brand-mark">PN</span>'
$content = $content -replace 'class="testimonial-stars">[^<]*<', 'class="testimonial-stars">★★★★★<'
$content = $content -replace '<div class="side-item[^"]*">[^<]+</div>', {
    param($m)
    $text = $m.Value -replace '<[^>]+>', '' -replace '^\s*', ''
    if ($text -match 'Cobrar') { return '<div class="side-item active">Cobrar (POS)</div>' }
    if ($text -match 'Arqueo') { return '<div class="side-item">Arqueo y turno</div>' }
    if ($text -match 'Art') { return '<div class="side-item">Artículos</div>' }
    if ($text -match 'Clientes') { return '<div class="side-item">Clientes</div>' }
    if ($text -match 'Informes') { return '<div class="side-item">Informes</div>' }
    if ($text -match 'fiscal') { return '<div class="side-item">Centro fiscal AFIP</div>' }
    if ($text -match 'Sistema') { return '<div class="side-item">Sistema</div>' }
    return $m.Value
}

$content = $content -replace '<div class="feature-screen">[^<]*</div>', {
    param($m)
    switch -Regex ($m.Value) {
        'Y"S' { '<div class="feature-screen">KPI</div>' }
        "Y''" { '<div class="feature-screen">CLI</div>' }
        'Y"' { '<div class="feature-screen">STOCK</div>' }
        default { '<div class="feature-screen">CAJA</div>' }
    }
}

$content = $content -replace '<div class="afip-icon">[^<]*</div>', {
    param($m)
    if ($m.Value -match 'CAEA|conectividad') { return '<div class="afip-icon">CAEA</div>' }
    if ($m.Value -match 'Notas|cr.dito') { return '<div class="afip-icon">NC</div>' }
    if ($m.Value -match 'Lenguaje') { return '<div class="afip-icon">GUIA</div>' }
    return '<div class="afip-icon">CAE</div>'
}

$content = $content -replace 'facturaci.n electr.nica', 'facturación electrónica'
$content = $content -replace 'Operaci.n', 'Operación'
$content = $content -replace 'Importaci.n', 'Importación'
$content = $content -replace 'Reportes b.sicos', 'Reportes básicos'
$content = $content -replace 'Facturaci.n', 'Facturación'
$content = $content -replace 'M.ltiples', 'Múltiples'
$content = $content -replace 'Fidelizaci.n y cat.logo', 'Fidelización y catálogo'
$content = $content -replace 'exportaci.n', 'exportación'
$content = $content -replace 'd.as gratis', 'días gratis'
$content = $content -replace 'tambi.n', 'también'
$content = $content -replace '<td>S.</td>', '<td>Sí</td>'
$content = $content -replace '\+IVA .\s*', '+IVA · '
$content = $content -replace 'plan .+ datos mínimos .+ Mercado Pago .+ activación', 'plan → datos mínimos → Mercado Pago → activación'
$content = $content -replace 'v1\.0\.3 . Windows', 'v1.0.3 — Windows'
$content = $content -replace 'decidir . sin saltar', 'decidir — sin saltar'
$content = $content -replace 'misma caja . con lenguaje', 'misma caja — con lenguaje'
$content = $content -replace '<h3>.+Si falla internet.+</h3>', '<h3>«Si falla internet, la caja se cae.»</h3>'
$content = $content -replace '<h3>.+AFIP me complica.+</h3>', '<h3>«AFIP me complica cada venta.»</h3>'
$content = $content -replace '<h3>.+No sé qué se vende.+</h3>', '<h3>«No sé qué se vende, qué se repone y quién vuelve.»</h3>'
$content = $content -replace '<span>[^<]*7 días gratis</span>', '<span>7 días gratis</span>'
$content = $content -replace '<span>[^<]*30 días de garantía</span>', '<span>30 días de garantía</span>'
$content = $content -replace 'title="Ingresá con tu email[^"]*"', 'title="Ingresá con tu email — te enviamos un enlace seguro"'
$content = $content -replace '<div class="guarantee-icon">[^<]*</div>', '<div class="guarantee-icon">🛡️</div>'
$content = $content -replace 'Empezar 7 días gratis[^<]*</a>', 'Empezar 7 días gratis →</a>'
$content = $content -replace '<!-- SECCI.N TESTIMONIOS -->', '<!-- SECCIÓN TESTIMONIOS -->'

$utf8 = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($path, $content, $utf8)
Write-Host "Fixed encoding in $path"
