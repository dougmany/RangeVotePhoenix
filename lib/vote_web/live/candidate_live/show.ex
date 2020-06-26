defmodule VoteWeb.CandidateLive.Show do
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
     |> assign(:candidate, Ballot.get_candidate!(id))}
  end

  defp page_title(:show), do: "Show Candidate"
  defp page_title(:edit), do: "Edit Candidate"
end
