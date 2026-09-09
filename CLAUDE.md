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
  se trabajen con Carmen (por ejemplo `matematicas-3/tema-1-....html`) y una
  subcarpeta `materiales/` para PDFs o imágenes cuando se necesite.
- Todos los cursos muestran la etiqueta "Próximamente" excepto el que ya tiene
  contenido activo (actualmente Matemáticas 3).

## Flujo de trabajo para agregar temas
1. Elegir la materia y el tema a trabajar.
2. Carmen comparte el contenido (texto en el chat, PDF, Word o imagen).
3. Se arma la página del tema dentro de la carpeta de esa materia, siguiendo el
   estilo "Compás".
4. Se sincroniza automáticamente con GitHub (commit + push).
5. Se anota el avance en [BITACORA.md](BITACORA.md).
