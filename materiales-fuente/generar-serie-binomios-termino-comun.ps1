# Genera una Serie de "Binomios con termino comun" en Word (.docx), 20 ejercicios, con el mismo formato
# de la Serie 4 de Binomios conjugados: encabezado verde, recuadro "Recuerda", instrucciones,
# 20 ejercicios en dos columnas (10 filas) con espacio para resolver, y pagina de respuestas.
# Toma como base (estilos, pie de pagina, medidas) el .docx de la Serie 3 o 4 de Binomios conjugados
# y solo cambia titulos, recuadro, instrucciones y el contenido de las dos tablas.
# Uso: powershell -ExecutionPolicy Bypass -File generar-serie-binomios-termino-comun.ps1 -Base <Serie4_Binomios conjugados.docx> -Out <salida.docx> [-Num 1] [-BaseNum 4]
# Script solo ASCII. Mini-lenguaje de cada expresion: "-" = signo menos, "^2" = exponente,
# "{1/5}" = fraccion apilada (ecuacion de Word).
param([string]$Base, [string]$Out, [int]$Num = 1, [int]$BaseNum = 4)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$dot = [string][char]0x00B7
$minus = [string][char]0x2212
$e1 = [string][char]0x00E9   # e con acento
$u1 = [string][char]0x00FA   # u con acento
$a1 = [string][char]0x00E1   # a con acento

# ---- Serie 1: ejercicio ; resultado  (se verifica abajo con suma y producto) ----
$datos = @(
  @('(x + 2)(x + 5)',          'x^2 + 7x + 10'),
  @('(m + 3)(m + 7)',          'm^2 + 10m + 21'),
  @('(y + 4)(y + 6)',          'y^2 + 10y + 24'),
  @('(a + 1)(a + 9)',          'a^2 + 10a + 9'),
  @('(x - 3)(x - 4)',          'x^2 - 7x + 12'),
  @('(n - 2)(n - 8)',          'n^2 - 10n + 16'),
  @('(z - 5)(z - 6)',          'z^2 - 11z + 30'),
  @('(p - 1)(p - 10)',         'p^2 - 11p + 10'),
  @('(x + 7)(x - 3)',          'x^2 + 4x - 21'),
  @('(t - 9)(t + 2)',          't^2 - 7t - 18'),
  @('(c + 8)(c - 5)',          'c^2 + 3c - 40'),
  @('(w - 6)(w + 4)',          'w^2 - 2w - 24'),
  @('(k + 12)(k - 1)',         'k^2 + 11k - 12'),
  @('(b - 7)(b + 7)',          'b^2 - 49'),
  @('(v - 4)(v - 4)',          'v^2 - 8v + 16'),
  @('(y - 15)(y + 4)',         'y^2 - 11y - 60'),
  @('(x^2 + 3)(x^2 + 5)',      'x^4 + 8x^2 + 15'),
  @('(3x + 2)(3x + 5)',        '9x^2 + 21x + 10'),
  @('(2m - 7)(2m + 3)',        '4m^2 - 8m - 21'),
  @('(x + {1/2})(x + {1/3})',  'x^2 + {5/6}x + {1/6}')
)
if ($datos.Count -ne 20) { throw "Se esperaban 20 ejercicios y hay $($datos.Count)." }

# ---- piezas de XML ----
$rpr = '<w:rFonts w:ascii="Cambria" w:eastAsia="Cambria" w:hAnsi="Cambria" w:cs="Cambria"/><w:sz w:val="26"/><w:szCs w:val="26"/>'
$mrpr = '<w:rPr><w:rFonts w:ascii="Cambria Math" w:eastAsia="Cambria" w:hAnsi="Cambria Math" w:cs="Cambria"/><w:sz w:val="26"/><w:szCs w:val="26"/></w:rPr>'
$mctrl = '<w:rPr><w:rFonts w:ascii="Cambria Math" w:eastAsia="Cambria" w:hAnsi="Cambria Math" w:cs="Cambria"/><w:i/><w:sz w:val="26"/><w:szCs w:val="26"/></w:rPr>'
function Esc([string]$t) { return $t.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;') }
function TRun([string]$t, [bool]$sup = $false) {
  $v = ''
  if ($sup) { $v = '<w:vertAlign w:val="superscript"/>' }
  return '<w:r><w:rPr>' + $rpr + $v + '</w:rPr><w:t xml:space="preserve">' + (Esc $t.Replace('-', $minus)) + '</w:t></w:r>'
}
function MFrac([string]$n, [string]$d) {
  return '<m:oMath><m:f><m:fPr><m:ctrlPr>' + $mctrl + '</m:ctrlPr></m:fPr><m:num><m:r>' + $mrpr + '<m:t>' + $n + '</m:t></m:r></m:num><m:den><m:r>' + $mrpr + '<m:t>' + $d + '</m:t></m:r></m:den></m:f></m:oMath>'
}
function Expr([string]$s) {
  $out = ''; $pos = 0
  foreach ($m in [regex]::Matches($s, '\{(\d+)/(\d+)\}|\^(\d+)')) {
    if ($m.Index -gt $pos) { $out += (TRun $s.Substring($pos, $m.Index - $pos)) }
    if ($m.Groups[3].Success) { $out += (TRun $m.Groups[3].Value $true) } else { $out += (MFrac $m.Groups[1].Value $m.Groups[2].Value) }
    $pos = $m.Index + $m.Length
  }
  if ($pos -lt $s.Length) { $out += (TRun $s.Substring($pos)) }
  return $out
}
function NumRun([int]$k) {
  return '<w:r><w:rPr><w:rFonts w:ascii="Outfit" w:eastAsia="Outfit" w:hAnsi="Outfit" w:cs="Outfit"/><w:b/><w:bCs/><w:color w:val="14301F"/><w:sz w:val="24"/><w:szCs w:val="24"/></w:rPr><w:t xml:space="preserve">' + $k + '. </w:t></w:r>'
}
function ParaEj([int]$k) { return '<w:p><w:pPr><w:spacing w:after="80"/></w:pPr>' + (NumRun $k) + (Expr $datos[$k - 1][0]) + '</w:p>' }
function ParaResp([int]$k) {
  return '<w:p><w:pPr><w:spacing w:after="60"/><w:ind w:left="360"/></w:pPr><w:r><w:rPr><w:sz w:val="24"/><w:szCs w:val="24"/></w:rPr><w:t xml:space="preserve">= </w:t></w:r>' + (Expr $datos[$k - 1][1]) + '</w:p>'
}

# Reconstruye una tabla de 10 filas x 2 celdas. Usa como molde la fila r (o la ultima de la base) para
# conservar el alto y los bordes. En la tabla de ejercicios todas las filas quedan con el mismo alto.
function Rehacer([string]$tbl, [bool]$resp) {
  $rows = [regex]::Matches($tbl, '(?s)<w:tr[ >].*?</w:tr>')
  $head = $tbl.Substring(0, $rows[0].Index)
  $new = $head
  for ($r = 0; $r -lt 10; $r++) {
    $row = $rows[[Math]::Min($r, $rows.Count - 1)].Value
    $cells = [regex]::Matches($row, '(?s)<w:tc>.*?</w:tc>')
    $nr = '<w:tr>' + $row.Substring($row.IndexOf('>') + 1, $cells[0].Index - $row.IndexOf('>') - 1)   # sin ids repetidos
    if (-not $resp) { $nr = [regex]::Replace($nr, '<w:trHeight w:val="\d+"/>', '<w:trHeight w:val="760"/>') }
    for ($c = 0; $c -lt 2; $c++) {
      $k = $r * 2 + $c + 1
      $tcpr = [regex]::Match($cells[$c].Value, '(?s)<w:tcPr>.*?</w:tcPr>').Value
      $body = (ParaEj $k)
      if ($resp) { $body += (ParaResp $k) }
      $nr += '<w:tc>' + $tcpr + $body + '</w:tc>'
    }
    $new += $nr + '</w:tr>'
  }
  return $new + '</w:tbl>'
}

# Recuadro "Recuerda": conserva el estilo de celda de la base y cambia los parrafos.
function RehacerRecuerda([string]$tbl) {
  $ini = $tbl.IndexOf('<w:p ')
  $fin = $tbl.LastIndexOf('</w:tc>')
  $p1 = '<w:p><w:pPr><w:spacing w:after="80"/></w:pPr>' +
        '<w:r><w:rPr><w:b/><w:bCs/><w:color w:val="14301F"/></w:rPr><w:t xml:space="preserve">Recuerda: </w:t></w:r>' +
        '<w:r><w:t>al multiplicar dos binomios que tienen un t' + $e1 + 'rmino com' + $u1 + 'n (la letra), el resultado es el cuadrado del t' + $e1 + 'rmino com' + $u1 + 'n, m' + $a1 + 's la suma de los otros dos t' + $e1 + 'rminos por el t' + $e1 + 'rmino com' + $u1 + 'n, m' + $a1 + 's el producto de los otros dos t' + $e1 + 'rminos.</w:t></w:r></w:p>'
  $p2 = '<w:p><w:pPr><w:spacing w:after="60"/><w:jc w:val="center"/></w:pPr>' + (Expr '(x + a)(x + b) = x^2 + (a + b)x + ab') + '</w:p>'
  $p3 = '<w:p><w:pPr><w:jc w:val="center"/></w:pPr>' +
        '<w:r><w:rPr><w:b/><w:bCs/><w:color w:val="14301F"/></w:rPr><w:t xml:space="preserve">Ejemplo: </w:t></w:r>' +
        (Expr '(x + 3)(x - 5) = x^2 + (3 - 5)x + (3)(-5) = x^2 - 2x - 15') + '</w:p>'
  return $tbl.Substring(0, $ini) + $p1 + $p2 + $p3 + $tbl.Substring($fin)
}

# ---- leer la base y cambiar document.xml ----
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path -LiteralPath $Out) { throw "Ya existe $Out; no se sobrescribe." }
$src = [IO.Compression.ZipFile]::OpenRead($Base)
$sr = New-Object IO.StreamReader($src.GetEntry('word/document.xml').Open(), $utf8)
$doc = $sr.ReadToEnd(); $sr.Close()

$tbls = [regex]::Matches($doc, '(?s)<w:tbl>.*?</w:tbl>')
if ($tbls.Count -ne 5) { throw "Se esperaban 5 tablas en la base y hay $($tbls.Count)." }
$t1 = $tbls[1]; $t2 = $tbls[2]; $t4 = $tbls[4]
$doc = $doc.Substring(0, $t1.Index) + (RehacerRecuerda $t1.Value) +
       $doc.Substring($t1.Index + $t1.Length, $t2.Index - $t1.Index - $t1.Length) + (Rehacer $t2.Value $false) +
       $doc.Substring($t2.Index + $t2.Length, $t4.Index - $t2.Index - $t2.Length) + (Rehacer $t4.Value $true) +
       $doc.Substring($t4.Index + $t4.Length)

$tema = 'Binomios con t' + $e1 + 'rmino com' + $u1 + 'n'
$n0 = $doc.Length
$doc = $doc.Replace("Serie $BaseNum $dot Binomios conjugados", "Serie $Num $dot $tema").Replace("Respuestas $dot Serie $BaseNum", "Respuestas $dot Serie $Num").Replace('BINOMIOS CONJUGADOS', $tema.ToUpper())
$doc = $doc.Replace('Instrucciones: desarrolla los siguientes productos de binomios conjugados. Escribe el resultado en el espacio de cada ejercicio.',
                    'Instrucciones: multiplica los siguientes binomios con un t' + $e1 + 'rmino com' + $u1 + 'n aplicando la regla. Escribe el resultado, ya reducido, en el espacio de cada ejercicio.')
if ($doc -match 'conjugados') { throw 'Quedo texto de "conjugados" sin cambiar.' }

# propiedades del documento (autora)
$now = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$autora = 'Mar' + [char]0x00ED + 'a del Carmen P' + $e1 + 'rez Zarate'
$core = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>Serie ' + $Num + ' - ' + $tema + '</dc:title><dc:creator>' + $autora + '</dc:creator><cp:lastModifiedBy>' + $autora + '</cp:lastModifiedBy><dcterms:created xsi:type="dcterms:W3CDTF">' + $now + '</dcterms:created><dcterms:modified xsi:type="dcterms:W3CDTF">' + $now + '</dcterms:modified></cp:coreProperties>'

# comprobar que el XML queda bien formado antes de empaquetar
$null = [xml]$doc

# ---- empaquetar ----
$fs = [IO.File]::Open($Out, [IO.FileMode]::CreateNew)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
foreach ($e in $src.Entries) {
  $ne = $zip.CreateEntry($e.FullName); $o = $ne.Open()
  if ($e.FullName -eq 'word/document.xml') { $bytes = $utf8.GetBytes($doc); $o.Write($bytes, 0, $bytes.Length) }
  elseif ($e.FullName -eq 'docProps/core.xml') { $bytes = $utf8.GetBytes($core); $o.Write($bytes, 0, $bytes.Length) }
  else { $i = $e.Open(); $i.CopyTo($o); $i.Close() }
  $o.Close()
}
$zip.Dispose(); $fs.Close(); $src.Dispose()
"Serie: $Out ($((Get-Item -LiteralPath $Out).Length) bytes)"
