# Genera (1) las rubricas del sitio y (2) la guia para evaluar en Word, a partir de:
#   materiales-fuente\matriz-niveles-evaluacion.json   (texto de la matriz de Carmen)
#   materiales-fuente\rubricas-por-actividad.json      (que observar y niveles concretos por actividad)
# Uso:  powershell -ExecutionPolicy Bypass -File generar-rubricas.ps1 -Root <carpeta del sitio> [-Guia <ruta .docx>] [-SoloGuia]
# El script es solo ASCII a proposito: todo el texto con acentos viene de los JSON (UTF-8).
param(
  [string]$Root,
  [string]$Guia = '',
  [switch]$SoloGuia
)
$utf8 = New-Object System.Text.UTF8Encoding($false)
$matriz = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\matriz-niveles-evaluacion.json'), $utf8) | ConvertFrom-Json
$act    = [IO.File]::ReadAllText((Join-Path $Root 'materiales-fuente\rubricas-por-actividad.json'), $utf8) | ConvertFrom-Json
$et = $act.etiquetas
$nl = "`r`n"
$i = [char]0x00ED
$dot = [char]0x00B7

function Esc([string]$s) { return $s.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;') }

# ------------------------------------------------------------------ SITIO
$th = @(
  @('Nivel 1', 'Insuficiente'),
  @('Nivel 2', 'En desarrollo'),
  @('Nivel 3', ('En desarrollo ' + $dot + ' m' + $i + 'nimo indispensable')),
  @('Nivel 4', 'Suficiente'),
  @('Nivel 5', 'Satisfactorio')
)

function Build-Block($a, [string]$summary) {
  $L = New-Object System.Collections.Generic.List[string]
  $L.Add('<details class="rubric rubric-matriz">')
  $L.Add('    <summary>' + $summary + '</summary>')
  $L.Add('    <div class="table-scroll">')
  $L.Add('      <table class="matriz">')
  $L.Add('        <thead>')
  $L.Add('          <tr>')
  $L.Add('            <th>' + $et.criterio + '</th>')
  foreach ($h in $th) { $L.Add('            <th>' + $h[0] + '<small>' + (Esc $h[1]) + '</small></th>') }
  $L.Add('          </tr>')
  $L.Add('        </thead>')
  $L.Add('        <tbody>')
  foreach ($row in $a.rows) {
    $c = $matriz.comp.($row.id)
    $L.Add('          <tr>')
    $crit = '            <td class="crit"><strong>' + (Esc $c.nombre) + '</strong>'
    if ($c.sub -ne '') { $crit += '<span class="sub">' + (Esc $c.sub) + '</span>' }
    $crit += '<span class="crit-desc">' + (Esc $c.criterio) + '</span>'
    $crit += '<div class="en-act"><strong>' + (Esc $et.observar) + ':</strong><ul>'
    foreach ($o in $row.observar) { $crit += '<li>' + (Esc $o) + '</li>' }
    $crit += '</ul></div></td>'
    $L.Add($crit)
    $L.Add('            <td>' + (Esc $row.n1) + '</td>')
    if ($row.id -eq 'ARG') {
      $L.Add('            <td>' + (Esc $row.n2) + '</td>')
      $L.Add('            <td>' + (Esc $row.n3) + '</td>')
      $L.Add('            <td>' + (Esc $row.n4) + '</td>')
      $L.Add('            <td>' + (Esc $row.n5) + '</td>')
    } elseif ($row.id -eq 'MOD') {
      $L.Add('            <td colspan="2">' + (Esc $row.n23) + '</td>')
      $L.Add('            <td colspan="2">' + (Esc $row.n45) + '</td>')
    } else {
      $L.Add('            <td colspan="2">' + (Esc $row.n23) + '</td>')
      $L.Add('            <td>' + (Esc $row.n4) + '</td>')
      $L.Add('            <td>' + (Esc $row.n5) + '</td>')
    }
    $L.Add('          </tr>')
  }
  $L.Add('        </tbody>')
  $L.Add('      </table>')
  $L.Add('    </div>')
  $L.Add('    <p class="rubric-note">' + $et.nota0 + '</p>')
  $L.Add('  </details>')
  return ($L -join $nl)
}

if (-not $SoloGuia) {
  $rx = [regex]'(?s)<details class="rubric rubric-matriz">\s*<summary>(.*?)</summary>.*?</details>'
  $files = $act.actividades | ForEach-Object { $_.file } | Select-Object -Unique
  foreach ($f in $files) {
    $path = Join-Path $Root ($f.Replace('/', '\'))
    $text = [IO.File]::ReadAllText($path, $utf8)
    $mine = @($act.actividades | Where-Object { $_.file -eq $f })
    $ms = $rx.Matches($text)
    if ($ms.Count -ne $mine.Count) { throw "$f : se esperaban $($mine.Count) rubricas y hay $($ms.Count)" }
    for ($k = $ms.Count - 1; $k -ge 0; $k--) {
      $a = $mine | Where-Object { $_.ocurrencia -eq $k }
      $m = $ms[$k]
      $block = Build-Block $a $m.Groups[1].Value
      $text = $text.Substring(0, $m.Index) + $block + $text.Substring($m.Index + $m.Length)
    }
    [IO.File]::WriteAllText($path, $text, $utf8)
    "$f : $($ms.Count) rubrica(s) del sitio actualizada(s)"
  }
}

# ------------------------------------------------------------------ GUIA EN WORD
if ($Guia -ne '') {
  function Run([string]$t, [bool]$b = $false, [int]$sz = 21, [string]$color = '22301F', [bool]$it = $false) {
    $rpr = '<w:rFonts w:ascii="Calibri" w:hAnsi="Calibri" w:cs="Calibri"/>'
    if ($b) { $rpr += '<w:b/>' }
    if ($it) { $rpr += '<w:i/>' }
    $rpr += '<w:color w:val="' + $color + '"/><w:sz w:val="' + $sz + '"/><w:szCs w:val="' + $sz + '"/>'
    return '<w:r><w:rPr>' + $rpr + '</w:rPr><w:t xml:space="preserve">' + (Esc $t) + '</w:t></w:r>'
  }
  function Para([string]$runs, [int]$before = 0, [int]$after = 100, [int]$left = 0, [int]$hang = 0, [bool]$keep = $false, [int]$outline = -1) {
    $ppr = ''
    if ($keep) { $ppr += '<w:keepNext/>' }
    $ppr += '<w:spacing w:before="' + $before + '" w:after="' + $after + '"/>'
    if ($left -gt 0) { $ppr += '<w:ind w:left="' + $left + '" w:hanging="' + $hang + '"/>' }
    if ($outline -ge 0) { $ppr += '<w:outlineLvl w:val="' + $outline + '"/>' }
    return '<w:p><w:pPr>' + $ppr + '</w:pPr>' + $runs + '</w:p>'
  }
  function Bullet([string]$t) { return (Para ((Run ([string][char]0x2022 + ' ')) + (Run $t)) 0 40 360 240) }
  function Cell([int]$w, [string]$inner, [string]$fill = '') {
    $pr = '<w:tcW w:w="' + $w + '" w:type="dxa"/>'
    if ($fill -ne '') { $pr += '<w:shd w:val="clear" w:color="auto" w:fill="' + $fill + '"/>' }
    return '<w:tc><w:tcPr>' + $pr + '</w:tcPr>' + $inner + '</w:tc>'
  }
  $w1 = 1300; $w2 = 3800; $w3 = 4980
  function Row3([string]$a, [string]$b, [string]$c, [bool]$head = $false) {
    if ($head) {
      $f = '14301F'
      $x = (Cell $w1 (Para (Run $a $true 19 'FFFFFF') 0 0) $f) + (Cell $w2 (Para (Run $b $true 19 'FFFFFF') 0 0) $f) + (Cell $w3 (Para (Run $c $true 19 'FFFFFF') 0 0) $f)
      return '<w:tr><w:trPr><w:tblHeader/></w:trPr>' + $x + '</w:tr>'
    }
    $x = (Cell $w1 (Para (Run $a $true 19 '14301F') 0 0) 'F6F3EA') + (Cell $w2 (Para (Run $b $false 18 '56604F') 0 0)) + (Cell $w3 (Para (Run $c $false 19) 0 0) 'E4F1D3')
    return '<w:tr><w:trPr><w:cantSplit/></w:trPr>' + $x + '</w:tr>'
  }
  $bord = ''
  foreach ($s in 'top', 'left', 'bottom', 'right', 'insideH', 'insideV') { $bord += '<w:' + $s + ' w:val="single" w:sz="4" w:space="0" w:color="B9C7B0"/>' }
  $tblPr = '<w:tblPr><w:tblW w:w="' + ($w1 + $w2 + $w3) + '" w:type="dxa"/><w:tblBorders>' + $bord + '</w:tblBorders><w:tblLayout w:type="fixed"/><w:tblCellMar><w:top w:w="60" w:type="dxa"/><w:left w:w="90" w:type="dxa"/><w:bottom w:w="60" w:type="dxa"/><w:right w:w="90" w:type="dxa"/></w:tblCellMar></w:tblPr><w:tblGrid><w:gridCol w:w="' + $w1 + '"/><w:gridCol w:w="' + $w2 + '"/><w:gridCol w:w="' + $w3 + '"/></w:tblGrid>'

  $B = New-Object System.Collections.Generic.List[string]
  $B.Add((Para (Run $et.guiaTitulo $true 40 '14301F') 0 60))
  $B.Add((Para (Run $et.guiaSub $false 20 '56604F') 0 200))
  $B.Add((Para (Run $et.guiaIntro) 0 120))
  $B.Add((Para (Run $et.guiaSugerencia $false 21 '14301F' $true) 0 120))
  $B.Add((Para (Run $et.guiaNota0 $true 20 '14301F') 0 0))
  $first = $true
  foreach ($a in $act.actividades) {
    $B.Add('<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
    $B.Add((Para (Run $a.titulo $true 30 '14301F') 0 120 0 0 $true 0))
    $B.Add((Para (Run $et.evidencia $true 22 '3F6B4A') 120 60 0 0 $true))
    foreach ($e in $a.evidencia) { $B.Add((Bullet $e)) }
    foreach ($row in $a.rows) {
      $c = $matriz.comp.($row.id)
      $nm = $c.nombre
      if ($c.sub -ne '') { $nm += ' (' + $c.sub + ')' }
      $B.Add((Para (Run $nm $true 24 '14301F') 280 40 0 0 $true 1))
      $B.Add((Para (Run $c.criterio $false 19 '56604F' $true) 0 80 0 0 $true))
      $B.Add((Para (Run ($et.observar + ':') $true 21 '3F6B4A') 0 40 0 0 $true))
      foreach ($o in $row.observar) { $B.Add((Bullet $o)) }
      $B.Add((Para '' 0 60))
      $t = New-Object System.Collections.Generic.List[string]
      $t.Add((Row3 $et.nivel $et.queDiceMatriz $et.queVer $true))
      $t.Add((Row3 ($et.nivel + ' 1') $c.n1 $row.n1))
      if ($row.id -eq 'ARG') {
        $t.Add((Row3 ($et.nivel + ' 2') $c.n2 $row.n2))
        $t.Add((Row3 ($et.nivel + ' 3') $c.n3 $row.n3))
        $t.Add((Row3 ($et.nivel + ' 4') $c.n4 $row.n4))
        $t.Add((Row3 ($et.nivel + ' 5') $c.n5 $row.n5))
      } elseif ($row.id -eq 'MOD') {
        $t.Add((Row3 $et.niveles23 $c.n23 $row.n23))
        $t.Add((Row3 $et.niveles45 $c.n45 $row.n45))
      } else {
        $t.Add((Row3 $et.niveles23 $c.n23 $row.n23))
        $t.Add((Row3 ($et.nivel + ' 4') $c.n4 $row.n4))
        $t.Add((Row3 ($et.nivel + ' 5') $c.n5 $row.n5))
      }
      $B.Add('<w:tbl>' + $tblPr + ($t -join '') + '</w:tbl>')
    }
    $B.Add((Para (Run $et.errores $true 22 '3F6B4A') 280 60 0 0 $true))
    foreach ($e in $a.errores) { $B.Add((Bullet $e)) }
    $B.Add((Para (Run $et.guiaNota0 $false 19 '56604F' $true) 160 0))
  }
  $sect = '<w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1080" w:right="1080" w:bottom="1080" w:left="1080" w:header="567" w:footer="567" w:gutter="0"/></w:sectPr>'
  $ns = 'xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"'
  $doc = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document ' + $ns + '><w:body>' + ($B -join '') + $sect + '</w:body></w:document>'
  $ct = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/></Types>'
  $rels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/></Relationships>'
  Add-Type -AssemblyName System.IO.Compression
  if (Test-Path -LiteralPath $Guia) { Remove-Item -LiteralPath $Guia -Force }
  $fs = [IO.File]::Open($Guia, [IO.FileMode]::Create)
  $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
  foreach ($p in @(@('[Content_Types].xml', $ct), @('_rels/.rels', $rels), @('word/document.xml', $doc))) {
    $e = $zip.CreateEntry($p[0]); $s = $e.Open(); $bytes = $utf8.GetBytes($p[1]); $s.Write($bytes, 0, $bytes.Length); $s.Close()
  }
  $zip.Dispose(); $fs.Close()
  "Guia: $Guia ($((Get-Item -LiteralPath $Guia).Length) bytes)"
}
