/* Lectura y comparación de expresiones algebraicas para los ejercicios con revisión automática.
   Uso: Algebra.parse('x^2 - 25') → { P: polinomio, terms: términos escritos,
        binos: binomios entre paréntesis multiplicados, others: otros factores } */
(function () {
  // ---------- fracciones ----------
  function gcd(a, b) { a = Math.abs(a); b = Math.abs(b); while (b) { var t = b; b = a % b; a = t; } return a || 1; }
  function fr(n, d) { if (d < 0) { n = -n; d = -d; } var g = gcd(n, d); return [n / g, d / g]; }
  function fadd(p, q) { return fr(p[0] * q[1] + q[0] * p[1], p[1] * q[1]); }
  function fmul(p, q) { return fr(p[0] * q[0], p[1] * q[1]); }

  // ---------- polinomios: { "x2y1": [n, d], "": [n, d] } ----------
  function key(m) { return Object.keys(m).filter(function (v) { return m[v]; }).sort().map(function (v) { return v + m[v]; }).join(''); }
  function unkey(k) { var m = {}, re = /([a-z])(\d+)/g, r; while ((r = re.exec(k))) m[r[1]] = +r[2]; return m; }
  function clean(P) { var o = {}; for (var k in P) if (P[k][0] !== 0) o[k] = P[k]; return o; }
  function padd(P, Q, s) {
    var o = {}, k;
    for (k in P) o[k] = P[k];
    for (k in Q) { var c = s < 0 ? [-Q[k][0], Q[k][1]] : Q[k]; o[k] = o[k] ? fadd(o[k], c) : c; }
    return clean(o);
  }
  function pmul(P, Q) {
    var o = {};
    for (var a in P) for (var b in Q) {
      var m = unkey(a), n = unkey(b);
      for (var v in n) m[v] = (m[v] || 0) + n[v];
      var k = key(m), c = fmul(P[a], Q[b]);
      o[k] = o[k] ? fadd(o[k], c) : c;
    }
    return clean(o);
  }
  function pconst(c) { return c[0] === 0 ? {} : { '': c }; }
  function same(P, Q) { return Object.keys(padd(P, Q, -1)).length === 0; }
  function vars(P) { var o = {}; Object.keys(P).forEach(function (k) { (k.match(/[a-z]/g) || []).forEach(function (c) { o[c] = 1; }); }); return Object.keys(o).sort(); }

  // ---------- lectura de lo que escribe el alumno ----------
  var SUP = { '⁰': '0', '¹': '1', '²': '2', '³': '3', '⁴': '4', '⁵': '5', '⁶': '6', '⁷': '7', '⁸': '8', '⁹': '9' };
  function tokens(s) {
    s = s.replace(/[−–—]/g, '-').replace(/[·×∙]/g, '*').replace(/,/g, '.').replace(/\s+/g, '').toLowerCase();
    s = s.replace(/[⁰¹²³⁴⁵⁶⁷⁸⁹]+/g, function (m) { return '^' + m.split('').map(function (c) { return SUP[c]; }).join(''); });
    var t = [], re = /(\d+\.?\d*|\.\d+)|([a-z])|([+\-*/^()])/g, r, pos = 0;
    while ((r = re.exec(s))) {
      if (r.index !== pos) throw 0;
      pos = re.lastIndex;
      if (r[1]) { var dec = (r[1].split('.')[1] || ''), p = Math.pow(10, dec.length); t.push({ n: fr(Math.round(parseFloat(r[1]) * p), p) }); }
      else if (r[2]) t.push({ v: r[2] });
      else t.push({ o: r[3] });
    }
    if (pos !== s.length || !t.length) throw 0;
    return t;
  }
  function parse(s) {
    var t = tokens(s), i = 0;
    function peek(o) { return t[i] && t[i].o === o; }
    function expr(info) {
      var sign = 1, terms = 0;
      if (peek('+')) i++; else if (peek('-')) { i++; sign = -1; }
      var P = term(info); if (sign < 0) P = padd({}, P, -1); terms++;
      while (peek('+') || peek('-')) { var s2 = t[i++].o === '-' ? -1 : 1; P = padd(P, term(info), s2); terms++; }
      if (info) info.terms = terms;
      return P;
    }
    // info (sólo en el nivel de afuera) cuenta qué factores se multiplicaron
    function term(info) {
      function f() { var r = factor(); if (info) { if (r.bino) info.binos++; else info.others++; } return r.P; }
      var P = f();
      while (i < t.length) {
        if (peek('*')) { i++; P = pmul(P, f()); }
        else if (peek('/')) {
          i++; var Q = factor().P, ks = Object.keys(Q);
          if (ks.length !== 1 || ks[0] !== '') throw 0;
          P = pmul(P, pconst(fr(Q[''][1], Q[''][0])));
          if (info) info.others++;
        }
        else if (t[i].n || t[i].v || peek('(')) P = pmul(P, f());
        else break;
      }
      return P;
    }
    function factor() {
      var tk = t[i++], P, bino = false;
      if (!tk) throw 0;
      if (tk.n) P = pconst(tk.n);
      else if (tk.v) { var m = {}; m[tk.v] = 1; P = {}; P[key(m)] = [1, 1]; }
      else if (tk.o === '(') { var sub = {}; P = expr(sub); if (!peek(')')) throw 0; i++; bino = sub.terms === 2; }
      else if (tk.o === '-') return { P: padd({}, factor().P, -1), bino: false };
      else throw 0;
      if (peek('^')) {
        i++; var e = t[i++];
        if (!e || !e.n || e.n[1] !== 1 || e.n[0] > 20) throw 0;
        var R = { '': [1, 1] };
        for (var k = 0; k < e.n[0]; k++) R = pmul(R, P);
        P = R; bino = false;
      }
      return { P: P, bino: bino };
    }
    var info = { terms: 0, binos: 0, others: 0 }, P = expr(info);
    if (i !== t.length) throw 0;
    if (info.terms > 1) { info.binos = 0; info.others = 0; }
    return { P: P, terms: info.terms, binos: info.binos, others: info.others };
  }

  window.Algebra = { parse: parse, padd: padd, pmul: pmul, same: same, vars: vars };
})();
