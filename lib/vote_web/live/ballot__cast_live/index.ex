defmodule VoteWeb.Ballot_CastLive.Index do
  use VoteWeb, :live_view

  alias Vote.Ballot
  alias Vote.Ballot.Ballot_Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ballot_items, list_ballot_items())}
  end

    @impl true
  def handle_params(%{"id" => id}, _url, socket) do
    {:noreply,
    socket
    |> assign(:ballot_items, Ballot.list_ballot_items(id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ballot items")
    |> assign(:ballot__item, nil)
  end


  def handle_event("up", %{"id" => id}, socket) do
    ballot__item = Ballot.get_ballot__item!(id)

    if ballot__item.score < 9.0 do
      new_score = ballot__item.score + 1 |> Float.round(1)
      Ballot.update_ballot__item(ballot__item, %{score: new_score})
    end

    {:noreply, assign(socket, :ballot_items, list_ballot_items())}
  end

  def handle_event("up_small", %{"id" => id}, socket) do
    ballot__item = Ballot.get_ballot__item!(id)

    if ballot__item.score < 9.9 do
      new_score = ballot__item.score + 0.1 |> Float.round(1)
      Ballot.update_ballot__item(ballot__item, %{score: new_score})
    end

    {:noreply, assign(socket, :ballot_items, list_ballot_items())}
  end

  def handle_event("down", %{"id" => id}, socket) do
    ballot__item = Ballot.get_ballot__item!(id)

    if ballot__item.score > 0.9 do
      new_score = ballot__item.score - 1 |> Float.round(1)
      Ballot.update_ballot__item(ballot__item, %{score: new_score})
    end

    {:noreply, assign(socket, :ballot_items, list_ballot_items())}
  end

  def handle_event("down_small", %{"id" => id}, socket) do
    ballot__item = Ballot.get_ballot__item!(id)

    if ballot__item.score > 0 do
       new_score = ballot__item.score - 0.1 |> Float.round(1)
      Ballot.update_ballot__item(ballot__item, %{score: new_score})
    end

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
