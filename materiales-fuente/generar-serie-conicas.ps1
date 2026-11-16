# Genera la "Serie 7. Introduccion a las conicas: que conica es?" en Word (.docx):
#   - la Serie para los alumnos: 20 ejercicios (17 de clasificar con A y C + 3 de "que valor debe tener C"), y su rubrica con la matriz de niveles;
#   - (opcional, -OutClave) la clave de respuestas para la profesora.
# Toma los textos de materiales-fuente\rubricas-por-actividad.json (bloque y actividad "serie7conicas") y de matriz-niveles-evaluacion.json.
# Usa como base (estilos, fuentes, tema) cualquier otra Serie en Word de Carmen: -Base.
# Uso: powershell -ExecutionPolicy Bypass -File generar-serie-conicas.ps1 -Root <sitio> -Base <Serie.docx> -Out <serie.docx> [-OutClave <clave.docx>]
# Script solo ASCII: el texto con acentos viene del JSON (UTF-8).
# Mini-lenguaje de las ecuaciones del JSON: "x^2" = exponente de un solo caracter (se aplica al caracter anterior).
param([string]$Root, [string]$Base, [string]$Out, [string]$OutClave = '')
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$matriz = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\matriz-niveles-evaluacion.json'), $utf8) | ConvertFrom-Json
$act = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\rubricas-por-actividad.json'), $utf8) | ConvertFrom-Json
$s = $act.serie7conicas
$ru = $act.actividades | Where-Object { $_.id -eq 'serie7conicas' }
$et = $act.etiquetas
$bul = [string][char]0x2022
$dot = [char]0x00B7
$ii = [char]0x00ED
$boxOff = [string][char]0x2610
if ($s.ejercicios.Count -ne 17) { throw "Se esperaban 17 ejercicios de clasificar y hay $($s.ejercicios.Count)." }
if ($s.claveC.Count -ne 3) { throw 'Se esperaban 3 ejercicios de C.' }

# ---- comprobacion de la clave: tipo segun A y C (0 circ, 1 elipse, 2 parabola, 3 hiperbola) ----
function Tipo([int]$a, [int]$c) {
  if ($a -eq 0 -and $c -eq 0) { return -1 }
  if ($a -eq 0 -or $c -eq 0) { return 2 }
  if ($a -eq $c) { return 0 }
  if (($a -gt 0) -eq ($c -gt 0)) { return 1 }
  return 3
}
$k = 0
foreach ($e in $s.ejercicios) {
  $k++
  if ((Tipo ([int]$e.A) ([int]$e.C)) -ne [int]$e.t) { throw "Ejercicio ${k}: la clave no coincide con A y C." }
}

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
function Mat([string]$t) { return '<m:oMath>' + (MParse $t) + '</m:oMath>' }   # ecuacion en linea

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

# ---- celdas de un ejercicio ----
$sz = 18
function Linea([string]$runs) { return (P $runs 60) }
function Opciones([int]$marca) {   # dos renglones de casillas (en la clave se marca la correcta con una X)
  $r = @('', '')
  for ($j = 0; $j -lt 4; $j++) {
    $c = $boxOff; $b = $false
    if ($j -eq $marca) { $c = [string][char]0x2612; $b = $true }
    $r[[int][Math]::Floor($j / 2)] += (Run $c $sz $false $false 'Segoe UI Symbol') + (Run (' ' + $s.opciones[$j] + '      ') $sz $b)
  }
  return (Linea $r[0]) + (Linea $r[1])
}
function Celda-Clasif([int]$i, [int]$w) {
  $e = $s.ejercicios[$i]; $n = $i + 1
  $txt = (P ((Run ([string]$n + '.  ') 22 $true) + (Mat $e.eq)) 100)
  if ($e.ord) { $txt += (Linea (Run $s.lineaOrd $sz)) }
  $txt += (Linea (Run $s.lineaAC $sz))
  $txt += (Opciones -1)
  $txt += (Linea (Run $s.lineaPorque $sz))
  $txt += (Linea (Run $s.lineaPorque2 $sz))
  return (Tc $w $txt '' 1 'top')
}
function Celda-ValorC([int]$j, [int]$w) {
  $n = 18 + $j
  $txt = (P ((Run ([string]$n + '.  ') 22 $true) + (Run $s.preguntas[$j] 20)) 100)
  if ($j -eq 2) { $txt += (Linea (Run $s.lineaC2 $sz)) } else { $txt += (Linea (Run $s.lineaC $sz)) }
  $txt += (Linea (Run $s.lineaPorque $sz))
  $txt += (Linea (Run $s.lineaPorque2 $sz))
  return (Tc $w $txt '' 1 'top')
}
function Tabla-Celdas($celdas, [int]$cols) {   # $celdas = lista de bloques de celda (cada uno ya con su ancho)
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
  $wN = 520; $wE = 3300; $wA = 700; $wC = 700; $wT = 1500; $wP = 3020
  $fillH = 'E2EFDA'
  $h = (Tc $wN (P (Run ('N' + [char]0x00B0) 18 $true) 0) $fillH) +
       (Tc $wE (P (Run ('Ecuaci' + [char]0x00F3 + 'n (ordenada, si hac' + $ii + 'a falta)') 18 $true) 0) $fillH) +
       (Tc $wA (P (Run 'A' 18 $true) 0) $fillH) + (Tc $wC (P (Run 'C' 18 $true) 0) $fillH) +
       (Tc $wT (P (Run ('C' + [char]0x00F3 + 'nica') 18 $true) 0) $fillH) + (Tc $wP (P (Run 'Porque' 18 $true) 0) $fillH)
  $rr = '<w:tr><w:trPr><w:cantSplit/><w:tblHeader/><w:jc w:val="center"/></w:trPr>' + $h + '</w:tr>'
  for ($i = 0; $i -lt 17; $i++) {
    $e = $s.ejercicios[$i]
    $eq = $e.eq; if ($e.ord) { $eq = $e.ord }
    $minus = [string][char]0x2212
    $a = ([string]$e.A).Replace('-', $minus); $c = ([string]$e.C).Replace('-', $minus)
    $cells = (Tc $wN (P (Run ([string]($i + 1)) 18 $true) 0)) + (Tc $wE (P (Mat $eq) 0)) +
             (Tc $wA (P (Run $a 18) 0)) + (Tc $wC (P (Run $c 18) 0)) +
             (Tc $wT (P (Run $s.opciones[[int]$e.t] 18 $true) 0)) + (Tc $wP (P (Run $s.razones[[int]$e.t] 17) 0))
    $rr += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
  }
  for ($j = 0; $j -lt 3; $j++) {
    $cc = $s.claveC[$j]
    $cells = (Tc $wN (P (Run ([string](18 + $j)) 18 $true) 0)) +
             (Tc ($wE + $wA + $wC + $wT) (P (Run $cc.resp 18 $true) 0) '' 4) + (Tc $wP (P (Run $cc.por 17) 0))
    $rr += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
  }
  $grid = '<w:tblGrid><w:gridCol w:w="' + $wN + '"/><w:gridCol w:w="' + $wE + '"/><w:gridCol w:w="' + $wA + '"/><w:gridCol w:w="' + $wC + '"/><w:gridCol w:w="' + $wT + '"/><w:gridCol w:w="' + $wP + '"/></w:tblGrid>'
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
# Parte 1 (1-8) y Parte 2 (9-14): dos columnas
$c1 = @(); for ($i = 0; $i -lt 8; $i++) { $c1 += (Celda-Clasif $i 4870) }
$B.Add((Titulo-Parte $s.partes[0])); $B.Add((Tabla-Celdas $c1 2))
$c2 = @(); for ($i = 8; $i -lt 14; $i++) { $c2 += (Celda-Clasif $i 4870) }
$B.Add((Titulo-Parte $s.partes[1])); $B.Add((Tabla-Celdas $c2 2))
# Parte 3 (15-17): una columna
$c3 = @(); for ($i = 14; $i -lt 17; $i++) { $c3 += (Celda-Clasif $i 9740) }
$B.Add((Titulo-Parte $s.partes[2])); $B.Add((Tabla-Celdas $c3 1))
# Parte 4 (18-20): una columna
$B.Add((Titulo-Parte $s.partes[3]))
$B.Add((P ((Run ($s.parte4Antes + ' ') 20) + (Mat $s.parte4Eq) + (Run (' ' + $s.parte4Despues) 20)) 80))
$c4 = @(); for ($j = 0; $j -lt 3; $j++) { $c4 += (Celda-ValorC $j 9740) }
$B.Add((Tabla-Celdas $c4 1))
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
