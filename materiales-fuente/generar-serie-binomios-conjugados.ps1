# Genera una Serie de "Binomios conjugados" en Word (.docx) con el mismo formato de la Serie 3:
# encabezado verde, recuadro "Recuerda", 18 ejercicios en dos columnas y pagina de respuestas.
# Toma como base (estilos, pie de pagina, medidas) el .docx de la Serie 3 de Carmen y solo cambia
# el titulo y el contenido de las dos tablas (ejercicios y respuestas).
# Uso: powershell -ExecutionPolicy Bypass -File generar-serie-binomios-conjugados.ps1 -Base <Serie3.docx> -Out <salida.docx> [-Num 4]
# Script solo ASCII. Mini-lenguaje de cada expresion: "-" = signo menos, "^2" = exponente,
# "{1/5}" = fraccion apilada (ecuacion de Word).
param([string]$Base, [string]$Out, [int]$Num = 4)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$dot = [string][char]0x00B7
$minus = [string][char]0x2212

# ---- Serie 4: ejercicio ; resultado ----
$datos = @(
  @('(x + 11)(x - 11)',                  'x^2 - 121'),
  @('(k - 6)(k + 6)',                    'k^2 - 36'),
  @('(4b + 3)(4b - 3)',                  '16b^2 - 9'),
  @('(8z - 5)(8z + 5)',                  '64z^2 - 25'),
  @('(10t - 1)(10t + 1)',                '100t^2 - 1'),
  @('(3r + 8s)(3r - 8s)',                '9r^2 - 64s^2'),
  @('(9u - 4v)(9u + 4v)',                '81u^2 - 16v^2'),
  @('(z^4 + 5)(z^4 - 5)',                'z^8 - 25'),
  @('(3m^3 - 10)(3m^3 + 10)',            '9m^6 - 100'),
  @('(-5b + 6)(-5b - 6)',                '25b^2 - 36'),
  @('(7pq - 9r)(7pq + 9r)',              '49p^2q^2 - 81r^2'),
  @('(6 - 11n^3)(6 + 11n^3)',            '36 - 121n^6'),
  @('(4x^2y + 5z^3)(4x^2y - 5z^3)',      '16x^4y^2 - 25z^6'),
  @('(t + {1/5})(t - {1/5})',            't^2 - {1/25}'),
  @('({2/3}x - 4)({2/3}x + 4)',          '{4/9}x^2 - 16'),
  @('({3/4}a + {2/5})({3/4}a - {2/5})',  '{9/16}a^2 - {4/25}'),
  @('(p^2x + qy^3)(p^2x - qy^3)',        'p^4x^2 - q^2y^6'),
  @('(2x^4y^3 + {3/7}z)(2x^4y^3 - {3/7}z)', '4x^8y^6 - {9/49}z^2')
)

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

# Reconstruye una tabla de 9 filas x 2 celdas conservando fila (alto) y celda (bordes) de la base.
function Rehacer([string]$tbl, [bool]$resp) {
  $rows = [regex]::Matches($tbl, '(?s)<w:tr[ >].*?</w:tr>')
  $head = $tbl.Substring(0, $rows[0].Index)
  $new = $head
  for ($r = 0; $r -lt 9; $r++) {
    $row = $rows[$r].Value
    $cells = [regex]::Matches($row, '(?s)<w:tc>.*?</w:tc>')
    $nr = $row.Substring(0, $cells[0].Index)
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

# ---- leer la base y cambiar document.xml ----
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path -LiteralPath $Out) { throw "Ya existe $Out; no se sobrescribe." }
$src = [IO.Compression.ZipFile]::OpenRead($Base)
$sr = New-Object IO.StreamReader($src.GetEntry('word/document.xml').Open(), $utf8)
$doc = $sr.ReadToEnd(); $sr.Close()

$tbls = [regex]::Matches($doc, '(?s)<w:tbl>.*?</w:tbl>')
if ($tbls.Count -ne 5) { throw "Se esperaban 5 tablas en la base y hay $($tbls.Count)." }
$t2 = $tbls[2]; $t4 = $tbls[4]
$doc = $doc.Substring(0, $t2.Index) + (Rehacer $t2.Value $false) + $doc.Substring($t2.Index + $t2.Length, $t4.Index - $t2.Index - $t2.Length) + (Rehacer $t4.Value $true) + $doc.Substring($t4.Index + $t4.Length)
$doc = $doc.Replace("Serie 3 $dot Binomios conjugados", "Serie $Num $dot Binomios conjugados").Replace("Respuestas $dot Serie 3", "Respuestas $dot Serie $Num")

# propiedades del documento (autora)
$e1 = [char]0x00E9
$now = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$core = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>Serie ' + $Num + ' - Binomios conjugados</dc:title><dc:creator>Mar' + [char]0x00ED + 'a del Carmen P' + $e1 + 'rez Zarate</dc:creator><cp:lastModifiedBy>Mar' + [char]0x00ED + 'a del Carmen P' + $e1 + 'rez Zarate</cp:lastModifiedBy><dcterms:created xsi:type="dcterms:W3CDTF">' + $now + '</dcterms:created><dcterms:modified xsi:type="dcterms:W3CDTF">' + $now + '</dcterms:modified></cp:coreProperties>'

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
