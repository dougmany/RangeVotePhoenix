defmodule Vote.Repo.Migrations.CreateBallotItems do
  use Ecto.Migration

  def change do
    create table(:ballot_items) do
      add :score, :float
      add :candidate_id, references(:candidates, on_delete: :nothing)

      timestamps()
    end

    create index(:ballot_items, [:candidate_id])
  end
end
