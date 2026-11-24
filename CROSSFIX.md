# jscrossfix — JS_V20_VITE_NPM_MONO-FIXED

QA/Testable cross-fix branch (Node 20, Vite, npm monolith):

- **No `.py` files** — avoids Python tool scheduling on a JavaScript profile.
- **PyDriller corpus harness:** `Tool Triggering (Synthetic Data)/pydriller/run_pydriller.js` + `git-history-analyzer.js`.
- **`package-lock.json` committed** — unlocks platform **`npm-audit`**, **`cyclonedx-npm`**, **`license-checker`**, **`npm-outdated`** (no `file_missing_or_empty` lockfile skip).
- **Git history:** prefer shallow fetch **≥ commit count** (this line is ~324 commits). Corpus `run_pydriller.js` caps analysis at **265** commits from `HEAD`; catalog **pydriller** still needs enough fetched objects (same class of fix as V21 trunc if `bad object` persists).

Canonical remote: https://github.com/Nandhini-Testable/jscrossfix branch **JS_V20_VITE_NPM_MONO-FIXED**.

## JS_V20_VITE_NPM_MONO_FIXED_2

Branched from `JS_V20_VITE_NPM_MONO-FIXED` (all content preserved) with data for the tools that did not trigger:

| Tool | Cause | What this branch adds |
| --- | --- | --- |
| `semgrep` | Platform registers plain `semgrep` only for Python/C# lanes; JS lane gets `semgrep-perf-static` / `semgrep-pii`. No cross-language files are added on purpose. | `Tool Triggering (Synthetic Data)/semgrep/` (trigger.yaml, run_semgrep.sh, local ruleset) and a real `reports/semgrep.json` (12 files scanned, 0 findings). |
| `license-checker` | Platform runner does not run `npm install` first (TP-6395), so `licenses.json` is `{}`. | Real `reports/licenses.json` (469 packages) produced from `package-lock.json`. |
| `npm-outdated` | Same missing install step (TP-6395), so `npm-outdated.json` is `{}`. | Real `reports/npm-outdated.json` (319 packages) produced from `package-lock.json`. |
| `pydriller` | Shallow clone on the worker gives `bad object` during diff traversal; repo data cannot fix it. | Nothing new. Existing harness `pydriller/run_pydriller.js` runs cleanly on a full clone (265 commits, 0 errors). |

Reports under `reports/` are snapshots with local paths stripped; regenerate with the run scripts.
