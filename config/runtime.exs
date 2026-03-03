import Config

# Runtime configuration — evaluated when the application starts,
# not at compile time. This allows environment variables injected
# by Zerops to be read at deploy time rather than build time.
#
# In prod releases (mix release), this file is bundled into the
# release and evaluated each time the release VM starts —
# including initCommand eval calls for migrations.
config :app, App.Repo,
  hostname: System.fetch_env!("DB_HOST"),
  port: String.to_integer(System.fetch_env!("DB_PORT")),
  username: System.fetch_env!("DB_USER"),
  password: System.fetch_env!("DB_PASS"),
  database: System.fetch_env!("DB_NAME"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "10"))

config :app,
  port: String.to_integer(System.get_env("PORT", "4000"))
