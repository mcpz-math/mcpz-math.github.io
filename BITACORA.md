# Bitácora del proyecto

Registro de lo que vamos haciendo, en orden cronológico.

## 2026-09-09
- Se creó la cuenta de GitHub `mcpz-math`.
- Se creó el repositorio `mcpz-math/mcpz-math.github.io` (público, para GitHub Pages).
- Se creó la carpeta local del proyecto en el Escritorio.
- Se agregaron los archivos `CLAUDE.md` (preferencias de trabajo) y `BITACORA.md` (este archivo).
- Se instalaron Git y GitHub CLI en la computadora de Carmen; se conectó la cuenta `mcpz-math` mediante autenticación por navegador.
- Se creó una página de inicio provisional (`index.html`) y se subió todo al repositorio. El sitio quedará publicado en https://mcpz-math.github.io (puede tardar 1-2 minutos en activarse la primera vez).

## 2026-09-09 (continuación)
- Se definió el estilo visual "Compás": verde bosque + crema + formas geométricas, tipografías Outfit (títulos) y Karla (texto).
- Se rediseñó la página de inicio con enlaces a los 6 cursos: Matemáticas 1 a 5 y la optativa Probabilidad y Estadística.
- Se creó una página individual para cada curso (`matematicas-1.html` … `matematicas-5.html`, `probabilidad-estadistica.html`), cada una con espacios listos para Temario, Materiales y Tareas (pendientes de llenar).
- Los estilos compartidos quedaron en `assets/style.css`.
- Se agregó la etiqueta "Próximamente" a todos los cursos excepto Matemáticas 3.

## 2026-09-09 (reorganización por materia)
- Se definió el flujo de trabajo para ir agregando temas: Carmen comparte el contenido
  (texto, PDF, Word o imagen) de un tema, se arma la página dentro de la carpeta de esa
  materia, se sincroniza con GitHub y se anota aquí.
- Se reorganizó el sitio: cada materia ahora tiene su propia carpeta con su página
  principal en `index.html` (por ejemplo `matematicas-1/index.html`), en lugar de un
  archivo suelto por curso. Así cada materia puede crecer con varios temas y materiales
  dentro de su propia carpeta.

## 2026-09-09 (temario de Matemáticas 3)
- Carmen compartió la "Hoja de registro_MateIII_2026_2027A.pdf" con el temario oficial
  del curso. Se extrajeron 10 temas: Sistemas de ecuaciones simultáneas, Inecuaciones,
  Valor absoluto, Funciones, Funciones cuadráticas, Productos notables y factorización,
  Circunferencia, Parábola, Elipse e Hipérbola.
- `matematicas-3/index.html` ahora es el temario: lista los 10 temas con sus subtemas,
  cada uno enlazado a su propia página independiente
  (`matematicas-3/tema-01-....html` … `tema-10-....html`).
- Cada página de tema tiene espacios listos para llenar contenido, materiales y tarea
  por subtema (pendiente).

## 2026-09-09 (contenido Tema 1)
- Carmen compartió "Clase 1. Sistemas de ecuaciones.pdf" con el contenido de la primera
  clase. Se llenó `matematicas-3/tema-01-sistemas-de-ecuaciones-simultaneas.html` con:
  introducción, definición, el ejemplo del conejo y la palmera, la lista de métodos de
  solución, y las explicaciones de los subtemas Gráfico y Cramer.
- Materiales y tarea del Tema 1 siguen pendientes.

## 2026-09-09 (subtema Gráfico)
- Carmen compartió "Clase 2. Método gráfico.doc.pdf". Se creó una página propia para el
  subtema `matematicas-3/tema-01-grafico.html` (siguiendo el mismo patrón de página
  independiente que los temas), con: objetivo general, antecedentes, los 3 casos posibles
  (solución única / infinito de soluciones / sin solución, con diagramas en SVG), el
  procedimiento de 5 pasos, y el ejemplo resuelto con una gráfica real de las dos rectas
  y su punto de intersección (2, −1), más la comprobación.
- El bloque "Gráfico" dentro de `tema-01-sistemas-de-ecuaciones-simultaneas.html` ahora
  enlaza a esa página ("Ver contenido completo →").
- Criterio para futuras clases: cuando el material de un subtema sea extenso (como en
  este caso), se le da su propia página `tema-XX-nombre-subtema.html` en vez de meterlo
  en el bloque del temario del tema.

## 2026-09-09 (ejercicios del subtema Gráfico)
- Carmen compartió "Serie1_grafico.pdf" con 10 ejercicios de sistemas de ecuaciones para
  resolver por método gráfico, más una rúbrica de evaluación con 5 competencias.
- Se agregó la sección "Ejercicios — Serie 1" a `matematicas-3/tema-01-grafico.html`,
  con el propósito, las instrucciones, los 10 ejercicios en tarjetas numeradas, y la
  rúbrica completa en una tabla (con desplazamiento horizontal en pantallas pequeñas).

## 2026-09-11 (subtema Cramer)
- Carmen compartió "Clase 3. Método de Cramer.pdf". Se creó la página propia del subtema
  `matematicas-3/tema-01-cramer.html` con: objetivo general, antecedentes, definición de
  determinante, observación (determinante = 0), el procedimiento de 5 pasos, y el ejemplo
  resuelto completo (sistema 4x−y=5, 2x+5y=−1) con los determinantes principal, de x y de
  y, la solución (x=12/11, y=−7/11) y la comprobación en ambas ecuaciones.
- Se agregó un estilo nuevo en `assets/style.css` para mostrar determinantes con barras
  verticales (clases `.det`, `.det-grid`, `.det-frac`), reutilizable en futuros temas.
- El bloque "Cramer" dentro de `tema-01-sistemas-de-ecuaciones-simultaneas.html` ahora
  enlaza a esa página ("Ver contenido completo →"), igual que el bloque de Gráfico.
- Nota: el PDF original tenía dos pequeñas erratas (decía "método gráfico" en vez de
  "método de Cramer" en el ejemplo, y "y = 3/11" en vez de "y = −7/11"); se corrigieron
  en la página para que coincidan con el procedimiento mostrado.

## 2026-09-11 (ejercicios del subtema Cramer)
- Carmen compartió "Serie 1_Cramer.pdf" con 10 ejercicios de sistemas de ecuaciones para
  resolver por el método de Cramer, más una rúbrica de evaluación con 5 competencias
  específicas del método (organización en determinantes, cálculo del determinante
  principal, aplicación del método, argumentación y verificación).
- Se agregó la sección "Ejercicios — Serie 1" a `matematicas-3/tema-01-cramer.html`, con
  el propósito, las instrucciones, los 10 ejercicios en tarjetas numeradas, y la rúbrica
  completa en una tabla.

## 2026-09-11 (cambio de nombre en el sitio)
- Se reemplazó "Prof. Carmen Pérez" por "DTI. Maria del Carmen Pérez Zarate" en las 19
  páginas del sitio (título de pestaña, menú superior y pie de página de cada página).

## 2026-09-11 (IEMS en vez de Bachillerato)
- Se reemplazó "Bachillerato" por "IEMS" en el pie de página de las 19 páginas del sitio
  y en el eyebrow de la página de inicio ("Matemáticas · IEMS").

## 2026-09-11 (contenido del Tema 2: Inecuaciones)
- Carmen compartió "Clase 4. Inecuaciones.pdf". Se llenó `matematicas-3/tema-02-inecuaciones.html`
  con propósito, aprendizajes esperados y antecedentes de la clase, y se enlazaron sus dos
  subtemas a páginas propias:
  - `tema-02-intervalos-y-desigualdades.html`: qué es una desigualdad, tabla de símbolos
    (<, >, ≤, ≥), Actividad 1 (tabla para llenar: expresión verbal → desigualdad →
    intervalo), clasificación de intervalos (cerrado/abierto/semiabierto), enlace al
    recurso de Khan Academy, y el ejercicio de clase con 15 desigualdades para representar
    como intervalo y gráfica.
  - `tema-02-inecuaciones-lineales.html`: qué es una inecuación, los 3 pasos para
    resolverla, y los dos ejemplos resueltos completos paso a paso, cada uno con su
    gráfica en la recta numérica (círculo relleno o vacío según el signo) y su intervalo.
- Se reutilizaron los estilos existentes (`callout`, `steps`, `example-box`, `blocks`,
  `exercise-grid`, `table-scroll`, `graph-figure`) sin necesidad de agregar CSS nuevo.

## 2026-09-11 (un solo cuadro por ejemplo, Tema 2)
- En `tema-02-inecuaciones-lineales.html`, se unieron los pasos, la gráfica en la recta
  numérica y el intervalo de cada ejemplo en un solo cuadro (antes eran tres cuadros
  separados por ejemplo).

## 2026-09-11 (fracciones sin diagonal)
- Carmen pidió que, de ahora en adelante, las fracciones se escriban apiladas
  (numerador sobre denominador) en vez de con diagonal "/". Se agregó la clase
  reutilizable `.frac` (con `.num`/`.den`, y el modificador `.frac-inline` para texto
  corrido o tarjetas pequeñas) en `assets/style.css`.
- Se corrigieron todas las fracciones existentes en `matematicas-3/tema-01-cramer.html`,
  `matematicas-3/tema-01-grafico.html`, `matematicas-3/tema-02-inecuaciones-lineales.html`
  y `matematicas-3/tema-02-intervalos-y-desigualdades.html`, incluyendo las etiquetas de
  valores dentro de las gráficas SVG de recta numérica.
- Este formato debe usarse en todo el contenido nuevo de aquí en adelante.

## 2026-09-11 (corrección: el sitio se veía vacío en pantallas grandes)
- Carmen reportó que el sitio se veía bien en el celular pero muy vacío en la
  computadora. Se encontró la causa: un estilo en línea
  (`margin-left:0; margin-right:0;`) en el encabezado de cada una de las 21 páginas
  dejaba el contenido pegado a la izquierda en vez de centrarlo, y la mayoría de las
  secciones (textos, cuadros, tablas, cuadrículas) no tenían un ancho máximo, así que
  en monitores anchos se estiraban o dejaban un enorme espacio vacío a la derecha.
- Se corrigió en `assets/style.css`: cada tipo de sección ahora tiene su propio ancho
  máximo centrado (encabezados y cuadrícula de cursos a 1040px, texto/cuadros/tablas a
  760px, párrafos a 68ch), usando `width: min(100% - 3rem, Npx); margin: 0 auto;` — esto
  se ve igual que antes en el celular (mismo margen de 1.5rem) y centrado en pantallas
  grandes.
- También se aseguró que la cuadrícula de cursos de la portada muestre siempre 1, 2 o 3
  columnas según el ancho de pantalla (antes podía dejar una columna vacía a la derecha).
- Se quitó el estilo en línea roto de las 21 páginas (`class="course-header wrap"
  style="margin-left:0; margin-right:0;"` → `class="course-header"`, y lo mismo para
  `.hero` en la portada).

## 2026-09-11 (fórmulas de Cramer como una sola pieza, no cuadros sueltos)
- Carmen notó que en la fórmula del determinante (y en los pasos 2, 3 y 4 del ejemplo
  resuelto) cada pedazo de texto ("Δ =", "= ad − bc", etc.) se veía en su propia
  pastilla con borde, separado del diagrama del determinante, en vez de leerse como una
  sola fórmula.
- Se agregó la clase `.eq-plain` en `assets/style.css` (mismo estilo tipográfico que
  `.eq`, pero sin fondo ni borde) y se usó en esos fragmentos de `tema-01-cramer.html`,
  dejando intactas las ecuaciones que sí van solas en su propia línea (como
  "4x − y = 5"), que conservan su pastilla.

## 2026-09-13 (video recomendado en Cramer)
- Carmen pidió sugerencias de video sobre el método de Cramer para complementar el
  ejemplo resuelto de la clase. Se buscó y se agregó la sección "Video recomendado" en
  `matematicas-3/tema-01-cramer.html`, con un enlace a "Sistemas de ecuaciones lineales
  2x2 | Determinantes - Método de Cramer | Ejemplo 1" (canal julioprofe en YouTube), que
  sigue el mismo procedimiento (Δ, Δx, Δy) que la página.

## 2026-09-13 (color de los cuadros de observación)
- Carmen pidió cambiar el color de los cuadros de observación (los que antes eran verde
  bosque con texto crema, usados para "Objetivo general", "Propósito" y "Observación") a
  un verde más claro. Se agregaron las variables `--callout-bg` (#e4f1d3) y
  `--callout-border` (#c3dba3) en `assets/style.css`, con texto en verde bosque y la
  etiqueta en verde musgo, aplicado automáticamente en todas las páginas del sitio.

## 2026-09-13 (videos recomendados en Método gráfico)
- Carmen pidió videos sobre cómo transformar la ecuación general de la recta a su forma
  normal y graficar usando pendiente y ordenada al origen. Se agregó la sección "Videos
  recomendados" en `matematicas-3/tema-01-grafico.html`, con dos enlaces: "Pasar de la
  ecuación General (Fundamental) a la Ordinaria (pendiente-ordenada)" y "La gráfica de
  una ecuación en la forma pendiente-ordenada al origen" (Khan Academy).

## 2026-09-19 (videos incrustados, se reproducen directo en la página)
- Carmen pidió que los videos de Matemáticas 3 se vean desde que se abre la página, sin
  tener que dar clic para abrir YouTube en otra pestaña. Se agregó el estilo
  `.video-embed` en `assets/style.css` (marco con esquinas redondeadas, proporción 16:9,
  responsivo) y se incrustó el reproductor directo de YouTube en:
  - `matematicas-3/tema-01-grafico.html` (video "Pasar de la ecuación General...").
  - `matematicas-3/tema-01-cramer.html` (video del método de Cramer).
  El enlace a Khan Academy en esas mismas páginas y en
  `matematicas-3/tema-02-intervalos-y-desigualdades.html` se dejó como enlace (Khan
  Academy no permite incrustar sus páginas directamente en otros sitios).

## 2026-09-19 (animación interactiva de pendiente y ordenada al origen)
- Carmen pidió un video que explicara cómo graficar una recta usando la pendiente y la
  ordenada al origen. Como no se puede generar un video real, en su lugar se creó una
  página nueva con una animación interactiva: `matematicas-3/tema-01-pendiente-ordenada.html`.
  Permite mover controles (sube, corre y ordenada b) y ver la ecuación, el punto (0, b),
  el segundo punto y la recta actualizarse en vivo, además de un botón "Reproducir
  animación" que muestra el procedimiento paso a paso y un botón "Otro ejemplo" para
  practicar con valores aleatorios. Se agregaron los estilos correspondientes
  (`.pg-*` y el estado `.steps li.active`) en `assets/style.css`, y se enlazó esta
  página desde los antecedentes de `matematicas-3/tema-01-grafico.html`.

## 2026-09-19 (el enlace a la animación no se veía)
- Carmen avisó que no encontraba cómo llegar a la animación interactiva desde la página
  de Método gráfico (el enlace anterior era texto chico dentro de un paréntesis). Se
  reemplazó por un bloque destacado con un botón claro: "Practicar con la animación
  interactiva →", justo después de los antecedentes.

## 2026-09-19 (ordenada b con fracciones)
- Carmen pidió que la animación de pendiente y ordenada también contemplara valores de
  b con fracciones (ordenada racional), no solo enteros. Se cambió el control de
  "Ordenada b" por dos controles (numerador y denominador), igual que ya existían para
  la pendiente. La ecuación, las coordenadas de los puntos y las fracciones se
  simplifican automáticamente (por ejemplo 4/2 se muestra como 2). El ejemplo inicial
  ahora usa b = −3/2, el mismo valor del ejemplo resuelto en la página de Método
  gráfico.

## 2026-09-19 (un solo control para la ordenada b)
- Carmen avisó que, al mover el control de la ordenada, sólo podía usar valores
  enteros. El motivo era que se había dividido en dos controles (numerador y
  denominador) y cada uno, por separado, sólo se mueve en enteros. Se simplificó a un
  solo control "Ordenada b" que se mueve en cuartos, así que al arrastrarlo ya se
  obtienen enteros, medios y cuartos (por ejemplo −3/2 o 5/4), y el valor se muestra ya
  simplificado debajo del control.

## 2026-09-19 (casillas para escribir los valores)
- Carmen pidió poder escribir directamente los valores de la pendiente y la ordenada,
  en lugar de solo usar deslizadores. Se agregó una casilla de texto junto a cada
  deslizador (sube, corre y ordenada b), sincronizada en ambos sentidos: se puede
  arrastrar el deslizador o escribir el número. En la casilla de b también se puede
  escribir una fracción directamente (por ejemplo "-3/2" o "7/3"), no solo enteros o
  decimales. Si lo que se escribe no es válido, la casilla se marca en rojo y, al salir
  de ella, regresa al último valor válido.

## 2026-09-19 (escala de la cuadrícula según el denominador de b)
- Carmen pidió ver la escala en el plano cartesiano: por ejemplo, si la ordenada es
  3/4, que se vea que cada 4 cuadros equivale a una unidad. Se agregó una cuadrícula
  que se subdivide automáticamente según el denominador de b (ya simplificado): si
  b = 3/4 se dibujan 4 cuadros por unidad, si b = 5/3 se dibujan 3, etc. Debajo de la
  gráfica aparece una nota ("Escala de esta cuadrícula: cada N cuadros = 1 unidad")
  que se actualiza junto con los controles; cuando b es un número entero no se
  muestra ninguna nota y la cuadrícula vuelve a su forma normal.

## 2026-09-27 (contenido Tema 3: Valor absoluto)
- Carmen notó que no se veían cambios en Valor absoluto: la página seguía vacía porque
  su contenido nunca se había subido a GitHub. Compartió el PDF "Clase 5. Valor
  absoluto" y con él se llenó `matematicas-3/tema-03-valor-absoluto.html`.
- La página incluye: objetivo general, definición (con la fórmula por casos), el
  ejercicio en clase (10 ecuaciones), la gráfica de y = |x|, los 5 pasos para resolver
  desigualdades con valor absoluto y los dos ejemplos (|3x − 2| < 4 y |4x + 3| ≥ 2) con
  su gráfica en la escala indicada y la solución como intervalo.
- En cada ejemplo hay un botón "Ver cómo se hizo en el cuaderno" que muestra la foto
  original de la hoja cuadriculada.
- Nueva carpeta `matematicas-3/materiales/` con el PDF de la clase (descargable desde
  la página) y las fotos de los ejemplos.
- Carmen pidió marcar en las gráficas la parte del valor absoluto que da la solución.
  En los dos ejemplos se resalta en rojo el tramo de la "V" que cumple la desigualdad
  (debajo de y = 4 en el ejemplo 1; arriba de y = 2 en el ejemplo 2), igual que en las
  fotos del cuaderno, y se actualizó el texto debajo de cada gráfica.

## 2026-09-27 (videos paso a paso de Inecuaciones)
- Carmen pidió un video que muestre, paso por paso, la solución de los ejemplos de
  Inecuaciones. Se crearon dos videos cortos (unos 45 segundos cada uno, sin audio) con el
  estilo "Compás": aparece la inecuación y luego cada paso con su explicación; en el
  último paso se resalta el signo (se invierte en el ejemplo 1 y no cambia en el 2) y al
  final se dibuja la solución en la recta numérica y se escribe el intervalo.
- Los videos están en `matematicas-3/materiales/` (`tema-02-inecuaciones-ejemplo-1.mp4`
  y `-2.mp4`, con su imagen de portada) y se muestran en
  `tema-02-inecuaciones-lineales.html`, debajo de cada ejemplo.
- A pedido de Carmen, los videos se hicieron más lentos (ahora cada paso dura unos
  8 segundos; cada video dura 1 min 12 s) y se reacomodaron para que **los 6 pasos se
  vean completos en pantalla** al mismo tiempo (antes los primeros pasos se subían y
  desaparecían). Ahora cada paso ocupa una fila: explicación a la izquierda y ecuación a
  la derecha. La portada del video muestra todos los pasos.

## 2026-09-27 (videos paso a paso de Valor absoluto)
- Carmen pidió videos también para los ejemplos de Valor absoluto. Se crearon dos
  videos (55 segundos cada uno, sin audio, estilo "Compás"): del lado izquierdo aparecen
  los 5 pasos del método y del lado derecho se dibuja la gráfica al mismo tiempo: se
  traza la recta con su escala, la parte negativa se "dobla" hacia arriba, se traza la
  horizontal, se resalta en rojo la parte de la "V" que cumple la desigualdad y se marca
  la solución sobre el eje x junto con el intervalo.
- Archivos en `matematicas-3/materiales/` (`tema-03-valor-absoluto-ejemplo-1.mp4` y
  `-2.mp4`, con su portada); se muestran en `tema-03-valor-absoluto.html` debajo de la
  solución de cada ejemplo.

## 2026-09-27 (Inecuaciones: solo videos en los ejemplos)
- A pedido de Carmen, en `tema-02-inecuaciones-lineales.html` se quitó el desarrollo
  escrito de los Ejemplos 1 y 2 (pasos, recta numérica e intervalo). Ahora cada ejemplo
  muestra solo su video paso a paso. Se conservan la explicación inicial, los pasos para
  resolver una inecuación lineal y la observación final.

## 2026-09-27 (música clásica en los videos)
- A pedido de Carmen, los 4 videos (Inecuaciones y Valor absoluto, ejemplos 1 y 2)
  ahora tienen música de fondo: el **Preludio en Do mayor, BWV 846, de J. S. Bach**
  (obra de dominio público), generado como piano suave, a volumen bajo, con entrada y
  salida graduales. Los videos siguen sin voz.

## 2026-09-27 (Tema 4: Funciones — Definición y prueba de la recta vertical)
- Carmen compartió el PDF "Clase 6. Funciones" para el subtema "Definición y prueba de
  la recta vertical". Se creó la página `matematicas-3/tema-04-definicion.html`, enlazada
  desde el bloque de ese subtema en `tema-04-funciones.html`.
- Contenido: objetivo, definición de función y de relación, Actividad 1 (tabla para
  llenar), formas de representación, Actividad 2 (diagramas sagitales a–d), Actividad 3
  (conjuntos de pares A–E), representación geométrica y prueba de la recta vertical,
  Actividad 4 (9 gráficas), representación analítica y =  f(x), clasificación de funciones
  (con las tres que se ven en el curso resaltadas).
- Los diagramas sagitales, las gráficas y la clasificación se redibujaron con el estilo
  del sitio (la imagen original de la clasificación traía marca de agua de otro sitio).
- Correcciones al texto: "y: variable **dependiente**" (el PDF decía independiente) y en
  el conjunto C el primer par se escribió (1, 1) (el PDF decía (1.1)).
- El PDF se agregó a `matematicas-3/materiales/clase-06-funciones.pdf` y se puede
  descargar desde la página del subtema y desde "Materiales" del Tema 4.

## 2026-09-27 (Tema 1: ejercicios y rúbrica del método gráfico pasan a Tareas)
- A pedido de Carmen, los "Ejercicios — Serie 1" y la "Rúbrica" del método gráfico se
  movieron de `tema-01-grafico.html` a una nueva página de tareas:
  `matematicas-3/tema-01-tarea.html` ("Tarea: método gráfico"), sin cambiar su contenido.
- El bloque "Tarea" de `tema-01-sistemas-de-ecuaciones-simultaneas.html` ahora enlaza a
  esa página, y al final de la página del método gráfico queda un aviso con el enlace.
- También se movieron los "Ejercicios — Serie 1" y la "Rúbrica" del método de Cramer
  (`tema-01-cramer.html`) a la misma página de tareas, que ahora se llama "Tareas:
  sistemas de ecuaciones simultáneas" y tiene dos partes: método gráfico y método de
  Cramer. Los avisos de cada método enlazan directo a su parte.
- A pedido de Carmen, las dos rúbricas de la página de tareas del Tema 1 ahora son
  **desplegables**: aparecen cerradas con un botón "+ Ver rúbrica del método …" y se
  abren al tocarlo (el botón cambia a "−" para cerrarla). Estilo `details.rubric` en
  `assets/style.css`, reutilizable en otras páginas.
- A pedido de Carmen, los títulos "Método gráfico — Ejercicios, Serie 1" y "Método de
  Cramer — Ejercicios, Serie 1" de la página de tareas se hicieron más grandes (títulos
  en letra Outfit, verde bosque, con una línea verde-lima debajo). Estilo `.task-title`
  en `assets/style.css`.
- A pedido de Carmen, "Serie 1" ahora aparece **después del propósito**: los títulos
  grandes quedan como "Método gráfico — Ejercicios" y "Método de Cramer — Ejercicios";
  debajo va el Propósito, luego el subtítulo "Serie 1" y después las instrucciones y los
  ejercicios. Estilo `.task-subtitle` en `assets/style.css`.
- A pedido de Carmen, el **Propósito** de cada método (gráfico y Cramer) en la página de
  tareas ahora va dentro de un cuadro verde (el mismo estilo `callout` que se usa para
  "Objetivo" y "Observación" en otras páginas).
- Respuestas de la Serie 1 del método gráfico: a pedido de Carmen, cada ejercicio tiene
  un botón desplegable **"Ver respuesta"** con el resultado (solución única con x y y,
  infinitas soluciones o sin solución), las dos rectas en forma y = mx + b y una gráfica
  pequeña con el punto de intersección. Arriba de los ejercicios se agregó la indicación
  "Resuélvelo primero en tu cuaderno y después revisa". La idea es que la Serie 1 sea de
  práctica (con respuestas) y la Serie 2 de evaluación (sin respuestas; pendiente de que
  Carmen revise la propuesta).
- Se publicó la **Serie 2 del método gráfico** (evaluación, sin respuestas en la página),
  debajo de la Serie 1 y antes de la rúbrica: 10 sistemas con los tres casos (8 con
  solución única, 1 sin solución, 1 con infinitas soluciones), respuestas distintas entre
  sí y dos ejercicios que requieren escala. Las respuestas se le dieron a Carmen en el
  chat; no se guardan en el repositorio porque es público.
- **Cramer, igual que el método gráfico:** cada ejercicio de la Serie 1 de Cramer tiene
  ahora un botón "Ver respuesta" con los determinantes (Δ, Δx, Δy) y el resultado; en los
  casos con Δ = 0 se explica si hay infinitas soluciones (misma recta) o ninguna (rectas
  paralelas). Se publicó también la **Serie 2 de Cramer** (evaluación, sin respuestas):
  10 sistemas con 8 de solución única (algunas con fracciones), 1 sin solución y 1 con
  infinitas soluciones, todas las respuestas distintas. Las respuestas de la Serie 2 se
  le dieron a Carmen en el chat; no se guardan en el repositorio porque es público.
- A pedido de Carmen, en las respuestas de la Serie 1 de Cramer ahora se justifica cada
  valor con la fórmula: x = Δx/Δ = (valores) = resultado, y lo mismo para y (con la
  fracción simplificada cuando aplica, por ejemplo −6/4 = −3/2).
