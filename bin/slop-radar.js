'use strict';

// Slop Radar: offline, deterministic scan for candidate AI-slop patterns.
// It only flags candidates. The no-ai-slop skill still decides whether a
// pattern actually harms the draft ("diagnose patterns, not keywords").

const SEVERITY_WEIGHT = { tinggi: 12, sedang: 7, rendah: 3 };

const PATTERNS = {
  'canned-opening': {
    label: 'Canned opening',
    repair: 'Mulai langsung dari klaim konkret, adegan, tension, atau aksi.',
  },
  'empty-abstraction': {
    label: 'Empty abstraction',
    repair: 'Sebut siapa melakukan apa, pakai apa, dan kenapa itu penting.',
  },
  'over-signposting': {
    label: 'Over-signposting',
    repair: 'Buang label pengantarnya, langsung ke poinnya.',
  },
  'inflated-claim': {
    label: 'Inflated claim',
    repair: 'Ganti dengan hasil yang memang didukung bukti, dengan kepastian yang pas.',
  },
  'fake-contrast': {
    label: 'Fake contrast',
    repair: 'Nyatakan perbedaan yang sebenarnya, atau hapus frame "bukan cuma X, tapi Y".',
  },
  'generic-cta': {
    label: 'Generic CTA',
    repair: 'Ajukan satu pertanyaan yang bisa dijawab dan nyambung ke tension draft.',
  },
  'excessive-em-dash': {
    label: 'Excessive em dash',
    repair: 'Simpan em dash buat penekanan langka; sisanya ganti koma, titik dua, atau kurung.',
  },
  'repetitive-cadence': {
    label: 'Repetitive cadence',
    repair: 'Variasikan pembuka kalimat kalau ritmenya mekanis; pertahankan repetisi yang disengaja.',
  },
};

const RULES = [
  // Canned openings
  ['canned-opening', 'tinggi', /\bdi (era|zaman|jaman) (digital|modern|globalisasi|serba[- ]\w+|teknologi|sekarang|now)\b/gi],
  ['canned-opening', 'tinggi', /\bsemakin berkembang (pesat|cepat)\b/gi],
  ['canned-opening', 'tinggi', /\bin today'?s (fast[- ]paced|digital|ever[- ]changing|modern|competitive) (world|landscape|era|age)\b/gi],
  ['canned-opening', 'tinggi', /\bin the (ever[- ]evolving|ever[- ]changing|fast[- ]paced) (world|landscape) of\b/gi],
  ['canned-opening', 'sedang', /\bdalam (postingan|artikel|tulisan|video|thread|konten) ini,? (saya|kami|aku|gue|gw|kita) (akan|mau)\b/gi],
  ['canned-opening', 'sedang', /\bin this (post|article|blog post|video|thread),? (i|we)('ll| will| am going to)\b/gi],
  ['canned-opening', 'sedang', /\b(halo|hai) (semuanya|teman-teman|sobat)\b/gi],

  // Empty abstraction
  ['empty-abstraction', 'sedang', /\bmerupakan salah satu\b/gi],
  ['empty-abstraction', 'sedang', /\b(memainkan|mempunyai|memiliki) peran (yang )?(penting|krusial|vital)\b/gi],
  ['empty-abstraction', 'sedang', /\bplays? a (crucial|pivotal|vital|key) role\b/gi],
  ['empty-abstraction', 'rendah', /\b(rich|vibrant|intricate) tapestry\b/gi],
  ['empty-abstraction', 'rendah', /\bdelve(s|d)? into\b/gi],
  ['empty-abstraction', 'rendah', /\b(navigate|navigating) the (complexities|landscape)\b/gi],

  // Over-signposting
  ['over-signposting', 'sedang', /\b(penting untuk dicatat|perlu dicatat bahwa|perlu diingat bahwa|perlu digarisbawahi|tidak dapat dipungkiri|tak dapat dipungkiri|tidak bisa dipungkiri)\b/gi],
  ['over-signposting', 'rendah', /\b(pada akhirnya|singkatnya|kesimpulannya),/gi],
  ['over-signposting', 'sedang', /\b(it'?s (important|worth) (to note|noting)|needless to say|at the end of the day|in conclusion)\b/gi],

  // Inflated claims
  ['inflated-claim', 'tinggi', /\bgame[- ]?chang(er|ing)\b/gi],
  ['inflated-claim', 'tinggi', /\b(revolusioner|revolutionary|revolutionize|merevolusi)\b/gi],
  ['inflated-claim', 'tinggi', /\b(masa depan (sudah|telah) (di sini|tiba|datang)|the future is (here|now))\b/gi],
  ['inflated-claim', 'sedang', /\b(unlock|unleash|harness) (the power|your (full )?potential|the potential)\b/gi],
  ['inflated-claim', 'sedang', /\b(level up|next level|to the next level)\b/gi],
  ['inflated-claim', 'sedang', /\b(seamless(ly)?|cutting[- ]edge|state[- ]of[- ]the[- ]art|groundbreaking)\b/gi],
  ['inflated-claim', 'rendah', /\b(sangat|amat|benar-benar) (penting|krusial|vital|esensial)\b/gi],

  // Fake contrast
  ['fake-contrast', 'sedang', /\bbukan (hanya|cuma|sekadar|sekedar)\b[^.!?\n]{1,80}?\b(tapi|tetapi|melainkan|namun juga)\b/gi],
  ['fake-contrast', 'sedang', /\bnot (just|only|merely)\b[^.!?\n]{1,80}?\bbut( also)?\b/gi],

  // Generic CTA
  ['generic-cta', 'sedang', /\bbagaimana (menurut|pendapat) (kalian|anda|kamu|lo|lu|teman-teman)\b[^.!\n]*\??/gi],
  ['generic-cta', 'sedang', /\b(what do you think|what are your thoughts|let me know in the comments)\b\??/gi],
  ['generic-cta', 'sedang', /\b(are you ready to|siapkah (anda|kamu|kalian))\b/gi],
  ['generic-cta', 'rendah', /\bjangan lupa (like|share|follow|subscribe|komen)\b/gi],
];

// Replace fenced code, inline code, and URLs with spaces so offsets stay
// aligned with the source while those regions are never flagged.
function maskNonProse(text) {
  const blank = (m) => m.replace(/[^\n]/g, ' ');
  return text
    .replace(/^(```|~~~)[^\n]*\n[\s\S]*?^\1[^\n]*$/gm, blank)
    .replace(/`[^`\n]+`/g, blank)
    .replace(/\bhttps?:\/\/\S+/g, blank);
}

function lineIndex(text) {
  const starts = [0];
  for (let i = 0; i < text.length; i++) if (text[i] === '\n') starts.push(i + 1);
  return (offset) => {
    let lo = 0;
    let hi = starts.length - 1;
    while (lo < hi) {
      const mid = (lo + hi + 1) >> 1;
      if (starts[mid] <= offset) lo = mid;
      else hi = mid - 1;
    }
    return { line: lo + 1, column: offset - starts[lo] + 1 };
  };
}

function finding(pattern, severity, match, pos) {
  return {
    pattern,
    label: PATTERNS[pattern].label,
    severity,
    match: match.trim().replace(/\s+/g, ' ').slice(0, 80),
    line: pos.line,
    column: pos.column,
    repair: PATTERNS[pattern].repair,
  };
}

function scan(text) {
  const prose = maskNonProse(text);
  const locate = lineIndex(text);
  const findings = [];

  for (const [pattern, severity, regex] of RULES) {
    regex.lastIndex = 0;
    let m;
    while ((m = regex.exec(prose)) !== null) {
      findings.push(finding(pattern, severity, m[0], locate(m.index)));
    }
  }

  const words = (prose.match(/[\p{L}\p{N}'-]+/gu) || []).length;

  // Em dashes doing routine punctuation work: flag density, not each dash.
  const dashes = [...prose.matchAll(/—/g)];
  if (dashes.length >= 3 && dashes.length / Math.max(words, 1) > 1 / 120) {
    findings.push(
      finding('excessive-em-dash', 'rendah', `${dashes.length} em dash dalam ${words} kata`, locate(dashes[0].index))
    );
  }

  // Three or more consecutive sentences opening with the same word.
  const sentences = [...prose.matchAll(/[^.!?\n]+[.!?]?/g)]
    .map((m) => ({ index: m.index + (m[0].length - m[0].trimStart().length), text: m[0].trim() }))
    .filter((s) => s.text.split(/\s+/).length >= 3);
  let run = 1;
  for (let i = 1; i <= sentences.length; i++) {
    const first = (s) => (s ? s.text.split(/\s+/)[0].toLowerCase().replace(/[^\p{L}\p{N}]/gu, '') : null);
    if (i < sentences.length && first(sentences[i]) && first(sentences[i]) === first(sentences[i - 1])) {
      run++;
      continue;
    }
    if (run >= 3) {
      const start = sentences[i - run];
      findings.push(
        finding('repetitive-cadence', 'rendah', `${run} kalimat berturut-turut dibuka '${start.text.split(/\s+/)[0]}'`, locate(start.index))
      );
    }
    run = 1;
  }

  findings.sort((a, b) => a.line - b.line || a.column - b.column);

  const penalty = findings.reduce((sum, f) => sum + SEVERITY_WEIGHT[f.severity], 0);
  // Long drafts get a little more room before the score bottoms out.
  const allowance = Math.max(1, words / 250);
  const score = Math.max(0, Math.round(100 - penalty / allowance));
  const verdict = score >= 85 ? 'bersih' : score >= 60 ? 'perlu dipoles' : 'banyak pola template';

  return { words, score, verdict, findings };
}

module.exports = { scan, PATTERNS, RULES };
