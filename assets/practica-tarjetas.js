// Motor común de tarjetas de ejercicios con revisión automática (10 al azar de un banco).
// Uso:  Practica.setup({ id: 'pc', bank: [...], anchor: 'id-del-titulo', card: function (e, n) { return { head, body, check, sol }; } })
//   head  : HTML de la pregunta (lo que va junto al número)
//   body  : HTML con las preguntas (casillas <input data-f="...">, grupos .practice-opts, botones .practice-keys)
//   check : function (ctx) → { msg, bad } (aviso antes de calificar) o { wrong: [...], msgs: [...], total: n }
//           ctx.inp[f] = casilla, ctx.chosen[q] = opción elegida, ctx.multi[q] = lista de opciones marcadas, ctx.card = la tarjeta
//   sol   : HTML de la solución (se muestra al acertar y al fallar)
// Ayudas: Practica.h.gcd, lcm, primeFactors, isPrime, primeText, sup, parseList, parseNat…
(function () {
  var SUPD = { '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴', '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹' };
  var h = {
    gcd: function (a, b) { while (b) { var t = b; b = a % b; a = t; } return a; },
    lcm: function (a, b) { return a / h.gcd(a, b) * b; },
    sup: function (n) { return String(n).split('').map(function (c) { return SUPD[c]; }).join(''); },
    isPrime: function (n) { if (n < 2) return false; for (var d = 2; d * d <= n; d++) if (n % d === 0) return false; return true; },
    primeFactors: function (n) { var f = {}, d = 2; while (n > 1 && d * d <= n) { while (n % d === 0) { f[d] = (f[d] || 0) + 1; n /= d; } d++; } if (n > 1) f[n] = (f[n] || 0) + 1; return f; },
    sortedPrimes: function (f) { return Object.keys(f).map(Number).sort(function (x, y) { return x - y; }); },
    powText: function (p, k) { return p + (k > 1 ? h.sup(k) : ''); },
    primeText: function (n) { if (n === 1) return '1'; var f = h.primeFactors(n); return h.sortedPrimes(f).map(function (p) { return h.powText(p, f[p]); }).join(' · '); },
    divisors: function (n) { var a = [], b = []; for (var d = 1; d * d <= n; d++) if (n % d === 0) { a.push(d); if (d !== n / d) b.unshift(n / d); } return a.concat(b); },
    parseNat: function (s) { s = String(s).replace(/\s+/g, ''); return /^\d+$/.test(s) ? parseInt(s, 10) : null; },
    parseList: function (s) { // "1, 2, 3" o "1 2 3" → [1, 2, 3] (o null si hay algo que no es número)
      var parts = String(s).replace(/[;,]/g, ' ').trim().split(/\s+/), out = [];
      for (var i = 0; i < parts.length; i++) { if (!/^\d+$/.test(parts[i])) return null; out.push(parseInt(parts[i], 10)); }
      return out;
    },
    sameSet: function (a, b) { var x = a.slice().sort(function (p, q) { return p - q; }), y = b.slice().sort(function (p, q) { return p - q; }); return x.length === y.length && x.every(function (v, i) { return v === y[i]; }); },
    thin: function (n) { return String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ' '); },   // 12 345 con espacio fino
    // Tabla de descomposición simultánea (los números en fila, una barra y los primos a la derecha). En los dos casos se divide
    // entre el primo más pequeño que divida a alguno, hasta que todos sean 1:
    //   mode 'mcm': mcm = producto de todos los primos de la derecha
    //   mode 'mcd': MCD = producto de los primos que dividieron a TODOS los números a la vez (se marcan en azul)
    dsimHTML: function (nums, mode) {
      var cur = nums.slice(), rows = [cur.slice()], primes = [], common = [];
      while (!cur.every(function (x) { return x === 1; })) {
        var q = null, c;   // en el MCD primero van los primos que dividen a todos (azules) y después los demás
        if (mode === 'mcd') { for (c = 2; c <= Math.max.apply(null, cur); c++) if (h.isPrime(c) && cur.every(function (x) { return x % c === 0; })) { q = c; break; } }
        if (q == null) { q = 2; while (!(h.isPrime(q) && cur.some(function (x) { return x % q === 0; }))) q++; }
        var all = cur.every(function (x) { return x % q === 0; });
        cur = cur.map(function (x) { return x % q === 0 ? x / q : x; });
        primes.push(q); common.push(all); rows.push(cur.slice());
      }
      var isMcd = mode === 'mcd', label = isMcd ? 'MCD' : 'mcm';
      var used = isMcd ? primes.filter(function (p, i) { return common[i]; }) : primes, prod = used.reduce(function (a, b) { return a * b; }, 1);
      var txt = label + ' = ' + (used.length === 0 ? '<b>1</b> (no hay primo común)' : (used.length > 1 ? used.join(' · ') + ' = ' : '') + '<b>' + prod + '</b>');
      var html = '<div class="dsim-wrap"><table class="dsim" aria-label="Tabla de descomposición simultánea para el ' + label + '">';
      rows.forEach(function (r, i) {
        var p = primes[i], pc = p == null ? '' : (isMcd ? (common[i] ? 'com' : 'no') : '');
        html += '<tr>' + r.map(function (x) { return '<td' + (x === 1 ? ' class="one"' : '') + '>' + x + '</td>'; }).join('') +
                '<td class="pr ' + pc + '">' + (p == null ? '' : '<span class="pill">' + p + '</span>') + '</td>' + (i === 0 ? '<td class="res" rowspan="' + rows.length + '">' + txt + '</td>' : '') + '</tr>';
      });
      return html + '</table><div class="dsim-cap">' + txt + '</div>' + (isMcd ? '<div class="dsim-leg"><span class="pill-leg">azul</span> primos que dividen a todos los números a la vez: con ellos se obtiene el MCD</div>' : '') + '</div>';
    },
    inputHTML: function (f, label, style, extra) {
      return '<input type="text" data-f="' + f + '" ' + (extra || '') + 'autocomplete="off" autocapitalize="off" spellcheck="false" style="' + (style || '') + '" aria-label="' + label + '">';
    },
    keysHTML: function (list, targets) { return '<div class="practice-keys" data-t="' + targets + '">' + list.map(function (k) { return '<button type="button" data-k="' + k + '">' + k + '</button>'; }).join('') + '</div>'; },
    optsHTML: function (q, list, multi) { // list = [[valor, texto], …]
      return '<div class="practice-opts" data-q="' + q + '"' + (multi ? ' data-multi="1"' : '') + '>' + list.map(function (o) { return '<button type="button" data-v="' + o[0] + '">' + o[1] + '</button>'; }).join('') + '</div>';
    }
  };

  function setup(cfg) {
    var N = cfg.n || 10, BANK = cfg.bank, done = {};
    var grid = document.getElementById(cfg.id + '-grid'), scoreEl = document.getElementById(cfg.id + '-score');
    function score() {
      var n = Object.keys(done).length;
      scoreEl.innerHTML = 'Llevas <strong>' + n + ' de ' + N + '</strong> correctas' + (n === N ? ' — ¡excelente trabajo! 🎉' : '');
    }
    function pick() { // 10 al azar, ordenados como en el banco (de menor a mayor dificultad)
      var idx = BANK.map(function (e, i) { return i; });
      for (var i = idx.length - 1; i > 0; i--) { var j = Math.floor(Math.random() * (i + 1)), t = idx[i]; idx[i] = idx[j]; idx[j] = t; }
      return idx.slice(0, N).sort(function (p, q) { return p - q; }).map(function (i) { return BANK[i]; });
    }
    function makeCard(e, idx) {
      var n = idx + 1, spec = cfg.card(e, n), card = document.createElement('div');
      card.className = 'practice-card';
      card.innerHTML = '<div class="practice-head"><span class="enum">' + n + '</span><span class="practice-q">' + spec.head + '</span></div>' + spec.body +
        '<div class="practice-row" style="margin-top:0.7rem;"><button type="button" class="practice-check">Comprobar</button></div>' +
        '<div class="practice-fb" aria-live="polite"></div>';
      grid.appendChild(card);
      var fb = card.querySelector('.practice-fb'), ctx = { inp: {}, chosen: {}, multi: {}, card: card }, lastIn = null;
      card.querySelectorAll('input').forEach(function (i) { ctx.inp[i.dataset.f] = i; i.addEventListener('focus', function () { lastIn = i.dataset.f; }); i.addEventListener('keydown', function (ev) { if (ev.key === 'Enter') check(); }); });
      card.querySelectorAll('.practice-keys button').forEach(function (b) {
        b.addEventListener('click', function () {
          var ts = b.parentNode.dataset.t.split(','), t = ts.indexOf(lastIn) >= 0 ? lastIn : ts[0], input = ctx.inp[t];
          var s = input.selectionStart == null ? input.value.length : input.selectionStart, e2 = input.selectionEnd == null ? s : input.selectionEnd;
          input.value = input.value.slice(0, s) + b.dataset.k + input.value.slice(e2);
          input.focus(); input.setSelectionRange(s + b.dataset.k.length, s + b.dataset.k.length);
        });
      });
      card.querySelectorAll('.practice-opts').forEach(function (g) {
        var multi = g.dataset.multi === '1';
        g.querySelectorAll('button').forEach(function (b) {
          b.addEventListener('click', function () {
            if (multi) {
              b.classList.toggle('on');
              ctx.multi[g.dataset.q] = [].slice.call(g.querySelectorAll('button.on')).map(function (x) { return x.dataset.v; });
            } else {
              g.querySelectorAll('button').forEach(function (o) { o.classList.remove('on'); });
              b.classList.add('on'); ctx.chosen[g.dataset.q] = b.dataset.v;
            }
          });
        });
      });
      function check() {
        card.classList.remove('ok', 'bad');
        var res = spec.check(ctx);
        if (res.msg) { if (res.bad) card.classList.add('bad'); fb.innerHTML = res.msg; return; }
        if (!res.wrong.length) {
          card.classList.add('ok'); done[idx] = 1; score();
          fb.innerHTML = '<span class="yes">✓ ¡Todo correcto!</span><div class="sol" style="font-family:inherit;">' + spec.sol + '</div>';
          return;
        }
        card.classList.add('bad'); delete done[idx]; score();
        fb.innerHTML = '<span class="no">✗ Tienes ' + (res.total - res.wrong.length) + ' de ' + res.total + ' bien.</span> ' +
          (res.msgs || []).map(function (m) { return '<div class="sol" style="font-family:inherit;">' + m + '</div>'; }).join('') +
          '<div class="sol" style="font-family:inherit;">La respuesta correcta es:<br>' + spec.sol + '</div>';
      }
      card.querySelector('.practice-check').addEventListener('click', check);
    }
    function newSet() { grid.innerHTML = ''; done = {}; pick().forEach(makeCard); score(); }
    document.getElementById(cfg.id + '-new').addEventListener('click', function () {
      newSet();
      document.getElementById(cfg.anchor).scrollIntoView({ behavior: 'smooth' });
    });
    newSet();
  }

  window.Practica = { setup: setup, h: h };
})();
