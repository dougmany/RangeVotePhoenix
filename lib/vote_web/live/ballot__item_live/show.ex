defmodule VoteWeb.Ballot_ItemLive.Show do
  use VoteWeb, :live_view

  alias Vote.Ballot

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ballot__item, Ballot.get_ballot__item!(id))}
  end

  defp page_title(:show), do: "Show Ballot  item"
  defp page_title(:edit), do: "Edit Ballot  item"
end
