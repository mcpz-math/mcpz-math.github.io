# Genera la "Serie 3. Bosquejo de f(x) = a(x - h)^2 y de f(x) = ax^2 + bx + c (TCP)" en Word (.docx):
#   - la Serie para los alumnos: 10 ejercicios (sin plano: el bosquejo se hace en hoja aparte) con las casillas de
#     hacia donde abre, gorda / flaca y maximo / minimo, y su rubrica (matriz de niveles de Carmen);
#   - (opcional, -OutClave) la clave de respuestas para la profesora, con los bosquejos dibujados a escala aproximada.
# Toma los textos de materiales-fuente\rubricas-por-actividad.json (bloque y actividad "serie3bosquejo") y de
# matriz-niveles-evaluacion.json. Usa como base (estilos, fuentes, tema) cualquier otra Serie en Word de Carmen: -Base.
# Uso: powershell -ExecutionPolicy Bypass -File generar-serie-bosquejo-parabola.ps1 -Root <sitio> -Base <Serie.docx> -Out <serie.docx> [-OutClave <clave.docx>]
# Script solo ASCII: el texto con acentos viene del JSON (UTF-8).
# Mini-lenguaje de cada expresion del JSON: "{1/3}" = fraccion apilada, "[x-2]^2" = parentesis con exponente,
# "^2" = exponente de un solo caracter, "^{2m}" = exponente de varios caracteres (se aplica al caracter anterior).
param([string]$Root, [string]$Base, [string]$Out, [string]$OutClave = '', [string]$Serie = 'serie3bosquejo')
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
$boxOff = [string][char]0x2610
$boxOn = [string][char]0x2612
if ($s.ejercicios.Count -ne 10) { throw "Se esperaban 10 ejercicios y hay $($s.ejercicios.Count)." }

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
  foreach ($m in [regex]::Matches($t, '\{(\d+)/(\d+)\}|\[([^\]]*)\]\^(\w)|\^\{([^}]+)\}|\^(\w)')) {
    $buf += $t.Substring($pos, $m.Index - $pos)
    if ($m.Groups[1].Success) {
      if ($buf -ne '') { $out += (MR $buf); $buf = '' }
      $out += (MFrac $m.Groups[1].Value $m.Groups[2].Value)
    } elseif ($m.Groups[3].Success) {
      if ($buf -ne '') { $out += (MR $buf); $buf = '' }
      $out += (MSup (MPar (MParse $m.Groups[3].Value)) (MR $m.Groups[4].Value))
    } else {
      if ($buf -eq '') { throw "Exponente sin base en: $t" }
      $base = $buf.Substring($buf.Length - 1); $buf = $buf.Substring(0, $buf.Length - 1)
      if ($buf -ne '') { $out += (MR $buf); $buf = '' }
      $ex = $m.Groups[5].Value; if ($m.Groups[6].Success) { $ex = $m.Groups[6].Value }
      $out += (MSup (MR $base) (MR $ex))
    }
    $pos = $m.Index + $m.Length
  }
  $buf += $t.Substring($pos)
  if ($buf -ne '') { $out += (MR $buf) }
  return $out
}
function Mat([string]$t) { return '<m:oMath>' + (MParse $t) + '</m:oMath>' }   # ecuacion en linea

# ---- numeros como fracciones ----
function Gcd([int]$a, [int]$b) { $a = [Math]::Abs($a); $b = [Math]::Abs($b); while ($b -ne 0) { $t = $b; $b = $a % $b; $a = $t }; if ($a -eq 0) { return 1 }; return $a }
function Fr([int]$n, [int]$d) { if ($d -lt 0) { $n = -$n; $d = -$d }; $g = Gcd $n $d; return @(($n / $g), ($d / $g)) }
function Fmt($f) {   # fraccion [n,d] -> texto del mini-lenguaje ("-3", "{1/2}", "-{1/2}")
  $n = [int]$f[0]; $d = [int]$f[1]
  if ($d -eq 1) { return [string]$n }
  if ($n -lt 0) { return '-{' + [Math]::Abs($n) + '/' + $d + '}' }
  return '{' + $n + '/' + $d + '}'
}
function Factorizada($a, $h) {   # a(x - h)^2
  $an = [int]$a[0]; $ad = [int]$a[1]; $hn = [int]$h[0]; $hd = [int]$h[1]
  if ($ad -eq 1) { if ($an -eq 1) { $c = '' } elseif ($an -eq -1) { $c = '-' } else { $c = [string]$an } } else { $c = Fmt $a }
  $sg = '-'; if ($hn -lt 0) { $sg = '+' }
  $habs = Fmt @([Math]::Abs($hn), $hd)
  return $c + '[x' + $sg + $habs + ']^2'
}

# ---- planos cartesianos (PNG) ----
Add-Type -AssemblyName System.Drawing
function Dibuja-Plano([string]$path, $coefA, $coefH, [bool]$curva) {
  $W = 600; $H = 500
  $bmp = New-Object System.Drawing.Bitmap($W, $H)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear([System.Drawing.Color]::White)
  $ink = [System.Drawing.Color]::FromArgb(51, 51, 51)
  $axis = New-Object System.Drawing.Pen($ink, 3)
  $font = New-Object System.Drawing.Font('Cambria', 22, [System.Drawing.FontStyle]::Italic, [System.Drawing.GraphicsUnit]::Pixel)
  $brInk = New-Object System.Drawing.SolidBrush($ink)
  if (-not $curva) {
    $x0 = 300; $y0 = 250
    $gp = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(222, 222, 222), 1)
    for ($x = 0; $x -le $W; $x += 50) { $g.DrawLine($gp, $x, 0, $x, $H) }
    for ($y = 0; $y -le $H; $y += 50) { $g.DrawLine($gp, 0, $y, $W, $y) }
  } else {
    $an = [double]$coefA[0] / [double]$coefA[1]; $hv = [double]$coefH[0] / [double]$coefH[1]
    $xlo = [Math]::Min(0, $hv) - 1.6; $xhi = [Math]::Max(0, $hv) + 1.6
    if (($xhi - $xlo) -lt 4) { $mid = ($xlo + $xhi) / 2; $xlo = $mid - 2; $xhi = $mid + 2 }
    $sx = 560 / ($xhi - $xlo)
    if ($an -gt 0) { $y0 = 440 } else { $y0 = 60 }
    $x0 = 20 + (0 - $xlo) * $sx
    $ymax = [Math]::Abs($an) * [Math]::Max([Math]::Pow($xlo - $hv, 2), [Math]::Pow($xhi - $hv, 2))
    if ($an -gt 0) { $avail = $y0 - 20 } else { $avail = $H - 20 - $y0 }
    $sy = $avail / $ymax
  }
  # ejes con punta de flecha
  $g.DrawLine($axis, 12, $y0, ($W - 12), $y0)
  $g.DrawLine($axis, $x0, ($H - 12), $x0, 12)
  $g.FillPolygon($brInk, @((New-Object System.Drawing.PointF(($W - 4), $y0)), (New-Object System.Drawing.PointF(($W - 22), ($y0 - 8))), (New-Object System.Drawing.PointF(($W - 22), ($y0 + 8)))))
  $g.FillPolygon($brInk, @((New-Object System.Drawing.PointF($x0, 4)), (New-Object System.Drawing.PointF(($x0 - 8), 22)), (New-Object System.Drawing.PointF(($x0 + 8), 22))))
  $g.DrawString('x', $font, $brInk, ($W - 34), ($y0 + 8))
  $g.DrawString('y', $font, $brInk, ($x0 + 12), 4)
  if ($curva) {
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(20, 48, 31), 4)
    $seg = New-Object System.Collections.Generic.List[System.Drawing.PointF]
    for ($px = 8; $px -le ($W - 8); $px += 2) {
      $x = $xlo + ($px - 20) / $sx
      $py = $y0 - $an * [Math]::Pow($x - $hv, 2) * $sy
      if ($py -ge 6 -and $py -le ($H - 6)) { $seg.Add((New-Object System.Drawing.PointF($px, $py))) }
      else { if ($seg.Count -gt 1) { $g.DrawLines($pen, $seg.ToArray()) }; $seg.Clear() }
    }
    if ($seg.Count -gt 1) { $g.DrawLines($pen, $seg.ToArray()) }
    # vertice (verde) y corte con el eje y (naranja)
    $vx = 20 + ($hv - $xlo) * $sx
    $cyv = $an * $hv * $hv
    $cpy = $y0 - $cyv * $sy
    $g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(47, 158, 68))), ($vx - 8), ($y0 - 8), 16, 16)
    $g.DrawEllipse((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(20, 48, 31), 2)), ($vx - 8), ($y0 - 8), 16, 16)
    $g.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(232, 89, 12))), ($x0 - 7), ($cpy - 7), 14, 14)
  }
  $g.DrawRectangle((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(150, 150, 150), 2)), 1, 1, ($W - 2), ($H - 2))
  $g.Dispose()
  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
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

# ---- imagenes en el documento ----
$script:imgs = New-Object System.Collections.Generic.List[object]   # @{ rid; nombre; ruta }
$script:docPrId = 100
function Img-Parrafo([string]$rid, [string]$nombre) {
  $script:docPrId++
  $cx = 1512000; $cy = 1260000   # 4.2 cm x 3.5 cm
  $id = $script:docPrId
  return '<w:p><w:pPr><w:spacing w:after="0"/><w:jc w:val="center"/></w:pPr><w:r><w:drawing><wp:inline distT="0" distB="0" distL="0" distR="0"><wp:extent cx="' + $cx + '" cy="' + $cy + '"/><wp:docPr id="' + $id + '" name="' + $nombre + '" descr="Plano cartesiano"/><wp:cNvGraphicFramePr/><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:nvPicPr><pic:cNvPr id="' + $id + '" name="' + $nombre + '.png"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="' + $rid + '"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="' + $cx + '" cy="' + $cy + '"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>'
}

# ---- celdas de un ejercicio ----
$wT = 2200; $wI = 2670   # ancho de la celda de texto y de la celda del plano (suman 4870 por ejercicio)
$sz = 18
function Linea([string]$runs) { return (P $runs 50) }
function Opc([string]$titulo, $etiquetas, [int]$marca) {   # "titulo  [ ] op1   [ ] op2 ..." ($marca = indice marcado, -1 = ninguno)
  $r = ''
  if ($titulo -ne '') { $r += (Run ($titulo + '  ') $sz) }
  for ($k = 0; $k -lt $etiquetas.Count; $k++) {
    $c = $boxOff; if ($k -eq $marca) { $c = $boxOn }
    $r += (Run $c $sz $false $false 'Segoe UI Symbol') + (Run (' ' + $etiquetas[$k] + '    ') $sz)
  }
  return $r
}
function Celdas-Ejercicio([int]$i, [bool]$clave, [string]$rid) {
  $e = $s.ejercicios[$i]; $n = $i + 1
  $a = $e.a; $h = $e.h
  $tcp = ($i -ge 5)
  $cabeza = (P ((Run ([string]$n + '.  ') 22 $true) + (Mat ('f(x)=' + $e.f))) 80)
  $txt = $cabeza
  $esMax = ([int]$a[0] -lt 0)
  $iAbre = 0; if ($esMax) { $iAbre = 1 }                      # 0 = arriba, 1 = abajo
  $absn = [Math]::Abs([int]$a[0]); $dd = [int]$a[1]
  $iForma = 2; if ($absn -gt $dd) { $iForma = 1 } elseif ($absn -lt $dd) { $iForma = 0 }   # 0 gorda, 1 flaca, 2 igual
  $etAbre = @($s.arriba, $s.abajo); $etForma = @($s.gorda, $s.flaca, $s.igual)
  if (-not $clave) {
    if ($tcp) { $txt += (Linea (Run $s.lineaFact $sz)) }
    $txt += (Linea (Run $s.lineaA $sz))
    $txt += (Linea (Run $s.lineaV $sz))
    $txt += (Linea (Opc $s.lineaAbre $etAbre -1))
    $txt += (Linea (Opc $s.lineaForma $etForma -1))
    $txt += (Linea (Opc '' @($s.maximo, $s.minimo) -1))
    $txt += (Linea (Run $s.lineaPorque $sz))
    $txt += (Linea (Run $s.lineaPorque2 $sz))
    return (Tc 4870 $txt '' 1 'top')
  } else {
    $cn = [int]$a[0] * [int]$h[0] * [int]$h[0]; $cd = [int]$a[1] * [int]$h[1] * [int]$h[1]
    $cy = Fr $cn $cd
    if ($tcp) { $txt += (Linea ((Run ($s.claveFact + ' ') $sz $true) + (Mat (Factorizada $a $h)))) }
    $txt += (Linea ((Run 'a = ' $sz) + (Mat (Fmt $a)) + (Run '    h = ' $sz) + (Mat (Fmt $h))))
    $txt += (Linea ((Run ($s.claveV + ' ') $sz $true) + (Mat ('V(' + (Fmt $h) + ',0)'))))
    $txt += (Linea ((Run ($s.claveAbre + ' ') $sz $true) + (Run $etAbre[$iAbre] $sz)))
    $fx = @($s.claveFormaGorda, $s.claveFormaFlaca, $s.claveFormaIgual)[$iForma]
    $txt += (Linea ((Run ($s.claveForma + ' ') $sz $true) + (Run $fx $sz)))
    $iMM = 1; if ($esMax) { $iMM = 0 }                         # 0 = maximo, 1 = minimo
    $txt += (Linea (Opc '' @($s.maximo, $s.minimo) $iMM))
    $txt += (Linea ((Run ($s.claveCorte + ' ') $sz $true) + (Mat ('(0,' + (Fmt $cy) + ')'))))
    if ($esMax) { $por = $s.clavePorqueNeg } else { $por = $s.clavePorquePos }
    $txt += (Linea (Run $por 16 $false $true))
    $plano = (Img-Parrafo $rid 'Bosquejo')
  }
  return (Tc $wT $txt '' 1 'top') + (Tc $wI $plano)
}

function Tabla-Ejercicios([bool]$clave, $rids) {
  if ($clave) {   # la clave lleva a cada ejercicio su bosquejo correcto (texto + dibujo)
    $span = 2; $grid = '<w:gridCol w:w="' + $wT + '"/><w:gridCol w:w="' + $wI + '"/><w:gridCol w:w="' + $wT + '"/><w:gridCol w:w="' + $wI + '"/>'; $hgt = '<w:trHeight w:val="2500"/>'
  } else {        # la hoja de los alumnos no lleva plano: una celda de texto por ejercicio
    $span = 1; $grid = '<w:gridCol w:w="4870"/><w:gridCol w:w="4870"/>'; $hgt = ''
  }
  $hdr = '<w:tr><w:trPr><w:cantSplit/><w:tblHeader/><w:jc w:val="center"/></w:trPr>' +
         (Tc 4870 (P (Run $s.parte1 20 $true) 0) 'E2EFDA' $span) + (Tc 4870 (P (Run $s.parte2 20 $true) 0) 'E2EFDA' $span) + '</w:tr>'
  $rows = ''
  for ($k = 0; $k -lt 5; $k++) {
    $r1 = ''; $r2 = ''
    if ($clave) { $r1 = $rids[$k]; $r2 = $rids[$k + 5] }
    $cells = (Celdas-Ejercicio $k $clave $r1) + (Celdas-Ejercicio ($k + 5) $clave $r2)
    $rows += '<w:tr><w:trPr><w:cantSplit/>' + $hgt + '<w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
  }
  return '<w:tbl>' + (TblPr 9740) + '<w:tblGrid>' + $grid + '</w:tblGrid>' + $hdr + $rows + '</w:tbl>'
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
    } else {
      $cells += (Tc ($wN * 2) (P (Run $row.n23 16) 0) '' 2)
    }
    $cells += (Tc $wN (P (Run $row.n4 16) 0)) + (Tc $wN (P (Run $row.n5 16) 0))
    $rr += '<w:tr><w:trPr><w:cantSplit/><w:jc w:val="center"/></w:trPr>' + $cells + '</w:tr>'
  }
  $grid = '<w:tblGrid><w:gridCol w:w="' + $wC + '"/>' + ((1..5 | ForEach-Object { '<w:gridCol w:w="' + $wN + '"/>' }) -join '') + '</w:tblGrid>'
  $x = (P (Run $s.rubricaTitulo 0 $true) 80) + '<w:tbl>' + (TblPr $tot) + $grid + $rr + '</w:tbl>'
  $n0 = $et.guiaNota0
  $cut = $n0.IndexOf(':')
  $x += (P ((Run $n0.Substring(0, $cut + 1) 17 $true) + (Run $n0.Substring($cut + 1) 17)) 0)
  return $x
}

# ---- empaquetar: copia el paquete base; cambia document.xml, rels y tipos, y agrega los PNG ----
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
  "Listo: $destino ($((Get-Item -LiteralPath $destino).Length) bytes)"
}

$tmp = Join-Path ([IO.Path]::GetTempPath()) ('serie3-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $tmp | Out-Null

# ======== SERIE DE LOS ALUMNOS ========
$script:imgs.Clear()
$B =New-Object System.Collections.Generic.List[string]
$B.Add((P (Run $s.titulo 32 $true) 60))
$B.Add((P (Run $s.autor) 160))
$B.Add((P (Run $s.estudiante 20) 200))
$B.Add((P (Run $s.propositoTitulo 0 $true) 60))
$B.Add((P (Run $s.proposito) 200 '<w:jc w:val="both"/>'))
$B.Add((P (Run $s.instruccionesTitulo 0 $true) 60))
$B.Add((P (Run $s.instruccionesIntro) 80))
$letras = 'a', 'b', 'c', 'd', 'e'
for ($k = 0; $k -lt $s.pasos.Count; $k++) {
  $B.Add((P ((Run ($letras[$k] + ')  ') 0 $true) + (Run $s.pasos[$k])) 40 '<w:ind w:left="567" w:hanging="283"/>'))
}
$B.Add((P '' 160))
$B.Add((Tabla-Ejercicios $false @()))
$B.Add((P '' 0))
$B.Add('<w:p><w:pPr><w:spacing w:after="0"/>' + $secV + '</w:pPr></w:p>')
$B.Add((Rubrica-Xml))
$doc = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($B -join '') + $secH + '</w:body></w:document>'
Empaqueta $Out $doc

# ======== CLAVE PARA LA PROFESORA ========
if ($OutClave -ne '') {
  $script:imgs.Clear()
  $rids = @()
  for ($i = 0; $i -lt 10; $i++) {
    $nombre = 'bosquejo-' + ($i + 1) + '.png'
    $ruta = Join-Path $tmp $nombre
    $ea = $s.ejercicios[$i].a; $eh = $s.ejercicios[$i].h
    Dibuja-Plano $ruta $ea $eh $true
    $script:imgs.Add(@{ rid = ('rIdB' + ($i + 1)); nombre = $nombre; ruta = $ruta })
    $rids += ('rIdB' + ($i + 1))
  }
  $B = New-Object System.Collections.Generic.List[string]
  $B.Add((P (Run $s.claveTitulo 28 $true) 60))
  $B.Add((P (Run $s.titulo 20) 100))
  $B.Add((P (Run $s.claveNota 18 $false $true) 160 '<w:jc w:val="both"/>'))
  $B.Add((Tabla-Ejercicios $true $rids))
  $B.Add((P '' 0))
  $docC = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($B -join '') + $secV + '</w:body></w:document>'
  Empaqueta $OutClave $docC
}
Remove-Item -LiteralPath $tmp -Recurse -Force
