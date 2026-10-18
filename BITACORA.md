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
- A pedido de Carmen, en Cramer, cuando Δ = 0 (ejercicios 2, 3 y 6 de la Serie 1) la
  respuesta ahora dice solo: "Δ = 0 — Conclusión: el sistema tiene un infinito de
  soluciones o no tiene solución", igual que la Observación de la página de Cramer (ya no
  se especifica cuál de los dos casos es).
- Carmen pidió regresar a la versión anterior: en Cramer, cuando Δ = 0, la respuesta
  vuelve a decir "Δ = 0: no se puede aplicar Cramer" y a especificar el caso (infinitas
  soluciones porque es la misma recta, o sin solución porque son rectas paralelas).

## 2026-09-27 (Tema 2: respuestas de la Actividad 1 de Intervalos y desigualdades)
- A pedido de Carmen, la tabla de la Actividad 1 ("Comparando expresiones") en
  `tema-02-intervalos-y-desigualdades.html` ya tiene las respuestas: h > 1.60 → (1.60, ∞);
  0 ≤ v ≤ 80 → [0, 80]; 8:00 ≤ t ≤ 8:15 → [8:00, 8:15]; c > 500 → (500, ∞). Debajo de la
  tabla se indica qué representa cada variable (h, v, t, c).
- A pedido de Carmen, las respuestas de esa tabla ahora están escondidas: la tabla de la
  Actividad 1 vuelve a mostrarse vacía y debajo hay un botón desplegable "Ver respuestas"
  que abre la misma tabla ya contestada, con la nota de las variables.
- Actividad 2 (representar como intervalo las expresiones de la Actividad 1): a pedido de
  Carmen, se agregó un botón desplegable "Ver respuestas" con cada expresión, su intervalo
  y su representación en la recta numérica (círculo relleno = extremo incluido, círculo
  vacío = extremo no incluido).
- A pedido de Carmen, el "Ejercicio de clase" de esa página ahora se llama **Actividad 3**
  y, como las otras actividades, tiene un botón desplegable "Ver respuestas" con las 15
  desigualdades: su intervalo y su recta numérica (no a escala), más el recordatorio de
  cuándo va corchete o paréntesis.
- A pedido de Carmen, en `tema-02-intervalos-y-desigualdades.html` se reemplazó el enlace
  a Khan Academy por un video de YouTube incrustado: "Ejercicios con INTERVALOS — Expresar
  como Desigualdad, Intervalo y Representación en Recta Numérica"
  (https://www.youtube.com/watch?v=PmWyGkQ1gtg). Pendiente: que Carmen confirme que el
  video le parece adecuado (desde aquí no se pudo reproducir).
- A pedido de Carmen, las respuestas de la Actividad 3 ahora están **dentro de cada cuadro
  de ejercicio** (botón "Ver respuesta" en cada uno, con el intervalo y su recta numérica),
  en lugar de un solo desplegable al final. El recordatorio de corchetes/paréntesis quedó
  debajo de los ejercicios.
- Carmen eligió otro video para Intervalos y desigualdades: ahora se muestra
  "Representación gráfica de intervalos | Ejemplo 1" (https://www.youtube.com/watch?v=tyt6T1Ukq3w)
  en lugar del de "Ejercicios con INTERVALOS".

## 2026-10-02 (Tema 5: subtema f(x) = x²)
- Carmen no tenía material para este subtema y pidió una propuesta. Se creó
  `matematicas-3/tema-05-x-cuadrada.html` con: objetivo, situación inicial (área de un
  cuadrado), definición, aviso sobre los signos ((−3)² = 9), Actividad 1 (tabla de valores
  de −3 a 3 con "Ver respuestas"), gráfica de la parábola con su eje de simetría,
  características (vértice, abertura, eje de simetría, dominio, rango, crece/decrece),
  Actividad 2 (evaluar la función), Actividad 3 (¿el punto está en la parábola?) y
  Actividad 4 (¿qué x da ese resultado?), cada ejercicio con su botón "Ver respuesta".
- El bloque "f(x) = x²" de `tema-05-funciones-cuadraticas.html` ahora enlaza a esta página.
- Pendiente: que Carmen revise la propuesta y diga qué quiere cambiar.

## 2026-10-02 (Tema 5: subtema f(x) = ax²)
- Carmen pidió seguir con f(x) = ax² (sin material propio; se hizo una propuesta). Se creó
  `matematicas-3/tema-05-ax-cuadrada.html` con: objetivo, recordatorio de x², qué es el
  coeficiente a (y por qué a ≠ 0), Actividad 1 (tabla comparativa de x², 2x², ½x² y −x² con
  "Ver respuestas"), dos gráficas comparativas (a > 0 y a < 0), qué hace el signo y el tamaño
  de a, lo que no cambia (vértice, eje, dominio, rango), Actividad 2 (describir la parábola
  sin graficar), Actividad 3 (evaluar) y Actividad 4 (encontrar a a partir de un punto),
  cada ejercicio con "Ver respuesta".
- El bloque "f(x) = ax²" de `tema-05-funciones-cuadraticas.html` ahora enlaza a esta página.
- Carmen aprobó la propuesta: se publicó en el sitio y se le entregó también en Word
  (con las respuestas en la última hoja).

## 2026-10-02 (Tema 5: x² y ax² reescritos con la Clase 8 de Carmen)
- Carmen compartió "Clase 8. Funciones cuadráticas" (PDF) y pidió reescribir con esa
  información las páginas del sitio. El PDF se guardó en
  `matematicas-3/materiales/clase-08-funciones-cuadraticas.pdf` y se enlaza desde las dos
  páginas y desde "Materiales" del Tema 5.
- `tema-05-x-cuadrada.html`: se quitó "Para empezar" (terreno cuadrado) y se agregaron,
  con el texto de Carmen, la definición general f(x) = ax² + bx + c (a, b, c reales, a ≠ 0),
  los "Elementos principales" (gráfica, mínimo/máximo, vértice, eje de simetría, cortes con
  los ejes) y "Pero empecemos de a poco…". Las actividades se quedaron igual.
- `tema-05-ax-cuadrada.html`: objetivo de Carmen (efecto de a, mínimo, máximo y raíces);
  "¿Qué hace el número a?" con su redacción (|a|, “gorda”); "Lo que NO cambia" sólo con
  vértice y eje de simetría; nueva sección "Raíces" (repetidas, reales y diferentes,
  imaginarias). En el recuadro final se agregó que f(x) = ax² tiene raíz repetida x = 0.
- La antigua Actividad 2 se reemplazó por los **Ejercicios de Carmen** ("Para cada función
  grafica": 3x², −½x², 2/10 x², −4x², 5/2 x², −x²), cada uno con "Ver respuesta" (gráfica,
  abertura, mínimo/máximo, vértice, eje y raíz). Las actividades de evaluar y de encontrar a
  pasan a ser Actividad 2 y Actividad 3.

## 2026-10-02 (escalas en las gráficas de los Ejercicios de ax²)
- A pedido de Carmen, las gráficas de las respuestas de los Ejercicios de
  `tema-05-ax-cuadrada.html` ahora tienen escala completa: todos los números en el eje x
  (−4 a 4) y en el eje y (−1 a 9, o −9 a 1), con los nombres de los ejes x, y; también son
  un poco más grandes.
- Se corrigió el texto de los puntos: decía "f(1) = 3 · f(2) = 12" (parecía una
  multiplicación); ahora dice "f(1) = 3; f(2) = 12".

## 2026-10-04 (video: f(x) = ax² variando a)
- A pedido de Carmen se hizo un video animado (51 s, sin audio) de cómo cambia la parábola
  f(x) = ax² cuando varía a: de 1 a 4 (más cerrada), a 0.2 (más abierta), se detiene en
  a = 0 (recta, "ya no es cuadrática, por eso a ≠ 0"), y luego valores negativos hasta −4
  (abre hacia abajo, máximo). Siempre muestra y = x² punteada como referencia, un
  deslizador con el valor de a, y al final un resumen.
- Archivos: `matematicas-3/materiales/tema-05-ax-cuadrada-variando-a.mp4` y su portada
  `tema-05-ax-cuadrada-variando-a-portada.jpg`.
- Se insertó en `tema-05-ax-cuadrada.html`, antes de "¿Qué hace el número a?".

## 2026-10-04 (video: f(x) = ax² + b)
- Se hizo un segundo video (60 s, sin audio), con el mismo estilo que el de ax².
  Primero se ve el efecto de **a** con b = 2 fijo (de 1 a 3, a 0.3, se detiene en a = 0
  con el aviso "ya no es cuadrática", luego hasta −3). Después, el efecto de **b** con
  a = 1 (sube a 4, baja a −4, regresa a 0). Siempre se marcan el vértice V(0, b) y las
  raíces (repetida, reales y diferentes o imaginarias). Termina con un resumen. El orden
  (primero a, luego b) lo eligió Carmen.
- Archivos: `matematicas-3/materiales/tema-05-ax-cuadrada-mas-b.mp4` y su portada
  `tema-05-ax-cuadrada-mas-b-portada.jpg`. Carmen todavía no tiene el material del subtema, así que
  se creó `matematicas-3/tema-05-ax-cuadrada-mas-b.html` sólo con el video y un aviso de
  "Próximamente", y el bloque "f(x) = ax² + b" de la página del Tema 5 ya enlaza a ella.

## 2026-10-08 (Serie 2 de binomios conjugados, en Word)
- A pedido de Carmen se hizo la **Serie 2 de binomios conjugados** en Word, con 18 ejercicios
  de menor a mayor dificultad: coeficientes enteros, dos variables, exponentes, signo negativo
  al inicio, fracciones (½, ⅓), decimales y exponentes literales (xᵐ, yⁿ). Incluye recuadro
  "Recuerda" con (a + b)(a − b) = a² − b², espacio para Nombre/Grupo/Fecha y una segunda
  hoja con las respuestas.
- Archivo: `matematicas-3/materiales/tema-06-serie-2-binomios-conjugados.docx` (todavía no
  está enlazado desde la página del Tema 6).

## 2026-10-10 (Serie 2 de binomios conjugados en la página del Tema 6)
- En `tema-06-productos-notables-y-factorizacion.html`, el bloque **Tarea** ahora tiene el
  enlace "Descargar Serie 2. Binomios conjugados (Word)". El archivo incluye la hoja de
  respuestas en la segunda página.

## 2026-10-10 (Serie 3 de binomios conjugados, en Word)
- Se hizo la **Serie 3 de binomios conjugados** en Word, con la misma estructura que la
  Serie 2 (encabezado, Nombre/Grupo/Fecha, recuadro "Recuerda", 18 ejercicios de menor a
  mayor dificultad y hoja de respuestas), pero con ejercicios nuevos.
- Archivo: `matematicas-3/materiales/tema-06-serie-3-binomios-conjugados.docx` (todavía no
  está enlazado desde la página del Tema 6).

## 2026-10-10 (subtema Función constante + Serie 1 en Word)
- Nueva página `matematicas-3/tema-04-constante.html`, enlazada desde el bloque "Constante"
  de `tema-04-funciones.html`. Sigue el plan de clase que se platicó con Carmen: objetivo,
  ejemplo del estacionamiento ($30 sin importar las horas), definición f(x) = c, aviso de que
  "no aparece la x", Actividad 1 (tabla de f(x) = 3), gráfica de f(x) = 3 y de f(x) = 3, 0,
  −2 juntas, comparación con la prueba de la recta vertical (y = 3 sí es función, x = 3 no),
  cuadro de características (dominio, rango {c}, cortes con los ejes) y Actividades 2 a 5
  (evaluar, ¿es constante?, encontrar la función por un punto y una situación de la vida
  real), todas con "Ver respuesta".
- **Serie 1 · Función constante** en Word (18 ejercicios: Parte A evaluar, Parte B dominio,
  rango, eje y y raíces, Parte C función que pasa por un punto) con hoja de respuestas:
  `matematicas-3/materiales/tema-04-serie-1-funcion-constante.docx`. Está enlazada al final
  de la página del subtema.

## 2026-10-10 (video: cómo se mueven los puntos de x² con el parámetro a)
- A pedido de Carmen se hizo un tercer video (61 s, sin audio). Primero se grafica
  f(x) = x² en **azul** con sus puntos principales V(0, 0), (±1, 1) y (±2, 4). Después x²
  queda punteada como referencia y se ve cómo cada punto (x, y) se mueve a (x, a·y), con
  flechas y una tabla x | x² | ax² que se actualiza. Se detiene en a = 2 (delgada), ½
  (gorda), 0 (ya no es cuadrática), −1 (abre hacia abajo), −2 y −½, y regresa a 1. Termina
  con un resumen (signo de a, |a| mayor o menor que 1, el vértice no se mueve).
- Archivos: `matematicas-3/materiales/tema-05-ax-cuadrada-puntos.mp4` y su portada
  `tema-05-ax-cuadrada-puntos-portada.jpg`. Se insertó en `tema-05-ax-cuadrada.html`, justo
  debajo del video "variando el número a".

## 2026-10-10 (gráfica interactiva: elige el valor de a)
- A pedido de Carmen, en `tema-05-ax-cuadrada.html` (debajo de los videos) se agregó la
  sección **"Pruébalo tú · Elige el valor de a"**. Se escribe a como **fracción común**
  (1/2, −3/4), entero o decimal (0.25 se convierte en ¼) y se oprime "Graficar"; también hay
  botones rápidos (2, ½, ¼, 3/2, −1, −⅓, −5/2, 0).
- La parábola x² queda azul punteada de referencia y los puntos (±1, 1), (±2, 4) se mueven
  con una animación a (x, a·y). Las coordenadas, la ecuación f(x) = ax², el mensaje
  (abre arriba/abajo, más delgada/gorda, a = 0 ya no es cuadrática) y la tabla
  x | x² | ax² se muestran con fracciones comunes. Avisa si se escribe algo inválido o un
  denominador 0; se limita a −10 ≤ a ≤ 10.

## 2026-10-10 (gráfica interactiva: puntos (±3, 9))
- A pedido de Carmen, la gráfica interactiva de `tema-05-ax-cuadrada.html` ahora también
  muestra los puntos (±3, 9) de x² y su movimiento a (±3, 9a); la tabla tiene esas filas.
- Las etiquetas de los puntos ahora buscan solas un lugar libre (a un lado, arriba o abajo)
  para no encimarse cuando los puntos quedan muy juntos (por ejemplo a = 1/3 o a = 0).

## 2026-10-10 (video de los puntos de x²: explicación y puntos (±3, 9))
- A pedido de Carmen se rehízo `matematicas-3/materiales/tema-05-ax-cuadrada-puntos.mp4`
  (ahora 78 s) y su portada:
  - Ahora también muestra los puntos (±3, 9) en la gráfica y en la tabla.
  - Nueva escena **"¿Qué observamos en la tabla?"** antes del resumen: la x no cambia, sólo
    cambia la y; la nueva y es a · 0, a · 1, a · 4, a · 9 (abre hacia arriba, ej. a = 2:
    0, 2, 8, 18) y, si a < 0, los valores son negativos: |a| · 0, |a| · (−1), |a| · (−4),
    |a| · (−9) (ej. a = −2: 0, −2, −8, −18). Se escribió con |a| para que no se confunda
    con multiplicar un número negativo por −1, −4, −9.
- Se actualizó la descripción del video en `tema-05-ax-cuadrada.html`.

## 2026-10-10 (la tabla muestra la multiplicación a · x²)
- A pedido de Carmen, para justificar de dónde salen los valores de y: en la tabla de la
  gráfica interactiva de `tema-05-ax-cuadrada.html` la columna ahora dice "y = a · x²" y
  muestra la multiplicación completa con fracciones, por ejemplo (−¾) · 9 = −27/4.
- Lo mismo en el video `tema-05-ax-cuadrada-puntos.mp4`: la tabla del panel ahora tiene la
  columna "a · x² = ax²" y cada renglón muestra la multiplicación, por ejemplo 2 · 9 = 18 o
  (−1) · 4 = −4. Se actualizó la portada.

## 2026-10-10 (página aparte con sólo la gráfica interactiva de ax²)
- Carmen quiere compartir por correo la gráfica interactiva sin compartir todavía la página
  del tema. Se creó `matematicas-3/prueba-ax-cuadrada.html`: sólo título, instrucciones y la
  gráfica interactiva (copia de la de `tema-05-ax-cuadrada.html`). No tiene menú ni enlaces
  al resto del sitio, ninguna página la enlaza y tiene `noindex` para que no aparezca en
  buscadores. Enlace para compartir:
  https://mcpz-math.github.io/matematicas-3/prueba-ax-cuadrada.html
- Ojo: si se cambia la gráfica interactiva, hay que cambiarla en los dos archivos.

## 2026-10-10 (video: cómo se resuelve un binomio conjugado)
- A pedido de Carmen se hizo un video (1 min 41 s, sin audio, estilo "Compás"): qué es un
  binomio conjugado (mismos términos, sólo cambia el signo; primer término en azul y segundo
  en naranja); de dónde sale la regla, multiplicando (x + 5)(x − 5) término por término y
  cancelando −5x + 5x; la regla (a + b)(a − b) = a² − b², "el cuadrado del primero menos el
  cuadrado del segundo"; Ejemplo 1 (3x + 4)(3x − 4) = 9x² − 16 en 4 pasos; Ejemplo 2
  (2m² − 7n)(2m² + 7n) = 4m⁴ − 49n² (no importa el orden de los signos); "¡Cuidado!"
  ((3x)² = 9x², no 3x²; el resultado siempre es una resta); "Ahora tú" (5y + 2)(5y − 2), con
  cuenta regresiva para pausar y luego la respuesta 25y² − 4; y un resumen en 4 pasos.
- Archivos: `matematicas-3/materiales/tema-06-binomios-conjugados.mp4` y su portada
  `tema-06-binomios-conjugados-portada.jpg`.
- En `tema-06-productos-notables-y-factorizacion.html` el bloque "Binomios conjugados y DCP"
  ya no dice "Próximamente": tiene una frase y un enlace "Ver video ↓" a la nueva sección
  **"Video: binomios conjugados"** (debajo de los subtemas), donde está el video.
- Enlace directo para compartir por correo:
  https://mcpz-math.github.io/matematicas-3/materiales/tema-06-binomios-conjugados.mp4

## 2026-10-10 (video de binomios conjugados sin "¿De dónde sale la regla?")
- A pedido de Carmen se quitó del video `tema-06-binomios-conjugados.mp4` la escena
  "¿De dónde sale la regla?" (la multiplicación término por término de (x + 5)(x − 5)).
  Ahora dura 1 min 23 s. Se quitó la frase "Ya no hace falta multiplicar término por
  término" y en "¡Cuidado!" la nota final ahora dice "El resultado sólo tiene dos términos:
  el cuadrado del primero y el cuadrado del segundo". Se actualizó la descripción del video
  en la página del Tema 6.

## 2026-10-10 (video de binomios conjugados: observación "elevar al cuadrado")
- A pedido de Carmen, en la escena "La regla" del video `tema-06-binomios-conjugados.mp4`
  se agregó un recuadro: **"Observación: elevar al cuadrado significa multiplicar por el
  mismo"**, con a² = a · a, b² = b · b y el ejemplo (3x)² = 3x · 3x = 9x². Ahora dura
  1 min 28 s. Se actualizó la portada.

## 2026-10-10 (canal de YouTube — en proceso)
- Carmen quiere un canal de YouTube para sus videos. Decidió **no borrar** su canal viejo
  (Google pedía un código de verificación con la tablet) y creó un **canal nuevo** con la
  misma cuenta: "Profesora Carmen Pèrez" (@ProfesoraCarmenPèrez).
- Se diseñaron la foto de perfil y el banner con el estilo "Compás", guardados en
  `materiales-youtube/foto-perfil.png` (800×800) y `materiales-youtube/banner.png`
  (2560×1440).
- **Pendiente para la próxima sesión:**
  1. Corregir el nombre a "Profesora Carmen **Pérez**" (é, no è) y el identificador a
     @ProfesoraCarmenPerez (sin acento), en studio.youtube.com → Personalización → Perfil →
     "Publicar". Carmen intentó y "siguió igual"; revisar con una captura de esa pantalla.
  2. Subir la foto de perfil y el banner.
  3. Escribir la descripción del canal.
  4. Subir los videos como "No listado" con título y descripción.

## 2026-10-11 (video: raíces reales o imaginarias de f(x) = ax² + b)
- A pedido de Carmen se hizo un video (2 min 30 s, estilo "Compás") que enseña a
  decidir con la gráfica si f(x) = ax² + b tiene raíces **reales y diferentes** o
  **imaginarias**. Escenas: qué es una raíz (donde la parábola corta al eje x); las dos
  preguntas clave (¿hacia dónde abre? → signo de a; ¿dónde está el vértice V(0, b)? →
  signo de b); cuatro ejemplos paso a paso con comprobación algebraica (x² − 9 → ±3;
  x² + 4 → ±2i; −2x² + 8 → ±2; −3x² − 3 → ±i); caso especial b = 0 (2x², raíz doble
  x = 0); y un resumen con la regla rápida: signos contrarios → reales y diferentes,
  mismo signo → imaginarias.
- Archivos: `matematicas-3/materiales/tema-05-raices-ax-cuadrada-mas-b.mp4` y su portada
  `tema-05-raices-ax-cuadrada-mas-b-portada.jpg`. Se puso en
  `matematicas-3/tema-05-ax-cuadrada-mas-b.html`, debajo del video "variando a y b".
- Cambios pedidos por Carmen: (1) se le puso **música de fondo** como a los otros videos
  (Preludio en Do mayor, BWV 846, de Bach, piano suave a volumen bajo, sin voz); (2) los
  ejemplos con raíces **reales y diferentes** ahora se resuelven como **diferencia de
  cuadrados**: x² − 9 = x² − 3² = (x + 3)(x − 3) = 0 → x = −3, x = 3; y −2x² + 8 = 0 →
  ÷(−2): x² − 4 = (x + 2)(x − 2) = 0 → x = −2, x = 2. En el resumen, la regla dice
  "signos contrarios → reales y diferentes (diferencia de cuadrados)".

## 2026-10-11 (se quita el video "variando a y b")
- A pedido de Carmen se quitó de `matematicas-3/tema-05-ax-cuadrada-mas-b.html` el video
  "Video: variando a y b". En la página sólo queda el video de raíces reales o imaginarias.
  El archivo `materiales/tema-05-ax-cuadrada-mas-b.mp4` se conserva en el repositorio (por
  si alguien tiene la liga directa), pero ya no se muestra en ninguna página.

## 2026-10-11 (aplicación "Prueba tú: f(x) = ax² + b")
- A pedido de Carmen, en lugar del video "variando a y b" se puso en
  `matematicas-3/tema-05-ax-cuadrada-mas-b.html` una versión de la gráfica interactiva de ax²
  **con el parámetro b**. El alumno escribe a y b (enteros, decimales o fracciones) o usa los
  botones rápidos; la parábola se anima desde la anterior. Muestra x² punteada de referencia,
  los puntos de x = −3 a 3 con sus coordenadas, el vértice V(0, b) y las raíces como rombos
  sobre el eje x. Debajo explica hacia dónde abre, si es más delgada o más abierta, dónde está
  el vértice y qué tipo de raíces tiene: reales y diferentes (resueltas como **diferencia de
  cuadrados** cuando salen exactas; si no, x = ±√… aproximado), imaginarias o raíz repetida.
  También trae la tabla x | x² | a · x² + b.
- La aplicación de ax² (`tema-05-ax-cuadrada.html` y `prueba-ax-cuadrada.html`) no se cambió.
- Se creó la página aparte `matematicas-3/prueba-ax-cuadrada-mas-b.html` (sólo la gráfica
  interactiva de ax² + b, para compartir con los alumnos por liga directa):
  https://mcpz-math.github.io/matematicas-3/prueba-ax-cuadrada-mas-b.html
- En celulares angostos, los cuadros de a y b y el botón "Graficar" ahora se acomodan en
  dos renglones para que no se corten.

## 2026-10-11 (ejercicios de binomios conjugados con revisión automática)
- A pedido de Carmen se agregó en `matematicas-3/tema-06-productos-notables-y-factorizacion.html`
  la sección **"Ejercicios: binomios conjugados"** (debajo del video), con 16 ejercicios de
  menor a mayor dificultad: enteros, coeficientes, dos variables, exponentes, (6 − y)(6 + y),
  (−x + 8)(−x − 8), fracciones, decimales y x²y. El bloque "Binomios conjugados y DCP" tiene
  el enlace "Practicar ejercicios ↓".
- El alumno escribe su respuesta (con ^ o con los botones ², ³, ⁴, ⁶, −; fracciones con /) y
  oprime "Comprobar". La página acepta cualquier forma equivalente (por ejemplo −25 + x²,
  0.25 o 1/4) y le dice si es correcta. Si no lo es, le da una pista según el error: signo
  más en lugar de menos, orden invertido, dejar paréntesis sin desarrollar, tres términos,
  letras que no van, o no elevar al cuadrado el coeficiente; y un botón "Ver la respuesta"
  con (a)² − (b)². Abajo lleva la cuenta "Llevas X de 16 correctas".
- Estilos nuevos `.practice-*` en `assets/style.css`.

## 2026-10-11 (nombre de Carmen en todos los videos)
- A pedido de Carmen, los 9 videos de `matematicas-3/materiales/` (y sus portadas) ahora
  muestran durante todo el video una etiqueta verde oscuro abajo a la derecha con su nombre:
  **"DTI. Maria del Carmen Pérez Zarate"** (el nombre lo eligió ella). En los videos de
  Inecuaciones y Valor absoluto la etiqueta tapa el pie de página chiquito que ya tenían.
  La música y la duración de los videos no cambiaron.
- Para videos nuevos: agregar la misma etiqueta.
- En la pantalla de inicio del video de raíces (`tema-05-raices-ax-cuadrada-mas-b.mp4`) se
  cambió "Profesora Carmen Pérez" por "DTI. Maria del Carmen Pérez Zarate", a pedido de Carmen.

## 2026-10-11 (ejercicios de binomios conjugados: banco de 100 y "volver a intentar")
- A pedido de Carmen, los ejercicios de binomios conjugados del Tema 6 ahora salen de un
  **banco de 100 ejercicios** (de menor a mayor dificultad: x ± n, kx ± n, dos variables,
  exponentes, productos de letras, orden invertido como (6 − y)(6 + y), primer término
  negativo como (−m − 3)(−m + 3), fracciones y decimales). Cada vez se muestran **10 al azar**,
  ordenados de más fácil a más difícil, y el botón **"Otros 10 ejercicios (volver a
  intentar)"** reparte 10 nuevos.
- Cuando la respuesta es incorrecta, además de la pista ahora se muestra directamente
  **la respuesta correcta**, por ejemplo: (5x)² − (3)² = 25x² − 9.
- Se agregó el botón ⁸ (para respuestas como 16x⁸ − 36).
- Se probó que los 100 ejercicios aceptan su respuesta correcta.

## 2026-10-11 (subtema "Binomios conjugados y DCP" con página propia)
- A pedido de Carmen, todo lo de binomios conjugados se pasó de
  `tema-06-productos-notables-y-factorizacion.html` a su propia página
  `matematicas-3/tema-06-binomios-conjugados.html`: el video, los ejercicios con revisión
  automática (banco de 100) y la tarea (Serie 2, en Word).
- En la página del Tema 6, el bloque "Binomios conjugados y DCP" ahora tiene el enlace
  "Ver subtema →", y el bloque "Tarea" indica que la Serie 2 está en el subtema.
- A pedido de Carmen se quitó el bloque "Tarea" de la página del Tema 6 (la sección ahora se
  llama sólo "Materiales"). La Serie 2 sigue disponible en la página del subtema
  `tema-06-binomios-conjugados.html`.
- También se quitó, por el momento, la sección "Materiales" de la página del Tema 6. Ahora
  sólo muestra los subtemas.

## 2026-10-11 (DCP: ejercicios y descripción del subtema)
- En `matematicas-3/tema-06-binomios-conjugados.html` se agregó la sección **"Ejercicios:
  diferencia de cuadrados perfectos (DCP)"** (debajo de los de binomios conjugados), igual que
  la de binomios: banco de 100 ejercicios, 10 al azar ordenados de fácil a difícil, botón
  "Otros 10 ejercicios (volver a intentar)" y la respuesta correcta al fallar. Aquí el alumno
  **factoriza**: por ejemplo 9x² − 16 = (3x + 4)(3x − 4). Acepta los binomios en cualquier orden.
  Pistas: si vuelve a escribir la diferencia sin factorizar, si los dos binomios llevan el
  mismo signo, si usa letras que no van. La respuesta correcta se muestra como
  √9x² = 3x y √16 = 4 → (3x + 4)(3x − 4). Botones ( ) ² ³ ⁴ −.
- Al inicio de la página se agregó la sección **"¿Qué vamos a estudiar?"** con el texto que
  escribió Carmen: qué es un binomio conjugado, ejemplos, por qué su producto es una diferencia
  de cuadrados, la regla práctica y el proceso inverso (factorización).
- La parte que lee y compara las respuestas de los alumnos se pasó a un archivo compartido,
  `assets/practica-algebra.js`, que usan las dos secciones de ejercicios.
- Se probó que los 100 ejercicios de cada banco aceptan su respuesta correcta.
- A pedido de Carmen se quitó la sección "Tarea" (Serie 2) de la página de binomios conjugados.
  El archivo `materiales/tema-06-serie-2-binomios-conjugados.docx` sigue guardado, pero ya no
  está enlazado en ninguna página.

## 2026-10-18 (f(x) = ax² + b: a y b de −50 a 50)
- A pedido de Carmen, en la gráfica de `matematicas-3/tema-05-ax-cuadrada-mas-b.html` (y en la
  página aparte `prueba-ax-cuadrada-mas-b.html`) ahora **a** y **b** aceptan valores de **−50 a 50**
  (antes a sólo llegaba a ±10 y b a ±9).
- El eje y cambia de escala solo (cada cuadrito vale 1, 2, 5, 10 o 20 unidades) para que siempre
  se vean el vértice y los puntos en x = ±1. Debajo de la gráfica se indica cuánto vale cada cuadrito.
- Las instrucciones ahora dicen que los valores van entre −50 y 50.

## 2026-10-18 (f(x) = ax² + b: explicación más clara de cómo se mueve cada punto)
- A pedido de Carmen, en `matematicas-3/tema-05-ax-cuadrada-mas-b.html` (y en
  `prueba-ax-cuadrada-mas-b.html`) se cambió la frase "Cada punto (x, y) de x² se mueve a (x, a·y + b)"
  por una explicación en pasos: la **x no cambia** y sólo cambia la **y**: (1) se multiplica por a,
  (2) al resultado se le suma b.
- El ejemplo con el punto (2, 4) ahora muestra cada paso por separado con los valores de a y b que
  eligió el alumno (por ejemplo, con a = −1 y b = −2: 4 · (−1) = −4, luego −4 − 2 = −6 → (2, −6)).

## 2026-10-18 (Etiquetas con fórmulas ya no salen en MAYÚSCULAS)
- A pedido de Carmen: el estilo pone en mayúsculas las etiquetas pequeñas (títulos de sección,
  recuadros, campos), y eso convertía `f(x) = ax² + b` en `F(X) = AX² + B`.
- Se agregó la clase `no-caps` en `assets/style.css`. Las etiquetas que tienen fórmulas o letras
  matemáticas (a, b, x, f(x)) se muestran tal cual, con minúsculas.
- Se aplicó en Matemáticas 3: `tema-04-constante`, `tema-05-x-cuadrada`, `tema-05-ax-cuadrada`,
  `tema-05-ax-cuadrada-mas-b` y las páginas `prueba-ax-cuadrada` y `prueba-ax-cuadrada-mas-b`.
- Regla para páginas nuevas: si una etiqueta lleva letras matemáticas, agregarle `no-caps`.

## 2026-10-18 (f(x) = ax² + b: explicación del número b)
- A pedido de Carmen, en `matematicas-3/tema-05-ax-cuadrada-mas-b.html` se agregó, antes del video,
  la sección "¿Qué hace el número b?": si **b > 0** la gráfica **sube**, si **b < 0** la gráfica
  **baja**, y si b = 0 se queda igual. Ejemplos: x² + 3 (sube 3, V(0, 3)) y x² − 2 (baja 2, V(0, −2)).
- También se aclara que b no cambia la forma ni hacia dónde abre, y que el vértice es V(0, b).

## 2026-10-18 (f(x) = ax² + b: ejercicios con revisión automática)
- A pedido de Carmen, al final de `matematicas-3/tema-05-ax-cuadrada-mas-b.html` se agregó la
  sección "Ejercicios: analiza f(x) = ax² + b": un banco de **100 funciones** del que se toman
  **10 al azar** cada vez (botón "Otros 10 ejercicios").
- En cada función el alumno contesta: (1) si abre hacia arriba o hacia abajo, (2) si es gorda o
  flaca comparada con x², (3) el vértice V(0, ___) y (4) si las raíces son reales y diferentes,
  reales y repetidas o imaginarias. Al oprimir "Comprobar" se califica y, si algo está mal, se
  explica por qué. Abajo se muestra cuántas lleva bien de 10.
- El banco está balanceado: 50 abren hacia arriba y 50 hacia abajo; 50 flacas y 50 gordas
  (no hay a = ±1 para que siempre sea gorda o flaca); 40 con raíces reales y diferentes,
  40 imaginarias y 20 reales y repetidas (b = 0). b va de −9 a 9.
- Se agregaron estilos para los botones de opción (`.practice-ask`, `.practice-opts`) en `assets/style.css`.

## 2026-10-18 (Ejercicios ax² + b: opción "igual que x²")
- A pedido de Carmen, en los ejercicios de `tema-05-ax-cuadrada-mas-b.html` la pregunta 2 ahora
  tiene tres opciones: **gorda**, **flaca** o **igual que x²** (cuando |a| = 1).
- Se cambiaron 20 funciones del banco para que tengan a = 1 o a = −1. El banco sigue con 100:
  40 flacas, 40 gordas y 20 iguales que x²; 50 arriba y 50 abajo; 40 raíces reales y diferentes,
  40 imaginarias y 20 reales y repetidas.

## 2026-10-18 (ax² + b: se quita "Próximamente")
- A pedido de Carmen se quitó el recuadro "Próximamente" al final de
  `matematicas-3/tema-05-ax-cuadrada-mas-b.html`.

## 2026-10-18 (Ejercicios ax² + b: se ve claramente la opción elegida)
- A pedido de Carmen, en los botones de opción de los ejercicios (`.practice-opts` en
  `assets/style.css`) la opción elegida ahora se pinta de **verde-lima** con borde oscuro y una
  palomita ✓. Las opciones no elegidas tienen un círculo ○ y se ven más tenues después de elegir.

## 2026-10-18 (ax² + b: rúbrica por competencias)
- A pedido de Carmen, al final de `matematicas-3/tema-05-ax-cuadrada-mas-b.html` (donde antes estaba
  "Próximamente") se agregó una **rúbrica por competencias** desplegable ("Ver rúbrica por
  competencias"), con el mismo formato que la rúbrica del método gráfico del Tema 1.
- Niveles: Excelente, Satisfactorio, En proceso y Suficiente.
- Competencias: (1) hacia dónde abre (signo de a), (2) abertura comparada con x² (|a|),
  (3) vértice V(0, b) y desplazamiento vertical, (4) naturaleza de las raíces, (5) tabla de
  valores y gráfica, (6) argumenta y comunica el procedimiento.

## 2026-10-18 (f(x) = x²: se quita la Actividad 1 · Tabla de valores)
- A pedido de Carmen se quitó de `matematicas-3/tema-05-x-cuadrada.html` la "Actividad 1 · Tabla de
  valores" (tabla para completar y su botón "Ver respuestas").
- Las demás actividades se renumeraron: Evaluar la función (ahora 1), ¿El punto está en la
  parábola? (ahora 2) y De regreso: ¿qué x da ese resultado? (ahora 3).
- El texto de la gráfica decía "los puntos de la tabla"; ahora menciona los puntos directamente
  ((−3, 9), (−2, 4), …, (3, 9)).

## 2026-10-18 (Clase de repaso: leyes de los signos)
- A pedido de Carmen (los alumnos se confunden con los signos, tema de Matemáticas 1), se creó
  la página `matematicas-3/tema-05-repaso-signos.html` con una clase de repaso:
  1. Multiplicar y dividir (ley de los signos, contar signos menos: par/impar).
  2. Potencias de números negativos: (−3)² = 9 vs −3² = −9, (−2)³, −(−4)²; sustituir siempre
     entre paréntesis.
  3. Sumar y restar (mismo signo, signos diferentes, restar un negativo).
  4. Evaluar f(x) = ax² + b paso a paso (sustituir, potencia, multiplicar por a, sumar b) con
     dos ejemplos.
  5. Tabla de errores más comunes (error / correcto / por qué).
  6. Ejercicios con revisión automática: banco de 100 (25 de cada tipo), 10 al azar; si la
     respuesta sólo tiene el signo mal, se le avisa al alumno, y siempre se muestra el procedimiento.
- Se enlazó desde `tema-05-x-cuadrada.html`, justo debajo del recuadro "¡Cuidado con los signos!".

## 2026-10-18 (La clase de signos pasa a Matemáticas 1)
- A pedido de Carmen, la clase de repaso de los signos se movió a la sección de Matemáticas 1:
  ahora es `matematicas-1/leyes-de-los-signos.html` (antes `matematicas-3/tema-05-repaso-signos.html`).
- `matematicas-1/index.html` tiene una nueva sección "Clases" con la tarjeta "Las leyes de los
  signos". Los recuadros de Temario, Materiales y Tareas siguen en "Próximamente".
- La tarjeta de la página `matematicas-3/tema-05-x-cuadrada.html` sigue y ahora lleva a la nueva dirección.

## 2026-10-18 (Matemáticas 1 sin "Próximamente"; se quita tarjeta de signos en x²)
- A pedido de Carmen se quitó de `matematicas-3/tema-05-x-cuadrada.html` la tarjeta "¿Te confunden
  los signos?". La clase de signos queda sólo en Matemáticas 1.
- En la página de inicio (`index.html`) se quitó la etiqueta "Próximamente" de Matemáticas 1,
  porque ya tiene contenido. Se actualizó CLAUDE.md.

## 2026-10-18 (Leyes de los signos: se quita "¡Cuidado al sustituir!")
- A pedido de Carmen se quitó el recuadro "¡Cuidado al sustituir!" de la sección 2 (potencias)
  en `matematicas-1/leyes-de-los-signos.html`.

## 2026-10-18 (Leyes de los signos: se quita "Todo junto: evaluar f(x) = ax² + b")
- A pedido de Carmen se quitó la sección "4 · Todo junto: evaluar f(x) = ax² + b" (los 4 pasos y
  los dos ejemplos) de `matematicas-1/leyes-de-los-signos.html`. Las secciones siguientes se
  renumeraron: Errores más comunes (4) y Ejercicios (5).
- Se actualizó la descripción de la tarjeta en `matematicas-1/index.html`.

## 2026-10-18 (Leyes de los signos: sección 4 regresa como "Jerarquía de operaciones")
- A pedido de Carmen, en lugar de quitar la sección 4 se restauró con el título
  **"4 · Jerarquía de operaciones"** (mismo contenido: los 4 pasos y los dos ejemplos).
  Errores más comunes vuelve a ser la 5 y Ejercicios la 6.
- La tarjeta de `matematicas-1/index.html` menciona la jerarquía de operaciones.

## 2026-10-18 (Leyes de los signos: se quitan los ejemplos de la sección 4)
- A pedido de Carmen se quitaron los dos ejemplos (f(x) = −2x² + 3 y f(x) = −x² − 4) de la sección
  "4 · Jerarquía de operaciones" en `matematicas-1/leyes-de-los-signos.html`. Quedan los 4 pasos.

## 2026-10-18 (Leyes de los signos: sin botón "−" en los ejercicios)
- A pedido de Carmen se quitó el botón "−" que aparecía debajo de cada cuadro de respuesta en los
  ejercicios de `matematicas-1/leyes-de-los-signos.html`. El signo menos se escribe con el guion
  del teclado (la página acepta - y −). Se ajustaron las instrucciones.

## 2026-10-18 (Video: jerarquía de operaciones)
- A pedido de Carmen se hizo un video (3 min 7 s, estilo "Compás", con la música de fondo de los
  otros videos —Preludio en Do mayor de Bach— y la etiqueta "DTI. Maria del Carmen Pérez Zarate").
  Escenas: portada; el orden de las operaciones (paréntesis, potencias, multiplicaciones y
  divisiones, sumas y restas; "usa las leyes de los signos"); Ejemplo 1: 5 − 2(3 − 7)² = −27 en
  4 pasos, con "¡Cuidado!: no hagas primero 5 − 2"; Ejemplo 2: −3² + 12 ÷ (−4) · 2 − (−5) = −10
  en 6 pasos; y "Para recordar".
- Archivos: `matematicas-1/materiales/jerarquia-de-operaciones.mp4` y su portada
  `jerarquia-de-operaciones-portada.jpg`. Se puso en `matematicas-1/leyes-de-los-signos.html`,
  en la sección "4 · Jerarquía de operaciones", debajo de los 4 pasos.
- Enlace directo para compartir:
  https://mcpz-math.github.io/matematicas-1/materiales/jerarquia-de-operaciones.mp4
- A pedido de Carmen, el encabezado de la página ahora dice sólo "Matemáticas 1" (se quitó
  "Clase de repaso").

## 2026-10-18 (Jerarquía de operaciones: pasos generales e imágenes de los ejemplos)
- A pedido de Carmen, en la sección "4 · Jerarquía de operaciones" de
  `matematicas-1/leyes-de-los-signos.html` los 4 pasos ahora son el orden general: paréntesis,
  potencias, multiplicaciones y divisiones (de izquierda a derecha), sumas y restas (de izquierda
  a derecha), usando las leyes de los signos en cada paso.
- Debajo del video se agregaron dos imágenes con cada ejemplo completo, igual que se ve en el
  video: `materiales/jerarquia-de-operaciones-ejemplo-1.jpg` y `-ejemplo-2.jpg`. Al tocarlas se
  abren en grande.

## 2026-10-18 (Leyes de los signos: banco sin funciones y ejercicios de jerarquía)
- A pedido de Carmen, el banco de 100 ejercicios de signos (`matematicas-1/leyes-de-los-signos.html`,
  sección 6) ya **no tiene ejercicios de evaluar funciones** (f(x) = …; f(−3)), porque todavía no
  se ven en Matemáticas 1. Ahora tiene 34 de multiplicar y dividir, 30 de potencias y 36 de sumar
  y restar.
- Nueva sección **"7 · Ejercicios: jerarquía de operaciones"** con el mismo formato: banco de 100,
  10 al azar, "Comprobar", aviso cuando sólo el signo está mal y procedimiento paso a paso. Diez
  formas, de la más sencilla a la más larga (10 de cada una): a + b·c, a − b÷c, (a + b)·c,
  a·b − c·d, a − b(c − d), con potencias, (a − b)²÷c, a − b(c − d)², −k² + a÷b·c − (d) y
  a(b + c) − d÷e. Todas las respuestas son enteras y se verificaron con la computadora.
- Las dos secciones de ejercicios usan ahora la misma función en el código (`practice`).

## 2026-10-18 (Leyes de los signos: rúbrica por competencias)
- A pedido de Carmen, al final de `matematicas-1/leyes-de-los-signos.html` se agregó una
  **rúbrica por competencias** desplegable ("Ver rúbrica por competencias"), con el mismo formato
  que las otras rúbricas (Excelente, Satisfactorio, En proceso, Suficiente).
- Competencias: (1) ley de los signos al multiplicar y dividir, (2) potencias de números negativos,
  (3) suma y resta con signo, (4) jerarquía de operaciones, (5) identifica y corrige errores,
  (6) argumenta y comunica el procedimiento.

## 2026-10-18 (Jerarquía de operaciones: ejercicios Nivel 2)
- A pedido de Carmen, los ejercicios de jerarquía de operaciones de
  `matematicas-1/leyes-de-los-signos.html` ahora tienen dos niveles:
  - **"7 · … Nivel 1"**: el banco de 100 que ya existía.
  - **"8 · … Nivel 2"** (nuevo): banco de 100 ejercicios más largos, con **paréntesis dentro de
    paréntesis, corchetes [ ] y llaves { }**. Diez formas (10 de cada una), por ejemplo
    a − [b + c(d − e)], [(a + b)² − c] ÷ d, a − p[b − q(c − d)], {a − [b + (c − d)]} · p y
    a − {p · [c − (d + e)²] + f}.
- Mismo formato (10 al azar, "Comprobar", aviso de signo). Si la respuesta está mal, el
  procedimiento muestra **cómo va quedando toda la operación** después de cada paso, de adentro
  hacia afuera. Todas las respuestas son enteras y se verificaron con la computadora; se evitaron
  divisiones entre ±1 y grupos que valen 0.

## 2026-10-18 (Jerarquía de operaciones: potencias y raíces)
- A pedido de Carmen, en `matematicas-1/leyes-de-los-signos.html` el paso 2 de la jerarquía ahora
  dice **"Potencias y raíces"** (ejemplo: (−4)² = 16 y √25 = 5). También se actualizaron las
  instrucciones de los ejercicios y la rúbrica (competencia "Aplica la jerarquía de operaciones").
- Los ejercicios de jerarquía ahora incluyen **raíces cuadradas con resultado natural** (de √4 a √144):
  - **Nivel 1:** 30 de los 100 tienen raíz: a + b · √c, √c ÷ b − a, (a − √c) · b. Los otros 70 son
    de las 10 formas que ya había (7 de cada una).
  - **Nivel 2:** 30 de los 100 tienen raíz: a − [b + √c · (d − e)], {a − √(b + c)} · p (raíz de una
    operación) y [√c − (d − e)²] ÷ p. Los otros 70 son de las 10 formas anteriores (7 de cada una).
- El banco de signos (sección 6) no cambió. Todas las respuestas se verificaron con la computadora.
- Pendiente de decidir con Carmen: el video y las imágenes de los ejemplos todavía dicen "Potencias".
