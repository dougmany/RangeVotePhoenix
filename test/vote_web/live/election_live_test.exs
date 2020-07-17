defmodule VoteWeb.ElectionLiveTest do
  use VoteWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Vote.Ballot

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp fixture(:election) do
    {:ok, election} = Ballot.create_election(@create_attrs)
    election
  end

  defp create_election(_) do
    election = fixture(:election)
    %{election: election}
  end

  describe "Index" do
    setup [:create_election]

    test "lists all elections", %{conn: conn, election: election} do
      {:ok, _index_live, html} = live(conn, Routes.election_index_path(conn, :index))

      assert html =~ "Listing Elections"
      assert html =~ election.description
    end

    test "saves new election", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.election_index_path(conn, :index))

      assert index_live |> element("a", "New Election") |> render_click() =~
               "New Election"

      assert_patch(index_live, Routes.election_index_path(conn, :new))

      assert index_live
             |> form("#election-form", election: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#election-form", election: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.election_index_path(conn, :index))

      assert html =~ "Election created successfully"
      assert html =~ "some description"
    end

    test "updates election in listing", %{conn: conn, election: election} do
      {:ok, index_live, _html} = live(conn, Routes.election_index_path(conn, :index))

      assert index_live |> element("#election-#{election.id} a", "Edit") |> render_click() =~
               "Edit Election"

      assert_patch(index_live, Routes.election_index_path(conn, :edit, election))

      assert index_live
             |> form("#election-form", election: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#election-form", election: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.election_index_path(conn, :index))

      assert html =~ "Election updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes election in listing", %{conn: conn, election: election} do
      {:ok, index_live, _html} = live(conn, Routes.election_index_path(conn, :index))

      assert index_live |> element("#election-#{election.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#election-#{election.id}")
    end
  end

  describe "Show" do
    setup [:create_election]

    test "displays election", %{conn: conn, election: election} do
      {:ok, _show_live, html} = live(conn, Routes.election_show_path(conn, :show, election))

      assert html =~ "Show Election"
      assert html =~ election.description
    end

    test "updates election within modal", %{conn: conn, election: election} do
      {:ok, show_live, _html} = live(conn, Routes.election_show_path(conn, :show, election))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Election"

      assert_patch(show_live, Routes.election_show_path(conn, :edit, election))

      assert show_live
             |> form("#election-form", election: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#election-form", election: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.election_show_path(conn, :show, election))

      assert html =~ "Election updated successfully"
      assert html =~ "some updated description"
    end
  end
end
