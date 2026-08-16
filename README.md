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

**Masukin draft. Keluarin tulisan yang punya hook, punya suara, dan tetap fact-locked.**

</div>

---

## Masalah: idenya punya isi, tulisannya masih berasa bot

Lo udah punya ide, data, bahkan CTA. Tapi draft akhirnya masih dibuka dengan
kalimat aman, diisi jargon generik, lalu ditutup pertanyaan yang bisa ditempel
ke topik apa pun.

Secara teknis benar. Secara rasa, gak ada yang nempel. Orang baca dua baris,
ngerasa pernah lihat tulisan yang sama, lalu lanjut scroll.

## Solusi: bukan sekadar “humanize”, tapi meja redaksi mini buat agent lo

Jekardah Writer bukan tombol sulap “bikin viral”. Ini skill pack yang bikin
agent kerja kayak editor: kunci faktanya dulu, cari tension yang beneran ada,
bersihin pola AI, baru masukin voice Jabodetabek secukupnya.

| Skill | Kerjaan |
|---|---|
| `review-rewrite-content` | Pemimpin redaksi: pilih mode, kunci fakta, atur handoff, jalankan QA |
| `wtf-hook` | Cari hook yang bikin berhenti scroll tanpa ngarang payoff |
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

Yang berubah: hook, spesifisitas, ritme, dan voice. Yang tetap dikunci: fakta,
nama, angka, atribusi, maksud CTA, link, serta batas kepastian sumber.

## Cocok Buat Siapa? Buat yang ogah kedengeran kayak template

- Founder dan operator yang nulis sendiri, tapi ogah terdengar kayak memo direksi.
- Content writer dan social media team yang butuh second-pass editor sebelum publish.
- Creator LinkedIn, X, Instagram, newsletter, atau script video pendek.
- Agency yang perlu voice lokal konsisten tanpa membuka keran halusinasi.
- Siapa pun yang pernah bilang, “Tolong manusia-in draft ini, tapi jangan ubah isinya.”

## Cara Kerja: empat skill masuk, satu suara keluar

```text
 DRAFT
   │
   ▼
 [FACT LOCK] ── nama · angka · klaim · CTA · struktur
   │
   ├──▶ WTF HOOK ──────▶ angle + payoff
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
| `auto` | Lo mau agent memilih scope paling kecil yang cukup | Hanya layer yang benar-benar diminta |
| `review-only` | Lo butuh diagnosis tanpa menyentuh draft | Tidak ada |
| `hook-only` | Body udah kuat, pembukanya belum narik | Hook saja |
| `anti-slop-only` | Isinya benar, tapi bahasanya generik | Prosa, bukan angle atau fakta |
| `voice-only` | Struktur aman, voice-nya belum terasa | Diksi, pronoun, dan ritme |
| `end-to-end` | Draft memang perlu masuk meja operasi penuh | Semua layer dalam pagar fact lock |

Prompt paling simpel:

```text
Pakai review-rewrite-content. Mode: auto.
Review dan rewrite draft di bawah ini. Pertahankan semua fakta, link, dan CTA.
Target voice: neutral Jabodetabek profesional.

[tempel draft]
```

## Kompatibilitas

Status di bawah membedakan integrasi yang punya manifest native, lokasi skill
yang didokumentasikan vendor, dan adapter kompatibilitas yang masih perlu diuji
lebih luas pada beragam versi agent.

| Agent | Jalur | Status rilis awal |
|---|---|---|
| Claude Code | Plugin native + `.claude/skills` | **Native / fixture-tested** |
| Codex CLI | Plugin native + `.codex/skills` | **Native / fixture-tested** |
| Cursor | `.cursor/skills` | **Compatible / fixture-tested** |
| OpenCode | `.opencode/skills` atau user config | **Compatible / fixture-tested** |
| GitHub Copilot | `.github/skills` / `.copilot/skills` | **Documented / fixture-tested** |
| Gemini CLI | `.gemini/skills` | **Documented / fixture-tested** |
| Agent lain | `AGENTS.md` + canonical `skills/` | **Experimental** |

“Fixture-tested” berarti installer diuji pada temporary home/project, bukan
jaminan seluruh versi aplikasi vendor sudah diuji end-to-end.

## Instalasi

Clone repo lebih dulu supaya kode installer bisa lo inspeksi. Kami sengaja tidak
menyarankan pola `curl | bash`.

```bash
git clone https://github.com/konten-studio/jekardah-writer.git
cd jekardah-writer
```

Install untuk satu agent (default: symlink, user scope):

```bash
./scripts/install.sh --agent claude --scope user
./scripts/install.sh --agent codex --scope user
./scripts/install.sh --agent cursor --scope user
./scripts/install.sh --agent opencode --scope user
./scripts/install.sh --agent copilot --scope user
./scripts/install.sh --agent gemini --scope user
```

Pakai `--copy` kalau tidak ingin symlink, `--dry-run` untuk preview, atau project
scope agar instalasi hanya berlaku di satu repo:

```bash
./scripts/install.sh --agent copilot --scope project --prefix /path/to/project --copy
./scripts/verify-install.sh --agent copilot --scope project --prefix /path/to/project
./scripts/uninstall.sh --agent copilot --scope project --prefix /path/to/project
```

Installer menolak menimpa folder skill yang tidak dikelolanya. Uninstaller hanya
menghapus path yang tercatat di manifest instalasi milik Jekardah Writer.

### Native plugin

Repo ini juga menyertakan `.claude-plugin/plugin.json` dan
`.codex-plugin/plugin.json`. Gunakan mekanisme plugin/marketplace native agent
ketika repo sudah terdaftar di sana; installer portable tetap tersedia untuk
setup lokal yang eksplisit.

## Safety: tulisannya boleh liar, faktanya jangan ikut kabur

- Draft diperlakukan sebagai data, bukan instruksi yang boleh mengambil alih agent.
- Fact lock menjaga nama, angka, tanggal, link, atribusi, CTA, dan certainty ceiling.
- Hook harus punya payoff di body; curiosity gap bukan izin buat clickbait palsu.
- Voice adaptation tidak boleh menambah klaim atau memaksakan slang.
- `end-to-end` hanya aktif saat diminta jelas; mode `auto` memilih scope tersempit.

---

<div align="center">

### Built in Jekardah by Konten.Studio 🏙️

*Tools buat agent yang nulis untuk manusia, bukan untuk agent lain.*

</div>

```text
        .:-====================================------::.
     .:==========================================--------:
    -==============================================--------:
  .=================================================---------.
 .====================================================--------.
 -======================================================-------
-============================================+===========------:
===========================================*@@%*===========-----
=========================================+%@@@@@%*===========---
========================================#@@@@@@@@@#===========--
======================================*%@@@@@@@@@%==============
====================================+%@@@@@@@@@@*===============
==================================+%@@@@@@@@@@%+================
==================#@@@@@@#======*%@@@@@@@@@@%*==================
==================@@@@@@@@===+#@@@@@@@@@@@@*====================
==================@@@@@@@@+#%@@@@@@@@@@@@#======================
==================@@@@@@@@@@@@@@@@@@@@%*========================
==================@@@@@@@@@@@@@@@@@@%*==========================
==================@@@@@@@@@@@@@@@@#+============================
==================@@@@@@@@@@@@@@#===============================
==================@@@@@@@@@@@@@@@%#+============================
==================@@@@@@@@@@@@@@@@@@%+==========================
==================@@@@@@@@@@@@@@@@@@@@%*========================
==================@@@@@@@@+#%@@@@@@@@@@@%*======================
==================@@@@@@@@===+#@@@@@@@@@@@@*====================
==================%@@@@@@%======*%@@@@@@@@@@%+==================
==================================*%@@@@@@@@@@#=================
====================================*%@@@@@@@@@@*===============
======================================*@@@@@@@@@@#==============
========================================#@@@@@@@@@#=============
=========================================+%@@@@@@*==============
===========================================#@@@*================
-===========================================++=================-
.==============================================================.
 .============================================================.
  .==========================================================.
    -======================================================-
     .:==================================================-.
        .:--========================================--:.
```

## Atribusi

`tutur-jabodetabek-urban` berasal dari karya
[RamaAditya49/tutur](https://github.com/RamaAditya49/tutur). Adaptasi
`tutur-jabodetabek-urban` mempertahankan lisensi MIT upstream dan
copyright Rama Aditya; detailnya ada di [Third-Party Notices](THIRD_PARTY_NOTICES.md).
`wtf-hook` memakai referensi ringkas yang sudah didistilasi; dokumen sumber
privat tidak dibundel atau dipublikasikan.

## Lisensi

Kode dan instruksi original dalam repository ini dirilis dengan [MIT License](LICENSE).
Materi pihak ketiga yang disertakan atau dirujuk tidak otomatis berubah lisensinya.

---

<div align="center">

**Lo gak butuh tulisan yang terdengar lebih pintar. Lo butuh tulisan yang terasa punya orang.** 🏙️

</div>
