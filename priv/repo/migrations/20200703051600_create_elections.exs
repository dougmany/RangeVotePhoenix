defmodule Vote.Repo.Migrations.CreateElections do
  use Ecto.Migration

  def change do
    create table(:elections) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
