defmodule Vote.BallotTest do
  use Vote.DataCase

  alias Vote.Ballot

  describe "candidates" do
    alias Vote.Ballot.Candidate

    @valid_attrs %{description: "some description", name: "some name", score: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", score: 43}
    @invalid_attrs %{description: nil, name: nil, score: nil}

    def candidate_fixture(attrs \\ %{}) do
      {:ok, candidate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ballot.create_candidate()

      candidate
    end

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Ballot.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Ballot.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      assert {:ok, %Candidate{} = candidate} = Ballot.create_candidate(@valid_attrs)
      assert candidate.description == "some description"
      assert candidate.name == "some name"
      assert candidate.score == 42
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ballot.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{} = candidate} = Ballot.update_candidate(candidate, @update_attrs)
      assert candidate.description == "some updated description"
      assert candidate.name == "some updated name"
      assert candidate.score == 43
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Ballot.update_candidate(candidate, @invalid_attrs)
      assert candidate == Ballot.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Ballot.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Ballot.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Ballot.change_candidate(candidate)
    end
  end
end
