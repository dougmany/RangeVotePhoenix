defmodule VoteWeb.Ballot_ItemLiveTest do
  use VoteWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Vote.Ballot

  @create_attrs %{score: "120.5"}
  @update_attrs %{score: "456.7"}
  @invalid_attrs %{score: nil}

  defp fixture(:ballot__item) do
    {:ok, ballot__item} = Ballot.create_ballot__item(@create_attrs)
    ballot__item
  end

  defp create_ballot__item(_) do
    ballot__item = fixture(:ballot__item)
    %{ballot__item: ballot__item}
  end

  describe "Index" do
    setup [:create_ballot__item]

    test "lists all ballot_items", %{conn: conn, ballot__item: ballot__item} do
      {:ok, _index_live, html} = live(conn, Routes.ballot__item_index_path(conn, :index))

      assert html =~ "Listing Ballot items"
    end

    test "saves new ballot__item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.ballot__item_index_path(conn, :index))

      assert index_live |> element("a", "New Ballot  item") |> render_click() =~
               "New Ballot  item"

      assert_patch(index_live, Routes.ballot__item_index_path(conn, :new))

      assert index_live
             |> form("#ballot__item-form", ballot__item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ballot__item-form", ballot__item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ballot__item_index_path(conn, :index))

      assert html =~ "Ballot  item created successfully"
    end

    test "updates ballot__item in listing", %{conn: conn, ballot__item: ballot__item} do
      {:ok, index_live, _html} = live(conn, Routes.ballot__item_index_path(conn, :index))

      assert index_live |> element("#ballot__item-#{ballot__item.id} a", "Edit") |> render_click() =~
               "Edit Ballot  item"

      assert_patch(index_live, Routes.ballot__item_index_path(conn, :edit, ballot__item))

      assert index_live
             |> form("#ballot__item-form", ballot__item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ballot__item-form", ballot__item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ballot__item_index_path(conn, :index))

      assert html =~ "Ballot  item updated successfully"
    end

    test "deletes ballot__item in listing", %{conn: conn, ballot__item: ballot__item} do
      {:ok, index_live, _html} = live(conn, Routes.ballot__item_index_path(conn, :index))

      assert index_live |> element("#ballot__item-#{ballot__item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ballot__item-#{ballot__item.id}")
    end
  end

  describe "Show" do
    setup [:create_ballot__item]

    test "displays ballot__item", %{conn: conn, ballot__item: ballot__item} do
      {:ok, _show_live, html} = live(conn, Routes.ballot__item_show_path(conn, :show, ballot__item))

      assert html =~ "Show Ballot  item"
    end

    test "updates ballot__item within modal", %{conn: conn, ballot__item: ballot__item} do
      {:ok, show_live, _html} = live(conn, Routes.ballot__item_show_path(conn, :show, ballot__item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ballot  item"

      assert_patch(show_live, Routes.ballot__item_show_path(conn, :edit, ballot__item))

      assert show_live
             |> form("#ballot__item-form", ballot__item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#ballot__item-form", ballot__item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ballot__item_show_path(conn, :show, ballot__item))

      assert html =~ "Ballot  item updated successfully"
    end
  end
end
