defmodule Vote.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string
      add :description, :string
      add :score, :integer

      timestamps()
    end

  end
end
