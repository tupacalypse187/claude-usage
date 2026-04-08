# Claude Code Usage Dashboard

## Project Overview

A zero-dependency Python dashboard that reads Claude Code's local JSONL usage logs and displays token counts, cost estimates, and session history via a browser-based UI.

## Architecture

- `scanner.py` — Parses `~/.claude/projects/**/*.jsonl` files, stores data in SQLite (`usage.db`)
- `dashboard.py` — HTTP server serving a single-page HTML/JS dashboard with Chart.js charts
- `cli.py` — CLI entry point with `scan`, `today`, `stats`, `dashboard` commands

## Key Details

- **No third-party dependencies** — uses only Python stdlib (`sqlite3`, `http.server`, `json`, `pathlib`)
- **DB path** is configurable via `USAGE_DB_PATH` env var (defaults to `~/.claude/usage.db`)
- **Scanner** stores relative paths in `processed_files` table for portability between host and Docker
- **Dashboard server** binds to `0.0.0.0` (not `localhost`) so it works inside Docker containers
- **Cost discount** — a `COST_DISCOUNT` constant (currently `0.45`) is applied to API pricing to approximate Max plan costs
- **Loading page** — server starts immediately and shows a loading spinner while the background scan runs; auto-refreshes when ready
- **Time ranges** — preset buttons (7d, 30d, 90d, MTD, All) plus custom from/to date pickers; all bookmarkable via URL params

## Docker

- `~/.claude` is mounted **read-only** into the container
- The SQLite DB is written to `/app/usage.db` inside the container (set via `USAGE_DB_PATH` env var)
- Port 8080 is exposed for the dashboard

## Running

```bash
# Local
python3 cli.py dashboard

# Docker
docker compose up --build -d
# Open http://localhost:8080
```
