// Voz en off para los generadores de video (generar-video-*.html).
//  - cargarVoz(video, ESC): lee voz/<video>.json y los .wav que crea generar-voz.ps1, y alarga cada
//    escena lo necesario para que cada frase termine antes de que empiece la siguiente (la escena
//    se estira de forma pareja, así lo que se ve sigue el ritmo de la voz). Las escenas marcadas
//    "fijo" no se estiran (por ejemplo, la que tiene cuenta regresiva): sólo se alargan al final.
//  - mezclar(...): junta la música (en bucle, con fundido de salida) y la voz; la música baja de
//    volumen mientras se habla.
const SR = 48000, HUECO = .35, COLA = .8;

export async function cargarVoz(video, ESC, base = '/materiales-fuente/voz/') {
  const r = await fetch(`${base}${video}.json`);
  if (!r.ok) return null;
  const guion = await r.json();
  const ac = new AudioContext({ sampleRate: SR });
  const frases = []; // { escena, s, datos }
  for (const e of guion.escenas) {
    for (let j = 0; j < e.voz.length; j++) {
      const nom = `e${String(e.n).padStart(2, '0')}-${j}.wav`;
      const buf = await ac.decodeAudioData(await (await fetch(`${base}${video}/${nom}`)).arrayBuffer());
      frases.push({ escena: e.n, s: e.voz[j].s, datos: buf.getChannelData(0), fijo: !!e.fijo });
    }
  }
  const aviso = [];
  const k = ESC.map(() => 1);
  ESC.forEach((esc, n) => {
    const fs = frases.filter(f => f.escena === n);
    if (!fs.length) return;
    const dur = f => f.datos.length / SR;
    let kk = 1;
    for (let i = 1; i < fs.length; i++) {
      const sep = fs[i].s - fs[i - 1].s;
      if (fs[i].fijo) { if (dur(fs[i - 1]) + HUECO > sep) aviso.push(`escena ${n}: la frase ${i - 1} se pisa con la ${i}`); }
      else kk = Math.max(kk, (dur(fs[i - 1]) + HUECO) / sep);
    }
    const u = fs[fs.length - 1];
    if (u.fijo) esc.dur = Math.max(esc.dur, u.s + dur(u) + COLA);
    else kk = Math.max(kk, (dur(u) + COLA) / (esc.dur - u.s));
    k[n] = Math.max(1, kk);
    if (k[n] > 1) {
      const dibujar = esc.draw, kn = k[n];
      esc.dur *= kn; esc.draw = tt => dibujar(tt / kn);
    }
  });
  let ini = 0; const inicios = ESC.map(e => { const a = ini; ini += e.dur; return a; });
  const pistas = frases.map(f => ({ inicio: inicios[f.escena] + f.s * k[f.escena], datos: f.datos }));
  console.log('voz: estiramiento por escena', k.map(x => x.toFixed(2)).join(' '), aviso);
  return { pistas, k, aviso };
}

// música: [L, R] de Float32Array; pistas: [{inicio, datos}]; DUR en segundos
export function mezclar(DUR, musica, pistas, { base = .55, bajo = .18 } = {}) {
  const N = Math.round(DUR * SR), X = 2 * SR; // 2 s de cruce al repetir la música
  const largo = musica[0].length, periodo = largo - X;
  const m = (c, i) => {
    const c1 = Math.floor(i / periodo), g = [];
    let v = 0;
    for (const cc of [c1 - 1, c1]) {
      if (cc < 0) continue;
      const p = i - cc * periodo;
      if (p < 0 || p >= largo) continue;
      v += musica[c][p] * (cc > 0 ? Math.min(1, p / X) : 1) * Math.min(1, (largo - p) / X);
    }
    return v;
  };
  // voz (mono) y máscara de "se está hablando"
  const voz = new Float32Array(N), habla = new Float32Array(N);
  for (const p of pistas) {
    const a = Math.round(p.inicio * SR);
    let pico = 0; for (let i = 0; i < p.datos.length; i++) pico = Math.max(pico, Math.abs(p.datos[i]));
    const g = pico > 0 ? .9 / pico : 1;
    for (let i = 0; i < p.datos.length && a + i < N; i++) voz[a + i] += p.datos[i] * g;
    habla.fill(1, Math.max(0, a - Math.round(.3 * SR)), Math.min(N, a + p.datos.length + Math.round(.5 * SR)));
  }
  const alfa = 1 - Math.exp(-1 / (.25 * SR));
  const pcm = [new Float32Array(N), new Float32Array(N)];
  let env = 0;
  for (let i = 0; i < N; i++) {
    env += (habla[i] - env) * alfa;
    const s = i / SR, fin = s > DUR - 3 ? Math.max(0, (DUR - s) / 3) : 1;
    const gm = (pistas.length ? base + (bajo - base) * env : 1) * fin;
    for (let c = 0; c < 2; c++) pcm[c][i] = Math.max(-1, Math.min(1, m(c, i) * gm + voz[i] * fin));
  }
  return pcm;
}
