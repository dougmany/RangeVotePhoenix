defmodule VoteWeb.Ballot_ItemLive.Index do
  use VoteWeb, :live_view

  alias Vote.Ballot
  alias Vote.Ballot.Ballot_Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ballot_items, list_ballot_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ballot  item")
    |> assign(:ballot__item, Ballot.get_ballot__item!(id))
    |> assign(:candidates, list_candidates())
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ballot  item")
    |> assign(:ballot__item, %Ballot_Item{})
    |> assign(:candidates, list_candidates())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ballot items")
    |> assign(:ballot__item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ballot__item = Ballot.get_ballot__item!(id)
    {:ok, _} = Ballot.delete_ballot__item(ballot__item)

    {:noreply, assign(socket, :ballot_items, list_ballot_items())}
  end

  defp list_ballot_items do
    sort_options = %{sort_by: :score, sort_order: :desc}
    Ballot.list_ballot_items(sort: sort_options)
  end

  defp list_candidates do
    Ballot.list_candidates()
  end
end
