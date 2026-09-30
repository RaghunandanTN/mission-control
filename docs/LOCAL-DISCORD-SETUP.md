# Local Mission Control and Discord setup

## Start Mission Control
From the repository directory:
- Install dependencies: pnpm install --frozen-lockfile
- Build: pnpm build
- Start: bash scripts/start-local.sh
- Open http://127.0.0.1:3000
Keep the server terminal running.

## Existing integration
Discord messages go to OpenClaw's main agent.
Mission Control's main agent record has ID 1.
The mission-control skill is installed at:
~/.openclaw/workspace/skills/mission-control/SKILL.md

The agent credential is stored privately at:
~/.openclaw/credentials/mission-control-main.json

Load its api_key field inside the request process.
Never print the key or include it in chat or Git.
This version requires operator scope for task creation.
tasks:write is not supported by this version.
The operator key was created with a 30-day expiry.

## Local data
The startup script uses ~/.mission-control/data.
Back up this directory privately before upgrades.
It contains the database and generated credentials.
Keep it outside Git. The original .next/standalone/.data
was retained during migration.

## Verified behavior
Discord can list tasks and create tasks.
Task #1: Nokia IMS Interview Preparation.
Initial status: inbox. Priority: medium.
Task creation does not itself start autonomous task execution.

## macOS background service

Mission Control starts at login through:
~/Library/LaunchAgents/com.raghunandan.mission-control.plist

Open the dashboard at http://127.0.0.1:3000.

### Stop before rebuilding
launchctl bootout "gui/$(id -u)/com.raghunandan.mission-control"

### Rebuild
pnpm build

### Refresh standalone assets
mkdir -p .next/standalone/.next/static .next/standalone/public
cp -R .next/static/. .next/standalone/.next/static/
cp -R public/. .next/standalone/public/

### Start after rebuilding
launchctl bootstrap "gui/$(id -u)" \
  "$HOME/Library/LaunchAgents/com.raghunandan.mission-control.plist"

### Check errors
tail -n 40 "$HOME/.mission-control/logs/server-error.log"

### Agent API key
The main agent credential is stored outside Git:
~/.openclaw/credentials/mission-control-main.json

Its expiry is determined when the key is created.
Use expires_in_days: 365 when creating a one-year replacement.
Changing documentation does not extend an existing key.
Never commit credentials or private data.
