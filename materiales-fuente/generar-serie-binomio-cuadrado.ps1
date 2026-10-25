# Genera una Serie de "Binomio al cuadrado" (Serie 2, 3...) o de "Trinomio cuadrado perfecto" (serie1tcp, con
# "tipo": "trinomio" en el JSON: se muestra el trinomio tal cual) en Word (.docx) con 20 ejercicios y su rubrica
# (matriz de niveles de Carmen). Mismo formato de la Serie 1 en Word: titulo, Estudiante / Fecha / Grupo,
# proposito, instrucciones, tabla de 20 ejercicios en dos bloques (1-10 y 11-20) con ecuaciones de Word.
# Toma los textos de materiales-fuente\rubricas-por-actividad.json (bloque y actividad con el id de -Serie, p. ej. "serie2cuad")
# y de matriz-niveles-evaluacion.json. Usa como base (estilos, fuentes, tema) cualquier otra Serie en Word de Carmen: -Base.
# Uso: powershell -ExecutionPolicy Bypass -File generar-serie-binomio-cuadrado.ps1 -Root <sitio> -Base <Serie.docx> -Out <salida.docx> [-Serie serie2cuad]
# Script solo ASCII: el texto con acentos viene de los JSON (UTF-8).
# Mini-lenguaje de cada expresion del JSON: "{1/3}" = fraccion apilada, "^2" = exponente de un solo caracter,
# "^{2m}" = exponente de varios caracteres. El exponente se aplica al caracter anterior.
param([string]$Root, [string]$Base, [string]$Out, [string]$Serie = 'serie2cuad')
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$matriz = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\matriz-niveles-evaluacion.json'), $utf8) | ConvertFrom-Json
$act = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\rubricas-por-actividad.json'), $utf8) | ConvertFrom-Json
$s = $act.$Serie
$ru = $act.actividades | Where-Object { $_.id -eq $Serie }
$et = $act.etiquetas
$bul = [string][char]0x2022
$dot = [char]0x00B7
$ii = [char]0x00ED
$pm = [string][char]0x00B1

function Esc([string]$t) { return $t.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;') }
function Run([string]$t, [int]$sz = 0, [bool]$b = $false, [bool]$it = $false) {
  $p = ''
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
function MFrac([string]$n, [string]$d) {
  return '<m:f><m:fPr><m:ctrlPr>' + $cm + '</m:ctrlPr></m:fPr><m:num>' + (MR $n) + '</m:num><m:den>' + (MR $d) + '</m:den></m:f>'
}
function MSup([string]$e, [string]$sup) {
  return '<m:sSup><m:sSupPr><m:ctrlPr>' + $cm + '</m:ctrlPr></m:sSupPr><m:e>' + $e + '</m:e><m:sup>' + $sup + '</m:sup></m:sSup>'
}
function MPar([string]$e) {
  return '<m:d><m:dPr><m:ctrlPr>' + $cm + '</m:ctrlPr></m:dPr><m:e>' + $e + '</m:e></m:d>'
}
function MParse([string]$t) {
  $out = ''; $buf = ''; $pos = 0
  foreach ($m in [regex]::Matches($t, '\{(\d+)/(\d+)\}|\^\{([^}]+)\}|\^(\w)')) {
    $buf += $t.Substring($pos, $m.Index - $pos)
    if ($m.Groups[1].Success) {
      if ($buf -ne '') { $out += (MR $buf); $buf = '' }
      $out += (MFrac $m.Groups[1].Value $m.Groups[2].Value)
    } else {
      if ($buf -eq '') { throw "Exponente sin base en: $t" }
      $base = $buf.Substring($buf.Length - 1); $buf = $buf.Substring(0, $buf.Length - 1)
      if ($buf -ne '') { $out += (MR $buf); $buf = '' }
      $ex = $m.Groups[3].Value; if ($m.Groups[4].Success) { $ex = $m.Groups[4].Value }
      $out += (MSup (MR $base) (MR $ex))
    }
    $pos = $m.Index + $m.Length
  }
  $buf += $t.Substring($pos)
  if ($buf -ne '') { $out += (MR $buf) }
  return $out
}
function Binomio([string]$e) {
  if ($s.tipo -eq 'trinomio') {   # serie de trinomios: la expresion se muestra tal cual
    return '<m:oMathPara><m:oMath>' + (MParse $e) + '</m:oMath></m:oMathPara>'
  }
  # serie de binomios: (expresion)^2 con parentesis que se ajustan a las fracciones
  return '<m:oMathPara><m:oMath>' + (MSup (MPar (MParse $e)) (MR '2')) + '</m:oMath></m:oMathPara>'
}
# regla del proposito, en linea: (a +- b)^2 = a^2 +- 2ab + b^2   (o, en las series de trinomios, al reves)
$cuad = (MSup (MR ('(a' + $pm + 'b)')) (MR '2'))
$tri = (MSup (MR 'a') (MR '2')) + (MR ($pm + '2ab+')) + (MSup (MR 'b') (MR '2'))
if ($s.tipo -eq 'trinomio') { $regla = '<m:oMath>' + $tri + (MR '=') + $cuad + '</m:oMath>' }
else { $regla = '<m:oMath>' + $cuad + (MR '=') + $tri + '</m:oMath>' }

# ---- tabla de ejercicios (dos bloques: 1-10 y 11-20) ----
$bd = ''
foreach ($side in 'top', 'left', 'bottom', 'right', 'insideH', 'insideV') { $bd += '<w:' + $side + ' w:val="single" w:sz="4" w:space="0" w:color="808080"/>' }
function TblPr([int]$w) { return '<w:tblPr><w:tblW w:w="' + $w + '" w:type="dxa"/><w:jc w:val="center"/><w:tblBorders>' + $bd + '</w:tblBorders><w:tblLayout w:type="fixed"/><w:tblLook w:val="0000" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="0" w:noVBand="0"/></w:tblPr>' }
function Tc([int]$w, [string]$inner, [string]$fill = '', [int]$span = 1) {
  $pr = '<w:tcW w:w="' + $w + '" w:type="dxa"/>'
  if ($span -gt 1) { $pr += '<w:gridSpan w:val="' + $span + '"/>' }
  if ($fill -ne '') { $pr += '<w:shd w:val="clear" w:color="auto" w:fill="' + $fill + '"/>' }
  return '<w:tc><w:tcPr>' + $pr + '<w:vAlign w:val="center"/></w:tcPr>' + $inner + '</w:tc>'
}
if ($s.ejercicios.Count -ne 20) { throw "Se esperaban 20 ejercicios y hay $($s.ejercicios.Count)." }
$rowsEj = ''
$rowH = 800   # con 3 o mas incisos las filas son un poco mas bajas para que la tabla quepa en la primera hoja
if ($s.pasos.Count -gt 2) { $rowH = 700 }
for ($k = 0; $k -lt 10; $k++) {
  $cells = (Tc 700 (P (Run ([string]($k + 1)) 0 $true) 0 '<w:jc w:val="center"/>')) +
           (Tc 4170 ('<w:p><w:pPr><w:spacing w:after="0"/></w:pPr>' + (Binomio $s.ejercicios[$k]) + '</w:p>')) +
           (Tc 700 (P (Run ([string]($k + 11)) 0 $true) 0 '<w:jc w:val="center"/>')) +
           (Tc 4170 ('<w:p><w:pPr><w:spacing w:after="0"/></w:pPr>' + (Binomio $s.ejercicios[$k + 10]) + '</w:p>'))
  $rowsEj += '<w:tr><w:trPr><w:cantSplit/><w:trHeight w:val="' + $rowH + '"/><w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
}
$tblEj = '<w:tbl>' + (TblPr 9740) + '<w:tblGrid><w:gridCol w:w="700"/><w:gridCol w:w="4170"/><w:gridCol w:w="700"/><w:gridCol w:w="4170"/></w:tblGrid>' + $rowsEj + '</w:tbl>'

# ---- parte 1 (vertical): encabezado, proposito, instrucciones, ejercicios ----
$B = New-Object System.Collections.Generic.List[string]
$B.Add((P (Run $s.titulo 32 $true) 60))
$B.Add((P (Run $s.autor) 160))
$B.Add((P (Run $s.estudiante 20) 200))
$B.Add((P (Run $s.propositoTitulo 0 $true) 60))
$pp = $s.proposito -split '@@'
$B.Add((P ((Run $pp[0]) + $regla + (Run $pp[1])) 200 '<w:jc w:val="both"/>'))
$B.Add((P (Run $s.instruccionesIntro) 80))
$letras = 'a', 'b', 'c', 'd', 'e'
for ($k = 0; $k -lt $s.pasos.Count; $k++) {
  $B.Add((P ((Run ($letras[$k] + ')  ') 0 $true) + (Run $s.pasos[$k])) 40 '<w:ind w:left="567" w:hanging="283"/>'))
}
$B.Add((P '' 200))
$B.Add($tblEj)
$B.Add((P '' 0))
# fin de la seccion vertical
$B.Add('<w:p><w:pPr><w:spacing w:after="0"/><w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1250" w:right="1250" w:bottom="1250" w:left="1250" w:header="708" w:footer="708" w:gutter="0"/><w:cols w:space="720"/></w:sectPr></w:pPr></w:p>')

# ---- parte 2 (horizontal): rubrica con la matriz de niveles ----
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
  } else {
    $cells += (Tc ($wN * 2) (P (Run $row.n23 16) 0) '' 2)
  }
  $cells += (Tc $wN (P (Run $row.n4 16) 0)) + (Tc $wN (P (Run $row.n5 16) 0))
  $rr += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
}
$grid = '<w:tblGrid><w:gridCol w:w="' + $wC + '"/>' + ((1..5 | ForEach-Object { '<w:gridCol w:w="' + $wN + '"/>' }) -join '') + '</w:tblGrid>'
$B.Add((P (Run $s.rubricaTitulo 0 $true) 80))
$B.Add('<w:tbl>' + (TblPr $tot) + $grid + $rr + '</w:tbl>')
$n0 = $et.guiaNota0
$cut = $n0.IndexOf(':')
$B.Add((P ((Run $n0.Substring(0, $cut + 1) 17 $true) + (Run $n0.Substring($cut + 1) 17)) 0))
$sect = '<w:sectPr><w:pgSz w:w="15840" w:h="12240" w:orient="landscape"/><w:pgMar w:top="1000" w:right="1000" w:bottom="1000" w:left="1000" w:header="708" w:footer="708" w:gutter="0"/><w:cols w:space="720"/></w:sectPr>'
$ns = 'xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"'
$doc = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($B -join '') + $sect + '</w:body></w:document>'

# ---- empaquetar: copia el paquete base y cambia solo document.xml (y el titulo en las propiedades) ----
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path -LiteralPath $Out) { throw "Ya existe $Out; no se sobrescribe." }
$src = [IO.Compression.ZipFile]::OpenRead($Base)
$fs = [IO.File]::Open($Out, [IO.FileMode]::CreateNew)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
foreach ($e in $src.Entries) {
  $ne = $zip.CreateEntry($e.FullName); $o = $ne.Open()
  if ($e.FullName -eq 'word/document.xml') { $bytes = $utf8.GetBytes($doc); $o.Write($bytes, 0, $bytes.Length) }
  elseif ($e.FullName -eq 'docProps/core.xml') {   # el titulo de las propiedades es el de esta serie, no el de la base
    $rd = New-Object IO.StreamReader($e.Open(), $utf8); $core = $rd.ReadToEnd(); $rd.Close()
    $core = [regex]::Replace($core, '<dc:title>.*?</dc:title>', '<dc:title>' + (Esc $s.titulo) + '</dc:title>')
    $bytes = $utf8.GetBytes($core); $o.Write($bytes, 0, $bytes.Length)
  }
  else { $i = $e.Open(); $i.CopyTo($o); $i.Close() }
  $o.Close()
}
$zip.Dispose(); $fs.Close(); $src.Dispose()
"Serie: $Out ($((Get-Item -LiteralPath $Out).Length) bytes)"
