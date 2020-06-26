defmodule VoteWeb.CandidateLiveTest do
  use VoteWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Vote.Ballot

  @create_attrs %{description: "some description", name: "some name", score: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", score: 43}
  @invalid_attrs %{description: nil, name: nil, score: nil}

  defp fixture(:candidate) do
    {:ok, candidate} = Ballot.create_candidate(@create_attrs)
    candidate
  end

  defp create_candidate(_) do
    candidate = fixture(:candidate)
    %{candidate: candidate}
  end

  describe "Index" do
    setup [:create_candidate]

    test "lists all candidates", %{conn: conn, candidate: candidate} do
      {:ok, _index_live, html} = live(conn, Routes.candidate_index_path(conn, :index))

      assert html =~ "Listing Candidates"
      assert html =~ candidate.description
    end

    test "saves new candidate", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.candidate_index_path(conn, :index))

      assert index_live |> element("a", "New Candidate") |> render_click() =~
               "New Candidate"

      assert_patch(index_live, Routes.candidate_index_path(conn, :new))

      assert index_live
             |> form("#candidate-form", candidate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#candidate-form", candidate: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.candidate_index_path(conn, :index))

      assert html =~ "Candidate created successfully"
      assert html =~ "some description"
    end

    test "updates candidate in listing", %{conn: conn, candidate: candidate} do
      {:ok, index_live, _html} = live(conn, Routes.candidate_index_path(conn, :index))

      assert index_live |> element("#candidate-#{candidate.id} a", "Edit") |> render_click() =~
               "Edit Candidate"

      assert_patch(index_live, Routes.candidate_index_path(conn, :edit, candidate))

      assert index_live
             |> form("#candidate-form", candidate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#candidate-form", candidate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.candidate_index_path(conn, :index))

      assert html =~ "Candidate updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes candidate in listing", %{conn: conn, candidate: candidate} do
      {:ok, index_live, _html} = live(conn, Routes.candidate_index_path(conn, :index))

      assert index_live |> element("#candidate-#{candidate.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#candidate-#{candidate.id}")
    end
  end

  describe "Show" do
    setup [:create_candidate]

    test "displays candidate", %{conn: conn, candidate: candidate} do
      {:ok, _show_live, html} = live(conn, Routes.candidate_show_path(conn, :show, candidate))

      assert html =~ "Show Candidate"
      assert html =~ candidate.description
    end

    test "updates candidate within modal", %{conn: conn, candidate: candidate} do
      {:ok, show_live, _html} = live(conn, Routes.candidate_show_path(conn, :show, candidate))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Candidate"

      assert_patch(show_live, Routes.candidate_show_path(conn, :edit, candidate))

      assert show_live
             |> form("#candidate-form", candidate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#candidate-form", candidate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.candidate_show_path(conn, :show, candidate))

      assert html =~ "Candidate updated successfully"
      assert html =~ "some updated description"
    end
  end
end
