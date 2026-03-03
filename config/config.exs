import Config

# Register the Ecto repository — required for mix ecto.* tasks
# and runtime configuration in config/runtime.exs.
config :app, ecto_repos: [App.Repo]
