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

  describe "ballot_items" do
    alias Vote.Ballot.Ballot_Item

    @valid_attrs %{score: "120.5"}
    @update_attrs %{score: "456.7"}
    @invalid_attrs %{score: nil}

    def ballot__item_fixture(attrs \\ %{}) do
      {:ok, ballot__item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ballot.create_ballot__item()

      ballot__item
    end

    test "list_ballot_items/0 returns all ballot_items" do
      ballot__item = ballot__item_fixture()
      assert Ballot.list_ballot_items() == [ballot__item]
    end

    test "get_ballot__item!/1 returns the ballot__item with given id" do
      ballot__item = ballot__item_fixture()
      assert Ballot.get_ballot__item!(ballot__item.id) == ballot__item
    end

    test "create_ballot__item/1 with valid data creates a ballot__item" do
      assert {:ok, %Ballot_Item{} = ballot__item} = Ballot.create_ballot__item(@valid_attrs)
      assert ballot__item.score == Decimal.new("120.5")
    end

    test "create_ballot__item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ballot.create_ballot__item(@invalid_attrs)
    end

    test "update_ballot__item/2 with valid data updates the ballot__item" do
      ballot__item = ballot__item_fixture()
      assert {:ok, %Ballot_Item{} = ballot__item} = Ballot.update_ballot__item(ballot__item, @update_attrs)
      assert ballot__item.score == Decimal.new("456.7")
    end

    test "update_ballot__item/2 with invalid data returns error changeset" do
      ballot__item = ballot__item_fixture()
      assert {:error, %Ecto.Changeset{}} = Ballot.update_ballot__item(ballot__item, @invalid_attrs)
      assert ballot__item == Ballot.get_ballot__item!(ballot__item.id)
    end

    test "delete_ballot__item/1 deletes the ballot__item" do
      ballot__item = ballot__item_fixture()
      assert {:ok, %Ballot_Item{}} = Ballot.delete_ballot__item(ballot__item)
      assert_raise Ecto.NoResultsError, fn -> Ballot.get_ballot__item!(ballot__item.id) end
    end

    test "change_ballot__item/1 returns a ballot__item changeset" do
      ballot__item = ballot__item_fixture()
      assert %Ecto.Changeset{} = Ballot.change_ballot__item(ballot__item)
    end
  end

  describe "elections" do
    alias Vote.Ballot.Election

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def election_fixture(attrs \\ %{}) do
      {:ok, election} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ballot.create_election()

      election
    end

    test "list_elections/0 returns all elections" do
      election = election_fixture()
      assert Ballot.list_elections() == [election]
    end

    test "get_election!/1 returns the election with given id" do
      election = election_fixture()
      assert Ballot.get_election!(election.id) == election
    end

    test "create_election/1 with valid data creates a election" do
      assert {:ok, %Election{} = election} = Ballot.create_election(@valid_attrs)
      assert election.description == "some description"
      assert election.name == "some name"
    end

    test "create_election/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ballot.create_election(@invalid_attrs)
    end

    test "update_election/2 with valid data updates the election" do
      election = election_fixture()
      assert {:ok, %Election{} = election} = Ballot.update_election(election, @update_attrs)
      assert election.description == "some updated description"
      assert election.name == "some updated name"
    end

    test "update_election/2 with invalid data returns error changeset" do
      election = election_fixture()
      assert {:error, %Ecto.Changeset{}} = Ballot.update_election(election, @invalid_attrs)
      assert election == Ballot.get_election!(election.id)
    end

    test "delete_election/1 deletes the election" do
      election = election_fixture()
      assert {:ok, %Election{}} = Ballot.delete_election(election)
      assert_raise Ecto.NoResultsError, fn -> Ballot.get_election!(election.id) end
    end

    test "change_election/1 returns a election changeset" do
      election = election_fixture()
      assert %Ecto.Changeset{} = Ballot.change_election(election)
    end
  end
end
