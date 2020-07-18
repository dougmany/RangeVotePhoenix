defmodule Vote.Ballot.Election do
  use Ecto.Schema
  import Ecto.Changeset

  alias Vote.Ballot.Ballot_Item

  schema "elections" do
    field :description, :string
    field :name, :string
    has_many :ballot_items, Ballot_Item

    timestamps()
  end

  @doc false
  def changeset(election, attrs) do
    election
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
