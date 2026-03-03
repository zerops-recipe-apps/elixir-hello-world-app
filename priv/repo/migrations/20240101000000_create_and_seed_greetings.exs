defmodule App.Repo.Migrations.CreateAndSeedGreetings do
  use Ecto.Migration

  def up do
    execute """
    CREATE TABLE IF NOT EXISTS greetings (
      id INTEGER PRIMARY KEY,
      message TEXT NOT NULL
    )
    """

    execute """
    INSERT INTO greetings (id, message) VALUES (1, 'Hello from Zerops!')
    ON CONFLICT (id) DO NOTHING
    """
  end

  def down do
    execute "DROP TABLE IF EXISTS greetings"
  end
end
