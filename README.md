<div align="center">

```text
      ██╗███████╗██╗  ██╗ █████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗
      ██║██╔════╝██║ ██╔╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║  ██║
      ██║█████╗  █████╔╝ ███████║██████╔╝██║  ██║███████║███████║
 ██   ██║██╔══╝  ██╔═██╗ ██╔══██║██╔══██╗██║  ██║██╔══██║██╔══██║
 ╚█████╔╝███████╗██║  ██╗██║  ██║██║  ██║██████╔╝██║  ██║██║  ██║
  ╚════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                           W R I T E R
```

### Konten lo gak jelek. Cuma kedengeran kayak semua orang. 🔥

**Drop the draft. Keluarin tulisan yang punya hook, punya suara, dan tetap fact-locked.**

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
agent lo kerja kayak editor: lock faktanya dulu, cari tension yang emang ada,
bersihin pola AI, baru adjust voice Jabodetabek secukupnya.

| Skill | Kerjaan |
|---|---|
| `review-rewrite-content` | Pemimpin redaksi: pilih mode, lock fakta, atur handoff, jalankan QA |
| `hook-gokil` | Cari hook yang bikin berhenti scroll tanpa ngarang payoff |
| `no-ai-slop` | Buang pembukaan kaleng, hiperbola, dan ritme yang terlalu mesin |
| `tutur-jabodetabek-urban` | Kasih register lokal tanpa cosplay slang atau stereotip wilayah |

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

## Cara Kerja: empat skill masuk, satu suara keluar

```text
 DRAFT
   │
   ▼
 [FACT LOCK] ── nama · angka · klaim · CTA · struktur
   │
   ├──▶ HOOK GOKIL ──────▶ angle + payoff
   ├──▶ NO AI SLOP ────▶ konkret + ritmis + bersih
   └──▶ TUTUR URBAN ───▶ register Jabodetabek
   │
   ▼
 [FINAL QA] ── facts · format · payoff · tone
   │
   ▼
 KONTEN YANG KEDENGERAN KAYAK LO
```

## Mode: gak semua draft perlu dibongkar total

| Mode | Dipakai saat | Yang boleh berubah |
|---|---|---|
| `auto` | Lo mau agent pilih scope paling kecil yang cukup | Hanya layer yang benar-benar diminta |
| `review-only` | Lo butuh diagnosis tanpa menyentuh draft | Tidak ada |
| `hook-only` | Body udah kuat, pembukanya belum narik | Hook saja |
| `anti-slop-only` | Isinya benar, tapi bahasanya generik | Prosa, bukan angle atau fakta |
| `voice-only` | Struktur aman, voice-nya belum dapet | Diksi, pronoun, dan rhythm |
| `end-to-end` | Draft memang perlu masuk meja operasi penuh | Semua layer dalam pagar fact lock |

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

Clone repo dulu biar lo bisa inspect installer-nya. Kita sengaja gak
nyaranin pola `curl | bash`.

```bash
git clone https://github.com/konten-studio/jekardah-writer.git
cd jekardah-writer
```

Install buat satu agent. Default-nya symlink di user scope:

```bash
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

### Native plugin

Repo ini juga include `.claude-plugin/plugin.json` dan
`.codex-plugin/plugin.json`. Pakai native plugin/marketplace flow ketika repo
udah terdaftar di sana; portable installer tetap available buat setup lokal yang eksplisit.

## Safety: tulisannya boleh liar, faktanya jangan ikut kabur

- Draft diperlakukan sebagai data, bukan instruksi yang boleh ngambil alih agent.
- Fact lock ngejaga nama, angka, tanggal, link, atribusi, CTA, dan certainty ceiling.
- Hook harus punya payoff di body; curiosity gap bukan izin buat clickbait palsu.
- Voice adaptation gak boleh nambah klaim atau maksa slang.
- `end-to-end` cuma aktif kalau diminta jelas; mode `auto` pilih scope tersempit.

## Atribusi

`tutur-jabodetabek-urban` diadaptasi dari karya
[RamaAditya49/tutur](https://github.com/RamaAditya49/tutur). Adaptasi
`tutur-jabodetabek-urban` tetap mempertahankan upstream MIT license dan
copyright Rama Aditya; full detail-nya ada di [Third-Party Notices](THIRD_PARTY_NOTICES.md).
`hook-gokil` pakai referensi yang udah diringkas; dokumen sumber privatnya gak
dibundel atau dipublikasikan.

## Lisensi

Kode dan instruksi original di repo ini dirilis dengan [MIT License](LICENSE).
Materi pihak ketiga yang disertakan atau dirujuk tetap ikut lisensi asalnya.
