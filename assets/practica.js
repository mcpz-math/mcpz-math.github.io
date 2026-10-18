// Ejercicios con revisión automática: 10 al azar de un banco de 100.
// Cada ejercicio del banco: [operación, resultado (entero), procedimiento, tipo].
(function () {
  function parseInt2(txt) { // acepta "-8", "−8", "+8", "8"
    var s = txt.replace(/[−–]/g, '-').replace(/\s+/g, '');
    return /^[+-]?\d+$/.test(s) ? parseInt(s, 10) : null;
  }

  // ---------- tarjetas ----------
  function practice(BANK, prefix, anchorId) {
    var N = 10;
    var grid = document.getElementById(prefix + '-grid'), scoreEl = document.getElementById(prefix + '-score'), done = {};
    function score() {
      var n = Object.keys(done).length;
      scoreEl.innerHTML = 'Llevas <strong>' + n + ' de ' + N + '</strong> correctas' + (n === N ? ' — ¡excelente trabajo! 🎉' : '');
    }
    function pick() { // 10 al azar, en el orden del banco
      var idx = BANK.map(function (e, i) { return i; });
      for (var i = idx.length - 1; i > 0; i--) { var j = Math.floor(Math.random() * (i + 1)), t = idx[i]; idx[i] = idx[j]; idx[j] = t; }
      return idx.slice(0, N).sort(function (p, q) { return p - q; });
    }
    function makeCard(bi, idx) {
      var ex = BANK[bi], ans = ex[1];
      var card = document.createElement('div');
      card.className = 'practice-card';
      card.innerHTML =
        '<div class="practice-head"><span class="enum">' + (idx + 1) + '</span><span class="practice-q">' + ex[0] + '</span></div>' +
        '<div class="practice-ask" style="margin-top:0;">' + ex[3] + '</div>' +
        '<div class="practice-row"><span class="eq">=</span><input type="text" inputmode="text" autocomplete="off" autocapitalize="off" spellcheck="false" aria-label="Tu respuesta del ejercicio ' + (idx + 1) + '">' +
        '<button type="button" class="practice-check">Comprobar</button></div>' +
        '<div class="practice-fb" aria-live="polite"></div>';
      grid.appendChild(card);
      var input = card.querySelector('input'), fb = card.querySelector('.practice-fb');
      function check() {
        var v = input.value.trim(), r;
        card.classList.remove('ok', 'bad');
        if (!v) { fb.innerHTML = 'Escribe tu respuesta en el cuadro.'; return; }
        r = parseInt2(v);
        if (r === null) {
          card.classList.add('bad');
          fb.innerHTML = '<span class="no">No entendí lo que escribiste.</span> Escribe sólo un número entero, por ejemplo <strong>−12</strong> o <strong>7</strong>.';
          return;
        }
        if (r === ans) {
          card.classList.add('ok'); done[idx] = 1; score();
          fb.innerHTML = '<span class="yes">✓ ¡Correcto!</span><div class="sol" style="font-family:inherit;">' + ex[2] + '</div>';
          return;
        }
        card.classList.add('bad'); delete done[idx]; score();
        var hint = (r === -ans && ans !== 0) ? 'El número está bien, pero <strong>revisa el signo</strong>.' : 'Revisa el procedimiento:';
        fb.innerHTML = '<span class="no">✗ No es correcta.</span> ' + hint + '<div class="sol" style="font-family:inherit;">' + ex[2] + '</div>';
      }
      card.querySelector('.practice-check').addEventListener('click', check);
      input.addEventListener('keydown', function (e) { if (e.key === 'Enter') check(); });
    }
    function newSet() {
      grid.innerHTML = ''; done = {};
      pick().forEach(makeCard);
      score();
    }
    document.getElementById(prefix + '-new').addEventListener('click', function () {
      newSet();
      document.getElementById(anchorId).scrollIntoView({ behavior: 'smooth' });
    });
    newSet();
  }
  window.practice = practice;
})();
