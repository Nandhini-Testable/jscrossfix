#!/usr/bin/env bash
# semgrep -- primary tool, branch JS_V20_VITE_NPM_MONO_FIXED_2 (Node 20).
# Scans src/ with the local ruleset (no network, no registry rules).
set -uo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
# shellcheck source=/dev/null
. "$ROOT/Tool Triggering (Synthetic Data)/_skip.sh"

mkdir -p "$ROOT/reports"
require_binary "semgrep" "semgrep"

cd "$ROOT"
FINDINGS_EXIT=1
semgrep --config "$HERE/semgrep-ruleset.yml" --json --quiet --metrics=off \
  --exclude node_modules --exclude dist --exclude coverage \
  -o reports/semgrep.json src
rc=$?
accept_findings "semgrep" "$rc" "reports/semgrep.json"
exit $?
