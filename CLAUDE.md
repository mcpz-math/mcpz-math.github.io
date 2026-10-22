# Sitio web — Carmen Pérez (mcpz-math)

## Sobre el proyecto
Sitio web para alumnos de bachillerato, materia de matemáticas.
Publicado gratis con GitHub Pages en: https://mcpz-math.github.io

- Usuario de GitHub: `mcpz-math`
- Repositorio: `mcpz-math/mcpz-math.github.io`
- Carpeta local: Escritorio → `mcpz-math.github.io`

## Preferencias de Carmen para trabajar juntos
- Prefiere avanzar **paso a paso, una cosa a la vez**, con instrucciones claras y sin
  saltarse pasos.
- Comunicación en español.
- No tiene experiencia técnica previa con GitHub/git — explicar en lenguaje sencillo,
  sin dar por hecho conocimientos técnicos.
- Quiere que los cambios y materiales que vayamos creando se sincronicen sobre la
  marcha al repositorio de GitHub.
- Llevar un registro de avance en [BITACORA.md](BITACORA.md) — actualizarlo cada vez
  que se agregue o cambie algo importante.

## Estilo visual
"Compás": verde bosque (#14301f) + crema (#f6f3ea) + acento verde-lima (#c4e86b),
formas geométricas (círculo, triángulo) como decoración. Tipografías: Outfit (títulos)
y Karla (texto). Estilos compartidos en `assets/style.css`.

## Estructura del sitio
- `index.html` — página de inicio con tarjetas a cada materia.
- Una carpeta por materia, cada una con su propio `index.html`:
  `matematicas-1/`, `matematicas-2/`, `matematicas-3/`, `matematicas-4/`,
  `matematicas-5/`, `probabilidad-estadistica/` (optativa).
- Dentro de cada carpeta de materia se irán agregando páginas de temas conforme
  se trabajen con Carmen (por ejemplo `matematicas-3/tema-01-....html`) y una
  subcarpeta `materiales/` para PDFs o imágenes cuando se necesite.
- Cuando el contenido de un subtema es extenso, se le da su propia página
  (`tema-XX-nombre-subtema.html`, ej. `tema-01-grafico.html`) enlazada desde el
  bloque de ese subtema en la página del tema, en vez de meter todo el contenido
  ahí mismo.
- Todos los cursos muestran la etiqueta "Próximamente" excepto los que ya tienen
  contenido activo (actualmente Matemáticas 1, Matemáticas 2 y Matemáticas 3).

## Geometría plana
- Todas las construcciones se hacen **con regla y compás, sin medir**: la regla sólo sirve para
  trazar rectas. No se dan medidas de los lados (no hace falta conocerlas). Por ejemplo, el punto
  medio se encuentra con la mediatriz y las perpendiculares con arcos de compás (no con escuadra).

## Rúbricas
- **Toda rúbrica nueva o editada se hace con la matriz de niveles de evaluación de Carmen**
  (`matrizNivelesEvaluación2.xlsx`), nunca con la escala vieja de Excelente / Satisfactorio /
  En proceso / Suficiente. Pedido explícito de Carmen (2026-10-21).
- El contenido de la matriz está guardado en
  [materiales-fuente/matriz-niveles-evaluacion.json](materiales-fuente/matriz-niveles-evaluacion.json):
  competencias (Comunicación, Representación geométrica / algebraica / aritmética,
  Modelación y resolución de problemas, Argumentación) con los textos de los Niveles 1 a 5
  y la nota del Nivel 0. Usar esos textos tal cual; no inventar descriptores.
- **Cada rúbrica debe decir, para esa actividad en concreto, qué debe ver Carmen en cada
  nivel** (no basta copiar el texto general de la matriz). Lo concreto por actividad está en
  [materiales-fuente/rubricas-por-actividad.json](materiales-fuente/rubricas-por-actividad.json)
  (qué observar, niveles 1 a 5 y errores típicos). Para una actividad nueva, agregar ahí su
  entrada y correr `materiales-fuente/generar-rubricas.ps1`: actualiza las rúbricas del sitio y
  genera la guía en Word `Escritorio\IEMS\Guia_para_evaluar_con_la_matriz.docx` (opción `-Guia`).
- Formato: copiar la estructura de una rúbrica ya hecha (por ejemplo la de
  `matematicas-3/tema-05-ax-cuadrada-mas-b.html`): `<details class="rubric rubric-matriz">`
  con tabla `table.matriz`, columnas Criterio y Niveles 1 a 5, celdas combinadas donde la
  matriz las combina (Niveles 2 y 3; en Modelación también Niveles 4 y 5), un recuadro "En esta
  actividad" en cada criterio (lo que se evalúa en esa tarea) y la nota del Nivel 0 debajo.
- Elegir las competencias que correspondan a la actividad (Comunicación y Argumentación casi
  siempre; Representación según el tema; Modelación cuando se resuelven problemas).

## Flujo de trabajo para agregar temas
1. Elegir la materia y el tema a trabajar.
2. Carmen comparte el contenido (texto en el chat, PDF, Word o imagen).
3. Se arma la página del tema dentro de la carpeta de esa materia, siguiendo el
   estilo "Compás".
4. Se sincroniza automáticamente con GitHub (commit + push).
5. Se anota el avance en [BITACORA.md](BITACORA.md).
