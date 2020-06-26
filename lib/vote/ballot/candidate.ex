defmodule Vote.Ballot.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :description, :string
    field :name, :string
    field :score, :integer

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :description, :score])
    |> validate_required([:name, :description, :score])
  end
end
