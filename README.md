<div align="center">

<p><img src="assets/konten-studio-presents.png" height="18" alt="Konten Studio presents"></p>

```text
      ██╗███████╗██╗  ██╗ █████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗
      ██║██╔════╝██║ ██╔╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║  ██║
      ██║█████╗  █████╔╝ ███████║██████╔╝██║  ██║███████║███████║
 ██   ██║██╔══╝  ██╔═██╗ ██╔══██║██╔══██╗██║  ██║██╔══██║██╔══██║
 ╚█████╔╝███████╗██║  ██╗██║  ██║██║  ██║██████╔╝██║  ██║██║  ██║
  ╚════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                         W  R  I  T  E  R
```

### Konten lo gak jelek. Cuma kedengeran kayak semua orang. 🔥

**Drop the draft. Keluarin tulisan yang punya hook, punya suara, dan tetap fact-locked.**

[![npm version](https://img.shields.io/npm/v/jekardah-writer.svg)](https://www.npmjs.com/package/jekardah-writer)
[![npm downloads](https://img.shields.io/npm/dm/jekardah-writer.svg)](https://www.npmjs.com/package/jekardah-writer)

</div>

---

## Masalah: ide lo punya isi, tulisannya masih berasa bot

Lo udah punya ide, data, bahkan CTA. Tapi final draft-nya masih dibuka pakai
kalimat aman, diisi jargon generik, lalu ditutup pertanyaan yang bisa di-copy
ke topik apa pun.

Technically benar. Tapi secara rasa, gak ada yang nempel. Orang baca dua baris,
ngerasa pernah lihat tulisan yang sama, terus lanjut scroll.

## Solusi: not another “humanizer”, tapi meja redaksi mini buat agent lo

Jekardah Writer bukan tombol sulap “bikin viral”. Ini skill pack yang bikin
agent lo kerja kayak editor: lock faktanya dulu, susun cerita kalau memang ada
perubahan yang layak diceritakan, cari tension yang emang ada, bersihin pola AI,
baru adjust voice Jabodetabek secukupnya.

| Skill | Kerjaan |
|---|---|
| `review-rewrite-content` | Pemimpin redaksi: pilih mode, lock fakta, atur handoff, jalankan QA |
| `storytelling-content` | Susun tulang cerita, tension, pacing, dan payoff tanpa ngarang kejadian |
| `hook-gokil` | Cari hook yang bikin berhenti scroll tanpa ngarang payoff |
| `headline-variants` | Generate dan skor opsi judul/subject line, terpisah dari hook body |
| `no-ai-slop` | Buang pembukaan kaleng, hiperbola, dan ritme yang terlalu mesin |
| `tutur-jabodetabek-urban` | Kasih register lokal tanpa cosplay slang atau stereotip wilayah |
| `platform-format` | Rapikan draft final biar pas sama konvensi IG/X/LinkedIn/TikTok/newsletter |
| `content-audit` | Audit skor draft (hook, struktur, voice, slop, risiko fakta, CTA) — read-only, gak ngedit |

## Before → After

**Before**

> Di era digital yang semakin berkembang pesat, personal branding merupakan
> salah satu hal yang sangat penting bagi para profesional. Dalam postingan ini,
> saya akan membagikan tiga tips yang dapat membantu Anda.

**After**

> CV lo bilang “strategic thinker”. Feed LinkedIn lo isinya ucapan selamat pagi.
> Ada mismatch kecil yang recruiter bisa lihat dalam 20 detik. Ini tiga cara
> benerinnya tanpa berubah jadi content creator full-time.

Yang di-adjust: hook, spesifisitas, rhythm, dan voice. Yang tetap locked: fakta,
nama, angka, atribusi, maksud CTA, link, plus batas kepastian sumber.

## Cocok Buat Siapa? Buat yang ogah kedengeran kayak template

- Founder dan operator yang nulis sendiri, tapi ogah kedengeran kayak memo direksi.
- Content writer dan social media team yang butuh second-pass sebelum publish.
- Creator LinkedIn, X, Instagram, newsletter, atau script video pendek.
- Agency yang perlu voice lokal yang konsisten tanpa buka keran halusinasi.
- Siapa pun yang pernah bilang, “Tolong manusia-in draft ini, tapi jangan ubah isinya.”

## Cara Kerja: lima skill masuk, satu suara keluar

```text
 DRAFT
   │
   ▼
 [FACT + STORY LOCK] ── fakta · urutan · dialog · klaim · CTA
   │
   ├──▶ STORYTELLING ─────▶ spine + tension + pacing
   ├──▶ HOOK GOKIL ──────▶ angle + payoff
   ├──▶ NO AI SLOP ────▶ konkret + ritmis + bersih
   ├──▶ TUTUR URBAN ───▶ register Jabodetabek
   ├──▶ HEADLINE VARIANTS ──▶ opsi judul + accuracy check
   └──▶ PLATFORM FORMAT ──▶ segmentasi + layout channel
   │
   ▼
 [FINAL QA] ── facts · format · payoff · tone · headline · platform
   │
   ▼
 KONTEN YANG KEDENGERAN KAYAK LO

 [FACT LOCK] ──▶ CONTENT AUDIT ──▶ skor read-only, gak masuk pipeline mutasi
```

## Slop Radar: cek draft dalam 1 detik, tanpa agent

Baru di v0.2.0. Sebelum nyerahin draft ke agent, scan dulu di terminal:

```bash
npx jekardah-writer check draft.md
pbpaste | npx jekardah-writer check -
```

```text
Slop Radar: draft.md (52 kata)

  3:1     [tinggi] Canned opening: "Di era digital"
          -> Mulai langsung dari klaim konkret, adegan, tension, atau aksi.
  3:65    [sedang] Empty abstraction: "merupakan salah satu"
          -> Sebut siapa melakukan apa, pakai apa, dan kenapa itu penting.
  13:1    [sedang] Generic CTA: "Bagaimana menurut kalian?"
          -> Ajukan satu pertanyaan yang bisa dijawab dan nyambung ke tension draft.

Skor: 30/100 (banyak pola template)
```

- Jalan offline, gak ngirim draft ke mana pun, dan gak ngedit apa pun.
- Code block, inline code, dan URL di-skip.
- `--json` buat tooling, `--min-score 80` buat gate di CI atau pre-commit (exit 1 kalau di bawah skor).

Ini sinyal heuristik, bukan vonis: skill `no-ai-slop` tetap yang mutusin apakah
sebuah pola beneran ngerusak draft lo, dan rewrite-nya tetap fact-locked.

## Mode: gak semua draft perlu dibongkar total

| Mode | Dipakai saat | Yang boleh berubah |
|---|---|---|
| `auto` | Lo mau agent pilih scope paling kecil yang cukup | Hanya layer yang benar-benar diminta |
| `review-only` | Lo butuh diagnosis tanpa menyentuh draft | Tidak ada |
| `audit` | Lo mau skor terstruktur (bukan cuma diagnosis prosa) | Tidak ada |
| `story-structure-only` | Bahannya ada, alur ceritanya masih datar atau acak | Struktur naratif saja |
| `hook-only` | Body udah kuat, pembukanya belum narik | Hook saja |
| `headline-only` | Body udah oke, judul/subject line-nya lemah | Headline saja |
| `anti-slop-only` | Isinya benar, tapi bahasanya generik | Prosa, bukan angle atau fakta |
| `voice-only` | Struktur aman, voice-nya belum dapet | Diksi, pronoun, dan rhythm |
| `platform-format-only` | Draft udah final, tinggal disesuaikan ke satu channel | Segmentasi, panjang, layout |
| `compare` | Butuh 2-4 varian draft buat dibandingin (hook/voice/platform) | Satu dimensi per varian, fakta tetap sama |
| `end-to-end` | Draft atau pengalaman perlu masuk meja operasi penuh | Semua layer relevan dalam pagar fact + story lock |

Prompt paling simpel:

```text
Pakai review-rewrite-content. Mode: auto.
Review dan rewrite draft di bawah ini. Pertahankan semua fakta, link, dan CTA.
Target voice: neutral Jabodetabek profesional.

[tempel draft]
```

## Kompatibilitas

Matrix ini ngebedain native integration, lokasi skill yang didokumentasikan vendor,
dan compatibility adapter yang masih perlu dites di berbagai versi agent.

| Agent | Jalur | Status rilis awal |
|---|---|---|
| Claude Code | Plugin native + `.claude/skills` | **Native / fixture-tested** |
| Codex CLI | Plugin native + `.codex/skills` | **Native / fixture-tested** |
| Cursor | `.cursor/skills` | **Compatible / fixture-tested** |
| OpenCode | `.opencode/skills` atau user config | **Compatible / fixture-tested** |
| GitHub Copilot | `.github/skills` / `.copilot/skills` | **Documented / fixture-tested** |
| Gemini CLI | `.gemini/skills` | **Documented / fixture-tested** |
| Agent lain | `AGENTS.md` + canonical `skills/` | **Experimental** |

“Fixture-tested” berarti installer udah dites di temporary home/project. Itu
bukan claim kalau setiap versi aplikasi vendor udah dites end-to-end.

## Instalasi

Ada empat jalur install, pilih yang paling cocok sama setup lo.

### 0. `npx skills` (registry komunitas, support paling banyak agent)

Pakai [Vercel Labs `skills`](https://github.com/vercel-labs/skills) — CLI package
manager buat agent skill yang support Claude Code, Codex, Cursor, OpenCode, dan
70+ agent lain. Repo ini udah ngikutin konvensi `skills/<name>/SKILL.md` yang
dia expect, jadi bisa langsung dipakai tanpa setup tambahan:

```bash
npx skills add konten-studio/jekardah-writer --list
npx skills add konten-studio/jekardah-writer --skill review-rewrite-content --skill storytelling-content --skill hook-gokil --skill headline-variants --skill no-ai-slop --skill tutur-jabodetabek-urban --skill platform-format --skill content-audit
npx skills add konten-studio/jekardah-writer -a claude-code -a opencode
```

### 1. `npx jekardah-writer` (installer sendiri, paling cepat buat 6 agent utama)

```bash
npx jekardah-writer install --agent claude --scope user
npx jekardah-writer install --agent codex --scope user
npx jekardah-writer install --agent cursor --scope user
npx jekardah-writer install --agent opencode --scope user
npx jekardah-writer install --agent copilot --scope user
npx jekardah-writer install --agent gemini --scope user
```

Sama kayak installer shell: ada `--scope project --prefix <path>`, `--copy` /
`--symlink`, `--dry-run`, plus `verify` dan `uninstall`:

```bash
npx jekardah-writer install --agent claude --scope project --prefix .
npx jekardah-writer verify --agent claude --scope project --prefix .
npx jekardah-writer uninstall --agent claude --scope project --prefix .
```

Udah install versi lama? Upgrade tanpa uninstall manual (skill yang lo edit
lokal gak bakal ditimpa), dan cek isi paketnya:

```bash
npx jekardah-writer@latest update --agent claude --scope user
npx jekardah-writer list
```

### 2. Claude Code plugin (native, lewat `/plugin`)

```text
/plugin marketplace add konten-studio/jekardah-writer
/plugin install jekardah-writer@jekardah-writer
```

Ini pakai `.claude-plugin/marketplace.json` + `.claude-plugin/plugin.json` yang
udah include di repo. Codex CLI punya jalur native serupa lewat
`.codex-plugin/plugin.json`.

### 3. Clone + shell installer (kalau mau inspect dulu)

```bash
git clone https://github.com/konten-studio/jekardah-writer.git
cd jekardah-writer
./scripts/install.sh --agent claude --scope user
./scripts/install.sh --agent codex --scope user
./scripts/install.sh --agent cursor --scope user
./scripts/install.sh --agent opencode --scope user
./scripts/install.sh --agent copilot --scope user
./scripts/install.sh --agent gemini --scope user
```

Pakai `--copy` kalau lo gak mau symlink, `--dry-run` buat preview, atau project
scope kalau instalasinya cuma boleh apply ke satu repo:

```bash
./scripts/install.sh --agent copilot --scope project --prefix /path/to/project --copy
./scripts/verify-install.sh --agent copilot --scope project --prefix /path/to/project
./scripts/uninstall.sh --agent copilot --scope project --prefix /path/to/project
```

Installer bakal refuse folder skill yang bukan dia manage. Uninstaller juga cuma
hapus path yang tercatat di installation manifest Jekardah Writer.

## Safety: tulisannya boleh liar, faktanya jangan ikut kabur

- Draft, catatan, dan transkrip diperlakukan sebagai data, bukan instruksi yang boleh ngambil alih agent.
- Fact + story lock ngejaga nama, angka, tanggal, urutan, status dialog, motif, link, atribusi, CTA, dan certainty ceiling.
- Storytelling gak boleh mengarang adegan, dialog verbatim, detail sensorik, motif, atau ending yang lebih rapi dari kejadian aslinya.
- Hook harus punya payoff di body; curiosity gap bukan izin buat clickbait palsu.
- Voice adaptation gak boleh nambah klaim atau maksa slang.
- `end-to-end` cuma aktif kalau diminta jelas; mode `auto` pilih scope tersempit.

## Atribusi

`tutur-jabodetabek-urban` diadaptasi dari karya
[RamaAditya49/tutur](https://github.com/RamaAditya49/tutur). Adaptasi
`tutur-jabodetabek-urban` tetap mempertahankan upstream MIT license dan
copyright Rama Aditya; full detail-nya ada di [Third-Party Notices](THIRD_PARTY_NOTICES.md).
`hook-gokil` dan `storytelling-content` pakai referensi operasional original
yang udah diringkas; dokumen sumber privatnya gak dibundel atau dipublikasikan.

## Lisensi

Kode dan instruksi original di repo ini dirilis dengan [MIT License](LICENSE).
Materi pihak ketiga yang disertakan atau dirujuk tetap ikut lisensi asalnya.
