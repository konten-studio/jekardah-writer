# Konten Studio Presents Header

## Goal

Add a compact Konten Studio attribution above the Jekardah Writer ASCII wordmark
at the top of `README.md`.

## Design

- Copy the provided 512 x 512 PNG into the repository as
  `assets/konten-studio-logo.png`.
- Add one centered inline row immediately before the ASCII code block.
- Render the logo at 18 pixels wide, followed by the text
  `konten.studio presents`.
- Keep the existing ASCII wordmark and all other README content unchanged.
- Include concise alt text for the logo.

## Verification

- Confirm the new asset is present and tracked by Git.
- Confirm the README references the repository-local asset.
- Run the repository verification script to catch formatting or structural
  regressions.
