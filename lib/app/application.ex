defmodule App.Application do
  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:app, :port, 4000)

    children = [
      # Start the Ecto repo first so DB connections are ready
      # before the HTTP server accepts requests.
      App.Repo,
      {Plug.Cowboy, scheme: :http, plug: App.Router, options: [port: port]}
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
