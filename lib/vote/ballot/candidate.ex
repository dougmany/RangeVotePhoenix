defmodule Vote.Ballot.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Vote.Ballot.Ballot_Item

  schema "candidates" do
    field :description, :string
    field :name, :string
    field :score, :integer, default: 5
    has_many :ballot_items, Ballot_Item

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :description, :score])
    |> validate_required([:name, :description, :score])
  end
end
