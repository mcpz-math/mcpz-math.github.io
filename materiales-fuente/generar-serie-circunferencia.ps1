# Genera la "Serie 8. Circunferencia con centro en (0,0)" en Word (.docx):
#   - la Serie para los alumnos: 10 ejercicios en 4 partes y su rubrica con la matriz de niveles de Carmen;
#   - (opcional, -OutClave) la clave de respuestas para la profesora.
# Toma los textos de materiales-fuente\rubricas-por-actividad.json (bloque y actividad "serie8circorigen") y de matriz-niveles-evaluacion.json.
# Usa como base (estilos, fuentes, tema) cualquier otra Serie en Word de Carmen: -Base.
# Uso: powershell -ExecutionPolicy Bypass -File generar-serie-circunferencia.ps1 -Root <sitio> -Base <Serie.docx> -Out <serie.docx> [-OutClave <clave.docx>]
# Script solo ASCII: el texto con acentos viene del JSON (UTF-8).
# Mini-lenguaje de cada linea del JSON: "$x^2+y^2=$" = ecuacion de Word (con "^2" = exponente de un caracter);
# "@proc" = renglones de Procedimiento; "@por" = renglones de Porque; "@sdf" = casillas Sobre / Dentro / Fuera.
param([string]$Root, [string]$Base, [string]$Out, [string]$OutClave = '')
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$matriz = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\matriz-niveles-evaluacion.json'), $utf8) | ConvertFrom-Json
$act = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\rubricas-por-actividad.json'), $utf8) | ConvertFrom-Json
$s = $act.serie8circorigen
$ru = $act.actividades | Where-Object { $_.id -eq 'serie8circorigen' }
$et = $act.etiquetas
$bul = [string][char]0x2022
$dot = [char]0x00B7
$ii = [char]0x00ED
$boxOff = [string][char]0x2610
$nEj = $s.ejercicios.Count
$suma = 0; foreach ($pt in $s.partes) { $suma += [int]$pt.n }
if ($suma -ne $nEj) { throw "Las partes suman $suma ejercicios y hay $nEj." }

function Esc([string]$t) { return $t.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;') }
function Run([string]$t, [int]$sz = 0, [bool]$b = $false, [bool]$it = $false, [string]$font = '') {
  $p = ''
  if ($font -ne '') { $p += '<w:rFonts w:ascii="' + $font + '" w:hAnsi="' + $font + '" w:cs="' + $font + '"/>' }
  if ($b) { $p += '<w:b/>' }
  if ($it) { $p += '<w:i/>' }
  if ($sz -gt 0) { $p += '<w:sz w:val="' + $sz + '"/><w:szCs w:val="' + $sz + '"/>' }
  $rpr = ''
  if ($p -ne '') { $rpr = '<w:rPr>' + $p + '</w:rPr>' }
  return '<w:r>' + $rpr + '<w:t xml:space="preserve">' + (Esc $t) + '</w:t></w:r>'
}
function P([string]$runs, [int]$after = 120, [string]$extra = '') {
  return '<w:p><w:pPr><w:spacing w:after="' + $after + '"/>' + $extra + '</w:pPr>' + $runs + '</w:p>'
}

# ---- ecuaciones (OMML) ----
$cm = '<w:rPr><w:rFonts w:ascii="Cambria Math" w:hAnsi="Cambria Math"/></w:rPr>'
function MR([string]$t) { return '<m:r>' + $cm + '<m:t>' + (Esc $t) + '</m:t></m:r>' }
function MSup([string]$e, [string]$sup) {
  return '<m:sSup><m:sSupPr><m:ctrlPr>' + $cm + '</m:ctrlPr></m:sSupPr><m:e>' + $e + '</m:e><m:sup>' + $sup + '</m:sup></m:sSup>'
}
function MParse([string]$t) {
  $out = ''; $buf = ''; $pos = 0
  foreach ($m in [regex]::Matches($t, '\^(\w)')) {
    $buf += $t.Substring($pos, $m.Index - $pos)
    if ($buf -eq '') { throw "Exponente sin base en: $t" }
    $base = $buf.Substring($buf.Length - 1); $buf = $buf.Substring(0, $buf.Length - 1)
    if ($buf -ne '') { $out += (MR $buf); $buf = '' }
    $out += (MSup (MR $base) (MR $m.Groups[1].Value))
    $pos = $m.Index + $m.Length
  }
  $buf += $t.Substring($pos)
  if ($buf -ne '') { $out += (MR $buf) }
  return $out
}
function Mat([string]$t) { return '<m:oMath>' + (MParse $t) + '</m:oMath>' }

# texto con ecuaciones entre $...$ y casillas @sdf
$sz = 18
function Rico([string]$t, [int]$size = 18, [bool]$bold = $false) {
  $parts = $t.Split([char]'$')
  $r = ''
  for ($k = 0; $k -lt $parts.Count; $k++) {
    if (($k % 2) -eq 1) { $r += (Mat $parts[$k]); continue }
    $txt = $parts[$k]
    if ($txt.Contains('@sdf')) {
      $pre = $txt.Substring(0, $txt.IndexOf('@sdf'))
      if ($pre -ne '') { $r += (Run $pre $size $bold) }
      foreach ($o in $s.sdf) { $r += (Run $boxOff $size $false $false 'Segoe UI Symbol') + (Run (' ' + $o + '     ') $size) }
    } elseif ($txt -ne '') { $r += (Run $txt $size $bold) }
  }
  return $r
}

# ---- tablas ----
$bd = ''
foreach ($side in 'top', 'left', 'bottom', 'right', 'insideH', 'insideV') { $bd += '<w:' + $side + ' w:val="single" w:sz="4" w:space="0" w:color="808080"/>' }
function TblPr([int]$w) { return '<w:tblPr><w:tblW w:w="' + $w + '" w:type="dxa"/><w:jc w:val="center"/><w:tblBorders>' + $bd + '</w:tblBorders><w:tblLayout w:type="fixed"/><w:tblLook w:val="0000" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="0" w:noVBand="0"/></w:tblPr>' }
function Tc([int]$w, [string]$inner, [string]$fill = '', [int]$span = 1, [string]$va = 'center') {
  $pr = '<w:tcW w:w="' + $w + '" w:type="dxa"/>'
  if ($span -gt 1) { $pr += '<w:gridSpan w:val="' + $span + '"/>' }
  if ($fill -ne '') { $pr += '<w:shd w:val="clear" w:color="auto" w:fill="' + $fill + '"/>' }
  return '<w:tc><w:tcPr>' + $pr + '<w:vAlign w:val="' + $va + '"/></w:tcPr>' + $inner + '</w:tc>'
}
function Linea([string]$runs) { return (P $runs 70) }

function Celda([int]$i, [int]$w) {
  $e = $s.ejercicios[$i]; $n = $i + 1
  $txt = (P ((Run ([string]$n + '.  ') 22 $true) + (Rico $e.enunciado 20)) 100)
  foreach ($l in $e.lineas) {
    if ($l -eq '@proc') { $txt += (Linea (Run $s.lineaProc $sz)) + (Linea (Run $s.lineaProc2 $sz)) }
    elseif ($l -eq '@por') { $txt += (Linea (Run $s.lineaPor $sz)) + (Linea (Run $s.lineaPor2 $sz)) }
    else { $txt += (Linea (Rico $l $sz)) }
  }
  return (Tc $w $txt '' 1 'top')
}
function Tabla-Celdas($celdas, [int]$cols) {
  $w = [int](9740 / $cols)
  $grid = '<w:tblGrid>' + ((1..$cols | ForEach-Object { '<w:gridCol w:w="' + $w + '"/>' }) -join '') + '</w:tblGrid>'
  $rows = ''
  for ($k = 0; $k -lt $celdas.Count; $k += $cols) {
    $cs = ''
    for ($q = 0; $q -lt $cols; $q++) {
      if (($k + $q) -lt $celdas.Count) { $cs += $celdas[$k + $q] } else { $cs += (Tc $w (P '' 0)) }
    }
    $rows += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + $cs + '</w:tr>'
  }
  return '<w:tbl>' + (TblPr 9740) + $grid + $rows + '</w:tbl>'
}
function Titulo-Parte([string]$t) {
  return '<w:p><w:pPr><w:keepNext/><w:shd w:val="clear" w:color="auto" w:fill="E2EFDA"/><w:spacing w:before="200" w:after="60"/></w:pPr>' + (Run $t 20 $true) + '</w:p>'
}

# ---- clave ----
function Clave-Tabla() {
  $wN = 700; $wR = 9040
  $fillH = 'E2EFDA'
  $h = (Tc $wN (P (Run ('N' + [char]0x00B0) 18 $true) 0) $fillH) + (Tc $wR (P (Run 'Respuestas' 18 $true) 0) $fillH)
  $rr = '<w:tr><w:trPr><w:cantSplit/><w:tblHeader/><w:jc w:val="center"/></w:trPr>' + $h + '</w:tr>'
  for ($i = 0; $i -lt $nEj; $i++) {
    $e = $s.ejercicios[$i]
    $ps = ''
    foreach ($c in $e.clave) { $ps += (P (Rico $c 19) 40) }
    $rr += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + (Tc $wN (P (Run ([string]($i + 1)) 19 $true) 0)) + (Tc $wR $ps '' 1 'top') + '</w:tr>'
  }
  $grid = '<w:tblGrid><w:gridCol w:w="' + $wN + '"/><w:gridCol w:w="' + $wR + '"/></w:tblGrid>'
  return '<w:tbl>' + (TblPr 9740) + $grid + $rr + '</w:tbl>'
}

$secV = '<w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1250" w:right="1250" w:bottom="1250" w:left="1250" w:header="708" w:footer="708" w:gutter="0"/><w:cols w:space="720"/></w:sectPr>'
$secH = '<w:sectPr><w:pgSz w:w="15840" w:h="12240" w:orient="landscape"/><w:pgMar w:top="1000" w:right="1000" w:bottom="1000" w:left="1000" w:header="708" w:footer="708" w:gutter="0"/><w:cols w:space="720"/></w:sectPr>'
$ns = 'xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"'

# ---- rubrica (matriz de niveles), en hoja horizontal ----
function Rubrica-Xml() {
  $wC = 2800; $wN = 2208
  $tot = $wC + 5 * $wN
  $fillH = 'E2EFDA'
  $hd = @(
    @('Nivel 1', 'Insuficiente'),
    @('Nivel 2', 'En desarrollo'),
    @('Nivel 3', ('En desarrollo ' + $dot + ' m' + $ii + 'nimo indispensable')),
    @('Nivel 4', 'Suficiente'),
    @('Nivel 5', 'Satisfactorio')
  )
  $h = (Tc $wC (P (Run $et.criterio 18 $true) 0) $fillH)
  foreach ($c in $hd) { $h += (Tc $wN ((P (Run $c[0] 18 $true) 0) + (P (Run $c[1] 15) 0)) $fillH) }
  $rr = '<w:tr><w:trPr><w:cantSplit/><w:tblHeader/><w:jc w:val="center"/></w:trPr>' + $h + '</w:tr>'
  foreach ($row in $ru.rows) {
    $c = $matriz.comp.($row.id)
    $nm = $c.nombre
    if ($c.sub -ne '') { $nm += ' (' + $c.sub + ')' }
    $crit = (P (Run $nm 18 $true) 40) + (P (Run $c.criterio 15 $false $true) 60) + (P (Run ($et.observar + ':') 16 $true) 20)
    foreach ($o in $row.observar) { $crit += (P ((Run ($bul + ' ') 16) + (Run $o 16)) 20 '<w:ind w:left="170" w:hanging="170"/>') }
    $cells = (Tc $wC $crit 'F2F2F2')
    $cells += (Tc $wN (P (Run $row.n1 16) 0))
    if ($row.id -eq 'ARG') {
      $cells += (Tc $wN (P (Run $row.n2 16) 0)) + (Tc $wN (P (Run $row.n3 16) 0))
      $cells += (Tc $wN (P (Run $row.n4 16) 0)) + (Tc $wN (P (Run $row.n5 16) 0))
    } elseif ($row.id -eq 'MOD') {
      $cells += (Tc ($wN * 2) (P (Run $row.n23 16) 0) '' 2)
      $cells += (Tc ($wN * 2) (P (Run $row.n45 16) 0) '' 2)
    } else {
      $cells += (Tc ($wN * 2) (P (Run $row.n23 16) 0) '' 2)
      $cells += (Tc $wN (P (Run $row.n4 16) 0)) + (Tc $wN (P (Run $row.n5 16) 0))
    }
    $rr += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
  }
  $grid = '<w:tblGrid><w:gridCol w:w="' + $wC + '"/>' + ((1..5 | ForEach-Object { '<w:gridCol w:w="' + $wN + '"/>' }) -join '') + '</w:tblGrid>'
  $x = (P (Run $s.rubricaTitulo 0 $true) 80) + '<w:tbl>' + (TblPr $tot) + $grid + $rr + '</w:tbl>'
  $n0 = $et.guiaNota0
  $cut = $n0.IndexOf(':')
  $x += (P ((Run $n0.Substring(0, $cut + 1) 17 $true) + (Run $n0.Substring($cut + 1) 17)) 0)
  return $x
}

# ---- empaquetar: copia el paquete base y cambia document.xml ----
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Empaqueta([string]$destino, [string]$docXml) {
  if (Test-Path -LiteralPath $destino) { throw "Ya existe $destino; no se sobrescribe." }
  $src = [IO.Compression.ZipFile]::OpenRead($Base)
  $fs = [IO.File]::Open($destino, [IO.FileMode]::CreateNew)
  $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
  foreach ($e in $src.Entries) {
    $ne = $zip.CreateEntry($e.FullName); $o = $ne.Open()
    if ($e.FullName -eq 'word/document.xml') { $bytes = $utf8.GetBytes($docXml); $o.Write($bytes, 0, $bytes.Length) }
    else { $i = $e.Open(); $i.CopyTo($o); $i.Close() }
    $o.Close()
  }
  $zip.Dispose(); $fs.Close(); $src.Dispose()
  "Listo: $destino ($((Get-Item -LiteralPath $destino).Length) bytes)"
}

# ======== SERIE DE LOS ALUMNOS ========
$B = New-Object System.Collections.Generic.List[string]
$B.Add((P (Run $s.titulo 32 $true) 60))
$B.Add((P (Run $s.autor) 160))
$B.Add((P (Run $s.estudiante 20) 200))
$B.Add((P (Run $s.propositoTitulo 0 $true) 60))
$B.Add((P (Run $s.proposito) 200 '<w:jc w:val="both"/>'))
$B.Add((P (Run $s.instruccionesTitulo 0 $true) 60))
$B.Add((P (Run $s.instruccionesIntro) 80))
$letras = 'a', 'b', 'c', 'd', 'e'
for ($q = 0; $q -lt $s.pasos.Count; $q++) {
  $B.Add((P ((Run ($letras[$q] + ')  ') 0 $true) + (Run $s.pasos[$q])) 40 '<w:ind w:left="567" w:hanging="283"/>'))
}
$B.Add((P '' 80))
$ini = 0
foreach ($pt in $s.partes) {
  $celdas = @()
  for ($i = $ini; $i -lt ($ini + [int]$pt.n); $i++) { $celdas += (Celda $i 4870) }
  $B.Add((Titulo-Parte $pt.titulo)); $B.Add((Tabla-Celdas $celdas 2))
  $ini += [int]$pt.n
}
$B.Add((P '' 0))
$B.Add('<w:p><w:pPr><w:spacing w:after="0"/>' + $secV + '</w:pPr></w:p>')
$B.Add((Rubrica-Xml))
$doc = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($B -join '') + $secH + '</w:body></w:document>'
Empaqueta $Out $doc

# ======== CLAVE PARA LA PROFESORA ========
if ($OutClave -ne '') {
  $B = New-Object System.Collections.Generic.List[string]
  $B.Add((P (Run $s.claveTitulo 28 $true) 60))
  $B.Add((P (Run $s.titulo 20) 100))
  $B.Add((P (Run $s.claveNota 18 $false $true) 160 '<w:jc w:val="both"/>'))
  $B.Add((Clave-Tabla))
  $B.Add((P '' 0))
  $docC = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($B -join '') + $secV + '</w:body></w:document>'
  Empaqueta $OutClave $docC
}
