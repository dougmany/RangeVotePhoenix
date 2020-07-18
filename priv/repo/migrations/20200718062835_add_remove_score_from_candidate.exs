defmodule Vote.Repo.Migrations.AddRemoveScoreFromCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      remove :score
    end
  end
end
