defmodule App.Router do
  use Plug.Router

  plug :match
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  plug :dispatch

  # Health check endpoint — queries the greetings table to verify
  # both database connectivity and successful migration.
  get "/" do
    {status_code, body} =
      case App.Repo.query("SELECT message FROM greetings LIMIT 1") do
        {:ok, %{rows: [[message]]}} ->
          {200,
           %{
             type: "elixir",
             greeting: message,
             status: %{database: "OK"}
           }}

        {:ok, %{rows: []}} ->
          {503,
           %{
             type: "elixir",
             greeting: nil,
             status: %{database: "ERROR: greetings table is empty"}
           }}

        {:error, %Postgrex.Error{postgres: %{message: msg}}} ->
          {503,
           %{
             type: "elixir",
             greeting: nil,
             status: %{database: "ERROR: #{msg}"}
           }}

        {:error, reason} ->
          {503,
           %{
             type: "elixir",
             greeting: nil,
             status: %{database: "ERROR: #{inspect(reason)}"}
           }}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status_code, Jason.encode!(body))
  end

  match _ do
    send_resp(conn, 404, Jason.encode!(%{error: "not found"}))
  end
end
