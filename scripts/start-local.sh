#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if [[ ! -f .next/standalone/server.js ]]; then
  echo "Production build missing. Run: pnpm build"
  exit 1
fi

mkdir -p .next/standalone/.next/static .next/standalone/public
cp -R .next/static/. .next/standalone/.next/static/
cp -R public/. .next/standalone/public/

export HOSTNAME=127.0.0.1
export PORT=3000
export WS_NO_BUFFER_UTIL=1
export MISSION_CONTROL_DATA_DIR="$REPO_ROOT/.next/standalone/.data"

exec node .next/standalone/server.js
