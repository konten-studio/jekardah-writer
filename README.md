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

### Draft masuk. Tulisan yang punya suara keluar. 🔥

**Hook lebih nancep. Bahasa lebih manusia. Tetap fact-locked.**

</div>

---

## Masalah: kontennya benar, tapi rasanya... bot banget

Lo punya ide bagus. Datanya benar. CTA-nya sudah ada. Tapi hasil akhirnya penuh
kalimat aman, pembukaan basa-basi, ritme seragam, dan jargon yang bisa keluar
dari chatbot mana pun. Dibaca sekali, lalu lewat.

## Solusi: satu workflow, tiga specialist skills

Jekardah Writer bukan tombol “bikin viral”. Ini skill pack untuk agent yang
menggabungkan empat lapisan kerja:

| Skill | Kerjaan |
|---|---|
| `review-rewrite-content` | Orchestrator: memilih mode, mengunci fakta, dan menjalankan QA |
| `wtf-hook` | Membuat curiosity gap yang dibayar oleh isi |
| `no-ai-slop` | Membuang pola generik, hiperbola, dan ritme sintetis |
| `tutur-jabodetabek-urban` | Mengatur register lokal tanpa cosplay slang |

## Before → After

**Before**

> Di era digital yang semakin berkembang pesat, personal branding merupakan
> salah satu hal yang sangat penting bagi para profesional. Dalam postingan ini,
> saya akan membagikan tiga tips yang dapat membantu Anda.

**After**

> CV lo bilang “strategic thinker”. Feed LinkedIn lo isinya ucapan selamat pagi.
> Ada mismatch kecil yang recruiter bisa lihat dalam 20 detik. Ini tiga cara
> benerinnya tanpa berubah jadi content creator full-time.

Yang berubah adalah hook, spesifisitas, dan cadence. Yang tidak boleh berubah:
fakta, nama, angka, atribusi, maksud CTA, dan batas kepastian sumber.

## Cocok Buat Siapa?

- Founder dan operator yang nulis sendiri, tapi tidak mau terdengar korporat.
- Content writer dan social media team yang butuh second-pass editor.
- Creator LinkedIn, X, Instagram, newsletter, atau script video pendek.
- Agency yang ingin voice lokal konsisten tanpa mengarang fakta.
- Siapa pun yang bilang, “Tolong manusia-in draft ini, tapi jangan ubah isinya.”

## Cara Kerja

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

## Mode: pilih kontrol yang lo butuhin

| Mode | Dipakai saat | Yang boleh berubah |
|---|---|---|
| `auto` | Lo ingin agent memilih scope tersempit | Hanya layer yang terdeteksi eksplisit |
| `review-only` | Butuh diagnosis, bukan rewrite | Tidak ada |
| `hook-only` | Body sudah kuat, pembuka belum | Hook saja |
| `anti-slop-only` | Isi benar, bahasanya generik | Prosa, bukan angle/fakta |
| `voice-only` | Butuh register lokal tertentu | Diksi, pronoun, rhythm |
| `end-to-end` | Memang minta rewrite penuh | Semua layer, tetap dalam fact lock |

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

## Safety: tulisan boleh liar, fakta jangan

- Draft diperlakukan sebagai data, bukan instruksi yang boleh mengambil alih agent.
- Fact lock menjaga nama, angka, tanggal, link, atribusi, CTA, dan certainty ceiling.
- Hook harus punya payoff di body; curiosity gap bukan izin buat clickbait palsu.
- Voice adaptation tidak boleh menambah klaim atau memaksakan slang.
- `end-to-end` hanya aktif saat diminta jelas; mode `auto` memilih scope tersempit.

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

**Jangan terdengar lebih pintar. Terdengarlah lebih nyata.** 🏙️

</div>
