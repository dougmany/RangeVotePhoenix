defmodule Vote.Repo.Migrations.AddElectionToItems do
  use Ecto.Migration

  def change do
    alter table(:ballot_items) do
      add :election_id, references(:elections, on_delete: :nothing)
    end
  end
end
