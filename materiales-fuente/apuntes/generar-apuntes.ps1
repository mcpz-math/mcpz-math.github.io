# Genera los apuntes en PDF (apuntes de clase) a partir de los .html de esta carpeta, con Microsoft Edge sin ventana.
# Uso: powershell -ExecutionPolicy Bypass -File generar-apuntes.ps1 -Root <carpeta del sitio> [-Destino <carpeta para copiar los PDF>]
# Los PDF quedan en <sitio>\matematicas-3\materiales\ (con el mismo nombre del .html, terminado en .pdf).
param([string]$Root, [string]$Destino = '')
$ErrorActionPreference = 'Stop'
$edge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
if (-not (Test-Path -LiteralPath $edge)) { throw 'No encontre Microsoft Edge.' }
$src = Join-Path $Root 'materiales-fuente\apuntes'
$out = Join-Path $Root 'matematicas-3\materiales'
New-Item -ItemType Directory -Force -Path $out | Out-Null
foreach ($f in (Get-ChildItem -LiteralPath $src -Filter 'apunte-*.html')) {
  $pdf = Join-Path $out ($f.BaseName + '.pdf')
  $url = ([System.Uri]$f.FullName).AbsoluteUri
  $tmp = Join-Path ([IO.Path]::GetTempPath()) ('edge-' + [guid]::NewGuid().ToString('N'))
  $tpdf = Join-Path ([IO.Path]::GetTempPath()) ('apunte-' + [guid]::NewGuid().ToString('N') + '.pdf')   # ruta sin acentos
  # las rutas van entre comillas: la carpeta temporal puede tener espacios y acentos
  $a = @('--headless', '--disable-gpu', ('--user-data-dir="' + $tmp + '"'), '--no-pdf-header-footer', '--virtual-time-budget=15000', ('--print-to-pdf="' + $tpdf + '"'), $url)
  $p = Start-Process -FilePath $edge -ArgumentList $a -PassThru -Wait -WindowStyle Hidden
  Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
  if (-not (Test-Path -LiteralPath $tpdf)) { throw "No se genero el PDF de $($f.Name)" }
  Copy-Item -LiteralPath $tpdf -Destination $pdf -Force
  Remove-Item -LiteralPath $tpdf -Force
  "$($f.Name) -> $pdf ($((Get-Item -LiteralPath $pdf).Length) bytes)"
  if ($Destino -ne '') { Copy-Item -LiteralPath $pdf -Destination (Join-Path $Destino ($f.BaseName + '.pdf')) -Force }
}
