# Genera un apunte de clase en Word (.docx) a partir de un .json de esta carpeta (texto en UTF-8) y de las figuras PNG de .\figuras\.
# Uso: powershell -ExecutionPolicy Bypass -File generar-apunte-word.ps1 -Root <sitio> -Json apunte-conicas-word.json -Base <Serie.docx> -Out <apunte.docx>
# Script solo ASCII: todo el texto con acentos viene del JSON.
# Mini-lenguaje de los textos: **negrita**, *cursiva*, $ecuacion$ (ecuacion de Word; "^2" = exponente de un caracter).
param([string]$Root, [string]$Json, [string]$Base, [string]$Out)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$dirA = Join-Path $Root 'materiales-fuente\apuntes'
$d = [IO.File]::ReadAllText((Join-Path $dirA $Json), $utf8) | ConvertFrom-Json
$FOREST = '14301F'; $MOSS = '3F6B4A'; $LIME = 'C4E86B'; $SOFT = '56604F'; $BOX = 'EEF6E2'; $LINE = 'B9C7B0'

function Esc([string]$t) { return $t.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;') }
function Run([string]$t, [int]$sz = 21, [bool]$b = $false, [bool]$it = $false, [string]$color = '22301F') {
  $p = ''
  if ($b) { $p += '<w:b/>' }
  if ($it) { $p += '<w:i/>' }
  $p += '<w:color w:val="' + $color + '"/><w:sz w:val="' + $sz + '"/><w:szCs w:val="' + $sz + '"/>'
  return '<w:r><w:rPr>' + $p + '</w:rPr><w:t xml:space="preserve">' + (Esc $t) + '</w:t></w:r>'
}
function P([string]$runs, [int]$after = 80, [string]$jc = '', [string]$extraPre = '', [string]$ind = '') {
  $ppr = $extraPre + '<w:spacing w:after="' + $after + '" w:line="264" w:lineRule="auto"/>' + $ind
  if ($jc -ne '') { $ppr += '<w:jc w:val="' + $jc + '"/>' }
  return '<w:p><w:pPr>' + $ppr + '</w:pPr>' + $runs + '</w:p>'
}

# ---- ecuaciones (OMML) ----
$cm = '<w:rPr><w:rFonts w:ascii="Cambria Math" w:hAnsi="Cambria Math"/></w:rPr>'
function MR([string]$t) { return '<m:r>' + $cm + '<m:t>' + (Esc $t) + '</m:t></m:r>' }
function MSup([string]$e, [string]$sup) { return '<m:sSup><m:sSupPr><m:ctrlPr>' + $cm + '</m:ctrlPr></m:sSupPr><m:e>' + $e + '</m:e><m:sup>' + $sup + '</m:sup></m:sSup>' }
function MParse([string]$t) {
  $out = ''; $buf = ''; $pos = 0
  foreach ($m in [regex]::Matches($t, '\^(\w)')) {
    $buf += $t.Substring($pos, $m.Index - $pos)
    if ($buf -eq '') { throw "Exponente sin base en: $t" }
    $base = $buf.Substring($buf.Length - 1); $buf = $buf.Substring(0, $buf.Length - 1)
    if ($buf -ne '') { $out += (MR $buf); $buf = '' }
    $out += (MSup (MR $base) (MR $m.Groups[1].Value)); $pos = $m.Index + $m.Length
  }
  $buf += $t.Substring($pos); if ($buf -ne '') { $out += (MR $buf) }
  return $out
}
function Mat([string]$t) { return '<m:oMath>' + (MParse $t) + '</m:oMath>' }

# texto con **negrita**, *cursiva* y $ecuacion$
function Rico([string]$t, [int]$sz = 21, [string]$color = '22301F', [bool]$boldAll = $false) {
  $r = ''
  $parts = $t.Split([char]'$')
  for ($k = 0; $k -lt $parts.Count; $k++) {
    if (($k % 2) -eq 1) { $r += (Mat $parts[$k]); continue }
    foreach ($seg in [regex]::Split($parts[$k], '(\*\*.+?\*\*|\*[^*]+?\*)')) {
      if ($seg -eq '') { continue }
      if ($seg.StartsWith('**')) { $r += (Run $seg.Substring(2, $seg.Length - 4) $sz $true $false $color) }
      elseif ($seg.StartsWith('*')) { $r += (Run $seg.Substring(1, $seg.Length - 2) $sz $boldAll $true $color) }
      else { $r += (Run $seg $sz $boldAll $false $color) }
    }
  }
  return $r
}

# ---- tablas ----
function Bd([string]$side, [int]$sz, [string]$color) { return '<w:' + $side + ' w:val="single" w:sz="' + $sz + '" w:space="0" w:color="' + $color + '"/>' }
function TblPr([int]$w, [string]$borders) { return '<w:tblPr><w:tblW w:w="' + $w + '" w:type="dxa"/><w:jc w:val="center"/><w:tblBorders>' + $borders + '</w:tblBorders><w:tblLayout w:type="fixed"/><w:tblCellMar><w:top w:w="40" w:type="dxa"/><w:left w:w="100" w:type="dxa"/><w:bottom w:w="40" w:type="dxa"/><w:right w:w="100" w:type="dxa"/></w:tblCellMar><w:tblLook w:val="0000" w:firstRow="0" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="0" w:noVBand="0"/></w:tblPr>' }
function Tc([int]$w, [string]$inner, [string]$fill = '', [string]$va = 'center') {
  $pr = '<w:tcW w:w="' + $w + '" w:type="dxa"/>'
  if ($fill -ne '') { $pr += '<w:shd w:val="clear" w:color="auto" w:fill="' + $fill + '"/>' }
  return '<w:tc><w:tcPr>' + $pr + '<w:vAlign w:val="' + $va + '"/></w:tcPr>' + $inner + '</w:tc>'
}
$W = 10200
$gridLines = (Bd 'top' 4 $LINE) + (Bd 'left' 4 $LINE) + (Bd 'bottom' 4 $LINE) + (Bd 'right' 4 $LINE) + (Bd 'insideH' 4 $LINE) + (Bd 'insideV' 4 $LINE)
$none = (Bd 'top' 0 'FFFFFF').Replace('w:val="single"', 'w:val="nil"') + (Bd 'left' 0 'FFFFFF').Replace('w:val="single"', 'w:val="nil"') + (Bd 'bottom' 0 'FFFFFF').Replace('w:val="single"', 'w:val="nil"') + (Bd 'right' 0 'FFFFFF').Replace('w:val="single"', 'w:val="nil"') + (Bd 'insideH' 0 'FFFFFF').Replace('w:val="single"', 'w:val="nil"') + (Bd 'insideV' 0 'FFFFFF').Replace('w:val="single"', 'w:val="nil"')

function H2([string]$t) {
  return '<w:p><w:pPr><w:keepNext/><w:pBdr><w:bottom w:val="single" w:sz="12" w:space="1" w:color="' + $LIME + '"/></w:pBdr><w:spacing w:before="200" w:after="80"/></w:pPr>' + (Run $t 25 $true $false $FOREST) + '</w:p>'
}
function Cuadro([string]$titulo, $parrafos, [string]$tono) {
  $fill = $BOX; $bar = $MOSS; $tcolor = $MOSS
  if ($tono -eq 'naranja') { $fill = 'FFF4E5'; $bar = 'D9650B'; $tcolor = 'D9650B' }
  $inner = ''
  if ($titulo -ne '') { $inner += (P (Run $titulo.ToUpper() 16 $true $false $tcolor) 20) }
  foreach ($p in $parrafos) { $inner += (P (Rico $p 21) 40) }
  $b = (Bd 'top' 4 $LINE) + (Bd 'left' 36 $bar) + (Bd 'bottom' 4 $LINE) + (Bd 'right' 4 $LINE)
  $tc = '<w:tc><w:tcPr><w:tcW w:w="' + $W + '" w:type="dxa"/><w:shd w:val="clear" w:color="auto" w:fill="' + $fill + '"/></w:tcPr>' + $inner + '</w:tc>'
  return '<w:tbl>' + (TblPr $W $b) + '<w:tblGrid><w:gridCol w:w="' + $W + '"/></w:tblGrid><w:tr><w:trPr><w:cantSplit/></w:trPr>' + $tc + '</w:tr></w:tbl>' + (P '' 60)
}
function Formula([string]$eq) {
  $b = (Bd 'top' 12 $FOREST) + (Bd 'left' 12 $FOREST) + (Bd 'bottom' 12 $FOREST) + (Bd 'right' 12 $FOREST)
  $tc = '<w:tc><w:tcPr><w:tcW w:w="' + $W + '" w:type="dxa"/><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/></w:tcPr>' + (P (Mat $eq) 40 'center') + '</w:tc>'
  return '<w:tbl>' + (TblPr $W $b) + '<w:tblGrid><w:gridCol w:w="' + $W + '"/></w:tblGrid><w:tr><w:trPr><w:cantSplit/></w:trPr>' + $tc + '</w:tr></w:tbl>' + (P '' 60)
}
function Tabla($b) {
  $cols = @($b.cols | ForEach-Object { [int]$_ }); $tot = ($cols | Measure-Object -Sum).Sum
  $grid = '<w:tblGrid>' + (($cols | ForEach-Object { '<w:gridCol w:w="' + $_ + '"/>' }) -join '') + '</w:tblGrid>'
  $h = ''; for ($i = 0; $i -lt $cols.Count; $i++) { $h += (Tc $cols[$i] (P (Rico $b.head[$i] 20 'FFFFFF' $true) 0) $FOREST) }
  $rows = '<w:tr><w:trPr><w:cantSplit/><w:tblHeader/></w:trPr>' + $h + '</w:tr>'
  $n = 0
  foreach ($r in $b.rows) {
    $fill = ''; if (($n % 2) -eq 1) { $fill = 'F7FAF1' }
    $c = ''; for ($i = 0; $i -lt $cols.Count; $i++) { $c += (Tc $cols[$i] (P (Rico $r[$i] 21) 0) $fill) }
    $rows += '<w:tr><w:trPr><w:cantSplit/></w:trPr>' + $c + '</w:tr>'; $n++
  }
  return '<w:tbl>' + (TblPr $tot $gridLines) + $grid + $rows + '</w:tbl>' + (P '' 60)
}

# ---- figuras ----
$script:imgs = New-Object System.Collections.Generic.List[object]
$script:docPrId = 100
function ImgPar([string]$rid, [string]$nombre, [string]$alt) {
  $script:docPrId++; $id = $script:docPrId
  $cx = 1800000; $cy = 1864286   # 5.0 cm x 5.18 cm (relacion 560 x 580)
  return '<w:p><w:pPr><w:spacing w:after="0"/><w:jc w:val="center"/></w:pPr><w:r><w:drawing><wp:inline distT="0" distB="0" distL="0" distR="0"><wp:extent cx="' + $cx + '" cy="' + $cy + '"/><wp:docPr id="' + $id + '" name="' + $nombre + '" descr="' + (Esc $alt) + '"/><wp:cNvGraphicFramePr/><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:nvPicPr><pic:cNvPr id="' + $id + '" name="' + $nombre + '"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="' + $rid + '"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="' + $cx + '" cy="' + $cy + '"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>'
}
function Figuras($items) {
  $half = [int]($W / 2); $rows = ''; $cells = @()
  foreach ($it in $items) {
    $path = Join-Path (Join-Path $dirA 'figuras') $it.img
    if (-not (Test-Path -LiteralPath $path)) { throw "Falta la figura $($it.img)" }
    $rid = 'rIdF' + ($script:imgs.Count + 1)
    $script:imgs.Add(@{ rid = $rid; nombre = $it.img; ruta = $path })
    $inner = (ImgPar $rid $it.img ('Corte del cono: ' + $it.nombre)) + (P (Run $it.nombre 23 $true $false $FOREST) 20 'center') + (P (Run $it.desc 17 $false $false $SOFT) 40 'center')
    $cells += (Tc $half $inner '' 'top')
  }
  $b = (Bd 'top' 4 $LINE) + (Bd 'left' 4 $LINE) + (Bd 'bottom' 4 $LINE) + (Bd 'right' 4 $LINE) + (Bd 'insideH' 4 $LINE) + (Bd 'insideV' 4 $LINE)
  for ($k = 0; $k -lt $cells.Count; $k += 2) { $rows += '<w:tr><w:trPr><w:cantSplit/></w:trPr>' + $cells[$k] + $cells[$k + 1] + '</w:tr>' }
  return '<w:tbl>' + (TblPr $W $b) + '<w:tblGrid><w:gridCol w:w="' + $half + '"/><w:gridCol w:w="' + $half + '"/></w:tblGrid>' + $rows + '</w:tbl>' + (P '' 60)
}
function Notas([string]$titulo, [int]$n) {
  $x = (P (Run $titulo 23 $true $false $FOREST) 40 '' '<w:keepNext/>')
  for ($i = 0; $i -lt $n; $i++) { $x += '<w:p><w:pPr><w:pBdr><w:bottom w:val="single" w:sz="4" w:space="1" w:color="' + $LINE + '"/></w:pBdr><w:spacing w:before="200" w:after="0"/></w:pPr></w:p>' }
  return $x
}

# ---- documento ----
$L = New-Object System.Collections.Generic.List[string]
$L.Add((P ((Run ($d.org) 17 $true $false $FOREST)) 20))
$L.Add((P (Run $d.nombre 17 $false $false $SOFT) 40 '' ('<w:pBdr><w:bottom w:val="single" w:sz="18" w:space="3" w:color="' + $LIME + '"/></w:pBdr>')))
$L.Add((P (Run $d.kicker 16 $true $false $MOSS) 0))
$L.Add((P (Run $d.titulo 44 $true $false $FOREST) 100))
foreach ($blq in $d.bloques) {
  switch ($blq.t) {
    'h2' { $L.Add((H2 $blq.v)) }
    'p' { $L.Add((P (Rico $blq.v 21) 80)) }
    'ul' { foreach ($i in $blq.v) { $L.Add((P ((Run ([string][char]0x2022 + ' ') 21) + (Rico $i 21)) 40 '' '' '<w:ind w:left="360" w:hanging="240"/>')) } }
    'figs' { $L.Add((Figuras $blq.items)) }
    'formula' { $L.Add((Formula $blq.v)) }
    'box' { $L.Add((Cuadro $blq.titulo $blq.v $blq.tono)) }
    'tabla' { $L.Add((Tabla $blq)) }
    'notas' { $L.Add((Notas $blq.titulo $blq.n)) }
    default { throw "Tipo de bloque desconocido: $($blq.t)" }
  }
}
$L.Add((P (Run $d.pie 16 $false $false $SOFT) 0 'center' ('<w:pBdr><w:top w:val="single" w:sz="4" w:space="3" w:color="' + $LINE + '"/></w:pBdr>')))
$ns = 'xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"'
$sec = '<w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="900" w:right="1020" w:bottom="900" w:left="1020" w:header="708" w:footer="708" w:gutter="0"/><w:cols w:space="720"/></w:sectPr>'
$docXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($L -join '') + $sec + '</w:body></w:document>'

# ---- empaquetar sobre el paquete base ----
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path -LiteralPath $Out) { throw "Ya existe $Out; no se sobrescribe." }
$src = [IO.Compression.ZipFile]::OpenRead($Base)
$fs = [IO.File]::Open($Out, [IO.FileMode]::CreateNew)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
foreach ($e in $src.Entries) {
  $ne = $zip.CreateEntry($e.FullName); $o = $ne.Open()
  if ($e.FullName -eq 'word/document.xml') { $bytes = $utf8.GetBytes($docXml); $o.Write($bytes, 0, $bytes.Length) }
  elseif ($e.FullName -eq '[Content_Types].xml' -or $e.FullName -eq 'word/_rels/document.xml.rels') {
    $rd = New-Object IO.StreamReader($e.Open(), $utf8); $txt = $rd.ReadToEnd(); $rd.Close()
    if ($e.FullName -eq '[Content_Types].xml') {
      if ($txt -notmatch 'Extension="png"') { $txt = $txt.Replace('<Default Extension="xml"', '<Default Extension="png" ContentType="image/png"/><Default Extension="xml"') }
    } else {
      $rel = ''
      foreach ($im in $script:imgs) { $rel += '<Relationship Id="' + $im.rid + '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/' + $im.nombre + '"/>' }
      $txt = $txt.Replace('</Relationships>', $rel + '</Relationships>')
    }
    $bytes = $utf8.GetBytes($txt); $o.Write($bytes, 0, $bytes.Length)
  }
  else { $i = $e.Open(); $i.CopyTo($o); $i.Close() }
  $o.Close()
}
foreach ($im in $script:imgs) {
  $ne = $zip.CreateEntry('word/media/' + $im.nombre); $o = $ne.Open()
  $bytes = [IO.File]::ReadAllBytes($im.ruta); $o.Write($bytes, 0, $bytes.Length); $o.Close()
}
$zip.Dispose(); $fs.Close(); $src.Dispose()
"Listo: $Out ($((Get-Item -LiteralPath $Out).Length) bytes)"
