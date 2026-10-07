# Changelog

## 0.2.0

### Baru

- **Slop Radar** (`npx jekardah-writer check <file|->`): scan draft secara
  offline buat pola AI-slop yang umum (canned opening, empty abstraction,
  over-signposting, inflated claim, fake contrast, generic CTA, em dash
  berlebihan, ritme repetitif). Keluar skor 0-100, posisi baris:kolom, dan
  arah repair. Code block, inline code, dan URL gak ikut di-scan. Ada `--json`
  buat tooling dan `--min-score N` buat gate di CI atau pre-commit.
- `update`: upgrade instalasi lama ke versi terbaru, nambah skill baru, dan
  nolak jalan kalau ada skill yang udah lo edit lokal.
- `list`: lihat semua skill beserta fungsinya.
- `--version` dan `--help`.

### Perbaikan

- `uninstall`/`update` CLI cuma nyentuh `<skills-dir>/<nama-skill>`; manifest
  yang target path-nya dipalsukan ditolak sebelum ada yang dihapus.
- Install CLI sekarang atomic: kalau gagal di tengah, skill yang udah ketaruh
  di-rollback dan manifest ditulis lewat file sementara.
- Flag tanpa value (mis. `--agent` doang) jadi error yang jelas, bukan crash.
- Prefix dengan karakter kontrol ditolak, sama kayak installer shell.
- Dry-run installer shell ngelaporin jumlah skill yang benar (8, bukan "five").
- Versi `package.json`, Claude plugin, dan Codex plugin disamakan.
- `npm test` ngejalanin fixture installer dan CLI.
