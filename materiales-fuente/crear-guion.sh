#!/bin/sh
# Crea voz/<video>.json a partir de líneas "segundo|texto" (o "segundo|congelar|texto") leídas de la entrada estándar.
# Uso:  sh crear-guion.sh <video> <fuente.mp4> < guion.txt
awk -F'|' -v v="$1" -v f="$2" 'BEGIN{printf "{\n  \"video\": \"%s\",\n  \"fuente\": \"%s\",\n  \"voz\": \"Microsoft Sabina Desktop\",\n  \"escenas\": [\n    { \"n\": 0, \"voz\": [\n", v, f}
NF>=2 && $1!="" { if (n++) printf ",\n"; if (NF==3) printf "      { \"s\": %s, \"h\": %s, \"texto\": \"%s\" }", $1, $2, $3; else printf "      { \"s\": %s, \"texto\": \"%s\" }", $1, $2 }
END{printf "\n    ] }\n  ]\n}\n"}' > "$(dirname "$0")/voz/$1.json"
