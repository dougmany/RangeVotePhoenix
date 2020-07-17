defmodule Vote.Ballot.Election do
  use Ecto.Schema
  import Ecto.Changeset

  schema "elections" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(election, attrs) do
    election
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
