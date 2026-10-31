# Genera las pistas de voz de un video a partir de su guion (materiales-fuente\voz\<video>.json).
# Usa la voz "Microsoft Sabina Desktop" (español de México) que ya trae Windows: no necesita internet.
# Cada frase queda en materiales-fuente\voz\<video>\eNN-J.wav (NN = escena, J = número de frase).
# Esos .wav no se suben a GitHub (se pueden volver a crear con este script).
#
# Uso:  powershell -File materiales-fuente\generar-voz.ps1 -Video binomio-al-cuadrado
param([Parameter(Mandatory = $true)][string]$Video, [int]$Velocidad = 2)

Add-Type -AssemblyName System.Speech
$aqui = Split-Path -Parent $MyInvocation.MyCommand.Path
$guion = Get-Content -Raw -Encoding UTF8 (Join-Path $aqui "voz\$Video.json") | ConvertFrom-Json
$carpeta = Join-Path $aqui "voz\$Video"
New-Item -ItemType Directory -Force $carpeta | Out-Null
Get-ChildItem $carpeta -Filter *.wav | Remove-Item

$formato = New-Object System.Speech.AudioFormat.SpeechAudioFormatInfo(48000, [System.Speech.AudioFormat.AudioBitsPerSample]::Sixteen, [System.Speech.AudioFormat.AudioChannel]::Mono)
$tts = New-Object System.Speech.Synthesis.SpeechSynthesizer
$tts.SelectVoice($guion.voz)
$tts.Rate = $Velocidad

$cuantas = 0
foreach ($e in $guion.escenas) {
  $j = 0
  foreach ($v in $e.voz) {
    $arch = Join-Path $carpeta ('e{0:D2}-{1}.wav' -f $e.n, $j)
    $tts.SetOutputToWaveFile($arch, $formato)
    $tts.Speak($v.texto)
    $tts.SetOutputToNull()
    $j++; $cuantas++
  }
}
$tts.Dispose()
"Listo: $cuantas frases en $carpeta"
