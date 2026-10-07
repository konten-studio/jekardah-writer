#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const os = require('os');
const crypto = require('crypto');

const ROOT = path.join(__dirname, '..');
const SKILLS_DIR = path.join(ROOT, 'skills');
const PKG = require(path.join(ROOT, 'package.json'));
const SKILL_NAME = /^[a-z0-9][a-z0-9-]*$/;

const AGENT_REL = {
  user: {
    claude: '.claude/skills',
    codex: '.codex/skills',
    cursor: '.cursor/skills',
    opencode: '.config/opencode/skills',
    copilot: '.copilot/skills',
    gemini: '.gemini/skills',
  },
  project: {
    claude: '.claude/skills',
    codex: '.agents/skills',
    cursor: '.cursor/skills',
    opencode: '.opencode/skills',
    copilot: '.github/skills',
    gemini: '.gemini/skills',
  },
};

const MANIFEST_NAME = '.jekardah-writer-install.json';

function fail(msg) {
  console.error(msg);
  process.exit(1);
}

function listSkills() {
  return fs
    .readdirSync(SKILLS_DIR, { withFileTypes: true })
    .filter((e) => e.isDirectory())
    .map((e) => e.name)
    .filter((name) => fs.existsSync(path.join(SKILLS_DIR, name, 'SKILL.md')))
    .sort();
}

function skillDescription(name) {
  const text = fs.readFileSync(path.join(SKILLS_DIR, name, 'SKILL.md'), 'utf8');
  const m = text.match(/^description:\s*(.+)$/m);
  return m ? m[1].trim() : '';
}

function takeValue(argv, i, flag) {
  const value = argv[i + 1];
  if (value === undefined || value.startsWith('--')) fail(`${flag} needs a value`);
  return value;
}

function parseArgs(argv) {
  const opts = { scope: 'user', method: 'copy', dryRun: false };
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    switch (arg) {
      case '--agent':
        opts.agent = takeValue(argv, i++, arg);
        break;
      case '--scope':
        opts.scope = takeValue(argv, i++, arg);
        break;
      case '--prefix':
        opts.prefix = takeValue(argv, i++, arg);
        break;
      case '--copy':
        opts.method = 'copy';
        break;
      case '--symlink':
        opts.method = 'symlink';
        break;
      case '--dry-run':
        opts.dryRun = true;
        break;
      default:
        fail(`Unknown option: ${arg}`);
    }
  }
  if (!opts.agent) fail('--agent is required');
  if (!AGENT_REL[opts.scope]) fail(`Unsupported scope: ${opts.scope}`);
  if (!AGENT_REL[opts.scope][opts.agent]) fail(`Unsupported agent: ${opts.agent}`);
  return opts;
}

function resolveDest(opts) {
  const base = opts.prefix
    ? path.resolve(opts.prefix)
    : opts.scope === 'user'
    ? os.homedir()
    : process.cwd();
  if (/[\u0000-\u001f]/.test(base)) fail('Unsafe prefix: control characters are not allowed');
  const rel = AGENT_REL[opts.scope][opts.agent];
  return path.join(base, rel);
}

function copyDir(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const s = path.join(src, entry.name);
    const d = path.join(dest, entry.name);
    if (entry.isDirectory()) copyDir(s, d);
    else fs.copyFileSync(s, d);
  }
}

function treeDigest(dir) {
  const files = [];
  (function walk(d, rel) {
    for (const entry of fs.readdirSync(d, { withFileTypes: true })) {
      const full = path.join(d, entry.name);
      const relPath = rel ? `${rel}/${entry.name}` : entry.name;
      if (entry.isDirectory()) walk(full, relPath);
      else files.push(relPath);
    }
  })(dir, '');
  files.sort();
  const hash = crypto.createHash('sha256');
  for (const f of files) {
    const fileHash = crypto.createHash('sha256').update(fs.readFileSync(path.join(dir, f))).digest('hex');
    hash.update(`${f}\t${fileHash}\n`);
  }
  return hash.digest('hex');
}

function cmdInstall(argv) {
  const opts = parseArgs(argv);
  const dest = resolveDest(opts);
  const manifestPath = path.join(dest, MANIFEST_NAME);
  const skills = listSkills();

  for (const skill of skills) {
    const target = path.join(dest, skill);
    if (fs.lstatSync(target, { throwIfNoEntry: false })) {
      fail(`Refusing to overwrite existing path: ${target}`);
    }
  }

  if (opts.dryRun) {
    console.log(`Would install ${skills.length} skills to ${dest} using ${opts.method}`);
    return;
  }

  writeInstall(dest, opts, skills);
  console.log(`Installed Jekardah Writer v${PKG.version} (${skills.length} skills) for ${opts.agent} (${opts.scope}) at ${dest}`);
}

function removeTarget(target) {
  fs.rmSync(target, { recursive: true, force: true });
}

// Places every skill, then the manifest. If anything fails midway, the skills
// placed by this call are removed so no half-install is left behind.
function writeInstall(dest, opts, skills) {
  fs.mkdirSync(dest, { recursive: true });
  const manifest = {
    schema: 'jekardah-writer-v1',
    version: PKG.version,
    agent: opts.agent,
    scope: opts.scope,
    method: opts.method,
    skills: {},
  };
  const placed = [];
  try {
    for (const skill of skills) {
      const source = path.join(SKILLS_DIR, skill);
      const target = path.join(dest, skill);
      if (opts.method === 'symlink') {
        fs.symlinkSync(source, target, process.platform === 'win32' ? 'junction' : 'dir');
      } else {
        copyDir(source, target);
      }
      placed.push(target);
      manifest.skills[skill] = { target, digest: treeDigest(target) };
    }
    const tmp = path.join(dest, `${MANIFEST_NAME}.${process.pid}.tmp`);
    fs.writeFileSync(tmp, JSON.stringify(manifest, null, 2));
    fs.renameSync(tmp, path.join(dest, MANIFEST_NAME));
  } catch (err) {
    for (const target of placed) removeTarget(target);
    fail(`Install failed, rolled back: ${err.message}`);
  }
}

function readManifest(dest, opts) {
  const manifestPath = path.join(dest, MANIFEST_NAME);
  if (!fs.existsSync(manifestPath)) fail(`Installation manifest not found: ${manifestPath}`);
  const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
  const tampered = () => fail('Installation manifest is malformed or tampered; nothing was changed.');
  if (manifest.schema !== 'jekardah-writer-v1' || manifest.agent !== opts.agent || manifest.scope !== opts.scope) tampered();
  if (!manifest.skills || typeof manifest.skills !== 'object') tampered();
  for (const [skill, info] of Object.entries(manifest.skills)) {
    // Only ever touch <dest>/<skill-name>; a forged target path is rejected.
    if (!SKILL_NAME.test(skill) || !info || info.target !== path.join(dest, skill)) tampered();
  }
  return { manifest, manifestPath };
}

function cmdVerify(argv) {
  const opts = parseArgs(argv);
  const dest = resolveDest(opts);
  const { manifest } = readManifest(dest, opts);
  for (const [skill, info] of Object.entries(manifest.skills)) {
    if (!fs.existsSync(path.join(info.target, 'SKILL.md'))) fail(`Missing installed skill: ${skill}`);
    const actual = treeDigest(info.target);
    if (actual !== info.digest) fail(`Installed skill was modified: ${skill}`);
  }
  console.log(`Verified Jekardah Writer at ${dest}`);
}

function cmdUninstall(argv) {
  const opts = parseArgs(argv);
  const dest = resolveDest(opts);
  const { manifest, manifestPath } = readManifest(dest, opts);
  assertUnmodified(manifest, 'Nothing was removed');
  for (const info of Object.values(manifest.skills)) removeTarget(info.target);
  fs.rmSync(manifestPath, { force: true });
  console.log(`Uninstalled Jekardah Writer from ${dest}`);
}

function assertUnmodified(manifest, consequence) {
  for (const [skill, info] of Object.entries(manifest.skills)) {
    if (!fs.existsSync(path.join(info.target, 'SKILL.md')) || treeDigest(info.target) !== info.digest) {
      fail(`Installed skill was modified or is missing: ${skill}. ${consequence}; back up your changes first.`);
    }
  }
}

function cmdUpdate(argv) {
  const opts = parseArgs(argv);
  const dest = resolveDest(opts);
  const { manifest } = readManifest(dest, opts);
  opts.method = manifest.method === 'symlink' ? 'symlink' : 'copy';
  const skills = listSkills();
  const managed = Object.keys(manifest.skills);

  for (const skill of skills) {
    const target = path.join(dest, skill);
    if (!managed.includes(skill) && fs.lstatSync(target, { throwIfNoEntry: false })) {
      fail(`Refusing to overwrite existing unmanaged path: ${target}`);
    }
  }
  assertUnmodified(manifest, 'Nothing was updated');

  const added = skills.filter((s) => !managed.includes(s));
  const removed = managed.filter((s) => !skills.includes(s));
  const from = manifest.version || 'unknown';
  if (opts.dryRun) {
    console.log(`Would update ${dest} from v${from} to v${PKG.version} (+${added.length} new, -${removed.length} retired)`);
    return;
  }
  for (const info of Object.values(manifest.skills)) removeTarget(info.target);
  writeInstall(dest, opts, skills);
  console.log(`Updated Jekardah Writer v${from} -> v${PKG.version} at ${dest}`);
  if (added.length) console.log(`  new: ${added.join(', ')}`);
  if (removed.length) console.log(`  retired: ${removed.join(', ')}`);
}

function cmdList() {
  console.log(`Jekardah Writer v${PKG.version}\n`);
  for (const skill of listSkills()) {
    const desc = skillDescription(skill).replace(/^Use when /, '');
    console.log(`  ${skill.padEnd(26)} ${desc.length > 90 ? `${desc.slice(0, 87)}...` : desc}`);
  }
}

function cmdCheck(argv) {
  const { scan } = require('./slop-radar');
  let file;
  let json = false;
  let minScore = null;
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    if (arg === '--json') json = true;
    else if (arg === '--min-score') {
      minScore = Number(takeValue(argv, i++, arg));
      if (!Number.isFinite(minScore) || minScore < 0 || minScore > 100) fail('--min-score must be 0-100');
    } else if (!file && (arg === '-' || !arg.startsWith('--'))) file = arg;
    else fail(`Unknown option: ${arg}`);
  }
  if (!file) fail('Usage: npx jekardah-writer check <file|-> [--json] [--min-score N]');

  let text;
  try {
    text = fs.readFileSync(file === '-' ? 0 : file, 'utf8');
  } catch (err) {
    fail(`Cannot read ${file}: ${err.message}`);
  }
  const report = scan(text);
  const name = file === '-' ? 'stdin' : file;

  if (json) {
    console.log(JSON.stringify({ file: name, ...report }, null, 2));
  } else {
    console.log(`Slop Radar: ${name} (${report.words} kata)\n`);
    if (!report.findings.length) console.log('  Gak ketemu pola template yang umum. Tetap baca ulang buat voice dan fakta.');
    for (const f of report.findings) {
      console.log(`  ${`${f.line}:${f.column}`.padEnd(7)} [${f.severity}] ${f.label}: "${f.match}"`);
      console.log(`  ${' '.repeat(7)} -> ${f.repair}`);
    }
    console.log(`\nSkor: ${report.score}/100 (${report.verdict})`);
    console.log('Ini sinyal heuristik, bukan vonis. Buat diagnosis + rewrite yang fact-locked, pakai skill no-ai-slop atau content-audit.');
  }
  if (minScore !== null && report.score < minScore) process.exit(1);
}

function main() {
  const [, , cmd, ...rest] = process.argv;
  switch (cmd) {
    case 'install':
      return cmdInstall(rest);
    case 'verify':
      return cmdVerify(rest);
    case 'uninstall':
      return cmdUninstall(rest);
    case 'update':
      return cmdUpdate(rest);
    case 'list':
      return cmdList();
    case 'check':
      return cmdCheck(rest);
    case 'version':
    case '--version':
    case '-v':
      return console.log(PKG.version);
    default:
      console.log(
        [
          `Jekardah Writer v${PKG.version}`,
          '',
          'Usage:',
          '  npx jekardah-writer <install|update|verify|uninstall> --agent <claude|codex|cursor|opencode|copilot|gemini> [--scope user|project] [--prefix DIR] [--copy|--symlink] [--dry-run]',
          '  npx jekardah-writer check <file|-> [--json] [--min-score N]',
          '  npx jekardah-writer list',
          '  npx jekardah-writer --version',
          '',
          'Examples:',
          '  npx jekardah-writer install --agent claude --scope user',
          '  npx jekardah-writer install --agent claude --scope project --prefix .',
          '  npx jekardah-writer update --agent claude --scope user',
          '  npx jekardah-writer verify --agent claude --scope user',
          '  npx jekardah-writer uninstall --agent claude --scope user',
          '  npx jekardah-writer check draft.md',
          '  pbpaste | npx jekardah-writer check - --min-score 80',
        ].join('\n')
      );
      process.exit(cmd && cmd !== 'help' && cmd !== '--help' && cmd !== '-h' ? 1 : 0);
  }
}

main();
