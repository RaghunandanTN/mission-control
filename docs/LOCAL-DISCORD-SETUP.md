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
