defmodule Vote.Ballot.Ballot_Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Vote.Ballot.Candidate

  schema "ballot_items" do
    field :score, :float, default: 0.0
    belongs_to :candidate, Candidate

    timestamps()
  end

  @doc false
  def changeset(ballot__item, attrs) do
    ballot__item
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
