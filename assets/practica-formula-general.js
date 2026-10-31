// Utilidades de la fórmula general (páginas de x² + bx + c y de ax² + bx + c):
//  - evaluador de lo que escribe el alumno (acepta √, i, fracciones con /, multiplicación sin signo: 2√3, 3i);
//  - descomposición de un número en k²·m, signo menos, fracción apilada.
(function () {
  var MINUS = '−';
  function C(re, im) { return { re: re, im: im || 0 }; }
  function cmul(a, b) { return C(a.re * b.re - a.im * b.im, a.re * b.im + a.im * b.re); }
  function cdiv(a, b) { var d = b.re * b.re + b.im * b.im; if (!d) throw new Error('÷0'); return C((a.re * b.re + a.im * b.im) / d, (a.im * b.re - a.re * b.im) / d); }
  function close(a, b) { return Math.abs(a.re - b.re) < 1e-9 && Math.abs(a.im - b.im) < 1e-9; }
  function parseExpr(str) {
    var s = str.replace(/\s+/g, '').replace(/[−–—]/g, '-').replace(/[·×]/g, '*').replace(/÷/g, '/').replace(/sqrt|raiz|raíz/gi, '√').replace(/,/g, '.').replace(/I/g, 'i'), pos = 0;
    function fail() { throw new Error('no entendido'); }
    function peek() { return s.charAt(pos); }
    function num() { var m = /^(\d+(\.\d+)?|\.\d+)/.exec(s.slice(pos)); if (!m) fail(); pos += m[0].length; return C(parseFloat(m[0])); }
    function paren() { pos++; var v = expr(); if (peek() !== ')') fail(); pos++; return v; }
    function root(z) { if (z.im) fail(); return z.re >= 0 ? C(Math.sqrt(z.re)) : C(0, Math.sqrt(-z.re)); }
    function atom() {
      var ch = peek();
      if (ch === '(') return paren();
      if (ch === 'i') { pos++; return C(0, 1); }
      if (ch === '√') { pos++; return root(peek() === '(' ? paren() : num()); }
      return num();
    }
    function unary() {
      var ch = peek();
      if (ch === '-') { pos++; var v = unary(); return C(-v.re, -v.im); }
      if (ch === '+') { pos++; return unary(); }
      return atom();
    }
    function term() {
      var v = unary();
      for (;;) {
        var ch = peek();
        if (ch === '*') { pos++; v = cmul(v, unary()); }
        else if (ch === '/') { pos++; v = cdiv(v, unary()); }
        else if (ch && /[(i√\d.]/.test(ch)) v = cmul(v, atom()); // multiplicación sin signo: 2√3, 3i, √3i
        else return v;
      }
    }
    function expr() {
      var v = term();
      for (;;) {
        var ch = peek();
        if (ch === '+') { pos++; var t = term(); v = C(v.re + t.re, v.im + t.im); }
        else if (ch === '-') { pos++; var u = term(); v = C(v.re - u.re, v.im - u.im); }
        else return v;
      }
    }
    var r = expr(); if (pos !== s.length) fail(); return r;
  }
  function isSq(n) { var r = Math.round(Math.sqrt(n)); return r * r === n; }
  function simp(n) { var k = 1, m = n; for (var d = 2; d * d <= m; d++) { while (m % (d * d) === 0) { m /= d * d; k *= d; } } return [k, m]; } // n = k²·m
  function sg(n) { return String(n).replace('-', MINUS); }
  function frac(n, d) { return '<span class="frac frac-inline"><span class="num">' + n + '</span><span class="den">' + d + '</span></span>'; }
  window.FGLIB = { C: C, close: close, parseExpr: parseExpr, isSq: isSq, simp: simp, frac: frac, sg: sg };
})();
