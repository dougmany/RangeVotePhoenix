defmodule VoteWeb.ElectionLive.Index do
  use VoteWeb, :live_view

  alias Vote.Ballot
  alias Vote.Ballot.Election

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :elections, list_elections())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Election")
    |> assign(:election, Ballot.get_election!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Election")
    |> assign(:election, %Election{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Elections")
    |> assign(:election, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    election = Ballot.get_election!(id)
    {:ok, _} = Ballot.delete_election(election)

    {:noreply, assign(socket, :elections, list_elections())}
  end

  defp list_elections do
    Ballot.list_elections()
  end
end
