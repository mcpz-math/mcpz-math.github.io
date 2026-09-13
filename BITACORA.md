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
