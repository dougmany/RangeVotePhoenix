defmodule Vote.Ballot do
  @moduledoc """
  The Ballot context.
  """

  import Ecto.Query, warn: false
  alias Vote.Repo

  alias Vote.Ballot.{Candidate, Ballot_Item}

  @doc """
  Returns the list of candidates.

  ## Examples

      iex> list_candidates()
      [%Candidate{}, ...]

  """
  def list_candidates do
    Repo.all(Candidate)
  end

  def list_candidates(criteria) when is_list(criteria)do
    query = from(d in Candidate)

    Enum.reduce(criteria, query, fn
      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
      from q in query, order_by: [{^sort_order, ^sort_by}]
      end)
      |> Repo.all()
  end

  @doc """
  Gets a single candidate.

  Raises `Ecto.NoResultsError` if the Candidate does not exist.

  ## Examples

      iex> get_candidate!(123)
      %Candidate{}

      iex> get_candidate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_candidate!(id), do: Repo.get!(Candidate, id)

  @doc """
  Creates a candidate.

  ## Examples

      iex> create_candidate(%{field: value})
      {:ok, %Candidate{}}

      iex> create_candidate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_candidate(attrs \\ %{}) do
    %Candidate{}
    |> Candidate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a candidate.

  ## Examples

      iex> update_candidate(candidate, %{field: new_value})
      {:ok, %Candidate{}}

      iex> update_candidate(candidate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_candidate(%Candidate{} = candidate, attrs) do
    candidate
    |> Candidate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a candidate.

  ## Examples

      iex> delete_candidate(candidate)
      {:ok, %Candidate{}}

      iex> delete_candidate(candidate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_candidate(%Candidate{} = candidate) do
    Repo.delete(candidate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking candidate changes.

  ## Examples

      iex> change_candidate(candidate)
      %Ecto.Changeset{data: %Candidate{}}

  """
  def change_candidate(%Candidate{} = candidate, attrs \\ %{}) do
    Candidate.changeset(candidate, attrs)
  end

  alias Vote.Ballot.Ballot_Item

  @doc """
  Returns the list of ballot_items.

  ## Examples

      iex> list_ballot_items()
      [%Ballot_Item{}, ...]

  """
  def list_ballot_items do
    Ballot_Item
    |> Repo.all()
    |> Repo.preload(:candidate)
  end

  @doc """
  Gets a single ballot__item.

  Raises `Ecto.NoResultsError` if the Ballot  item does not exist.

  ## Examples

      iex> get_ballot__item!(123)
      %Ballot_Item{}

      iex> get_ballot__item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ballot__item!(id) do
    Ballot_Item
    |> Repo.get!(id)
    |> Repo.preload(:candidate)
  end

  @doc """
  Creates a ballot__item.

  ## Examples

      iex> create_ballot__item(%{field: value})
      {:ok, %Ballot_Item{}}

      iex> create_ballot__item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ballot__item(attrs \\ %{}) do
    %{"candidate_id" => candidate_id } = attrs
    %Ballot_Item{}
    |> Ballot_Item.changeset(attrs)
    |> Ecto.Changeset.put_change(:candidate_id, String.to_integer(candidate_id))
    |> Repo.insert()
  end

  @doc """
  Updates a ballot__item.

  ## Examples

      iex> update_ballot__item(ballot__item, %{field: new_value})
      {:ok, %Ballot_Item{}}

      iex> update_ballot__item(ballot__item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ballot__item(%Ballot_Item{} = ballot__item, attrs) do
    ballot__item
    |> Ballot_Item.changeset(attrs)
    #|> Ecto.Changeset.cast_assoc(:candidate, with: &Candidate.changeset/2)
    |> Repo.update()
  end

  @doc """
  Deletes a ballot__item.

  ## Examples

      iex> delete_ballot__item(ballot__item)
      {:ok, %Ballot_Item{}}

      iex> delete_ballot__item(ballot__item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ballot__item(%Ballot_Item{} = ballot__item) do
    Repo.delete(ballot__item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ballot__item changes.

  ## Examples

      iex> change_ballot__item(ballot__item)
      %Ecto.Changeset{data: %Ballot_Item{}}

  """
  def change_ballot__item(%Ballot_Item{} = ballot__item, attrs \\ %{}) do
    Ballot_Item.changeset(ballot__item, attrs)
  end
end
