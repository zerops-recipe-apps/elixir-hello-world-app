# elixir-hello-world-app

Minimal Elixir web app on the BEAM VM with Plug/Cowboy + Ecto, connecting to PostgreSQL and exposing a single health-check endpoint at `/`.

## Zerops service facts

- HTTP port: `4000`
- Siblings: `db` (PostgreSQL) — env: `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASS`, `DB_NAME`
- Runtime base: `elixir@1.16`

## Zerops dev

`setup: dev` idles on `zsc noop --silent`; the agent starts the dev server.

- Dev command: `iex -S mix` (or `mix run --no-halt` for non-interactive)

**All platform operations (start/stop/status/logs of the dev server, deploy, env / scaling / storage / domains) go through the Zerops development workflow via `zcp` MCP tools. Don't shell out to `zcli`.**

## Notes

- `HOME=/home/zerops` is required in dev runtime — Mix and Erlang use it to locate `~/.mix` and `~/.erlang.cookie`.
- `prepareCommands` install Hex and rebar once per container creation; deps are pre-fetched during build.
- Migration runs once per deploy via `mix ecto.migrate` in `initCommands` — schema is ready on SSH.
