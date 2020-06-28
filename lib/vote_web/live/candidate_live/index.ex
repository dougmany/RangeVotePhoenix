defmodule VoteWeb.CandidateLive.Index do
  use VoteWeb, :live_view

  alias Vote.Ballot
  alias Vote.Ballot.Candidate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :candidates, list_candidates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    candidates = list_candidates()

    socket = assign(socket, candidates: candidates)

    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Candidate")
    |> assign(:candidate, Ballot.get_candidate!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Candidate")
    |> assign(:candidate, %Candidate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Candidates")
    |> assign(:candidate, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    candidate = Ballot.get_candidate!(id)
    {:ok, _} = Ballot.delete_candidate(candidate)

    {:noreply, assign(socket, :candidates, list_candidates())}
  end

  def handle_event("up", %{"id"=> id}, socket) do
    candidate = Ballot.get_candidate!(id)
    if candidate.score < 10, do: Ballot.update_candidate(candidate, %{score: candidate.score + 1})

    {:noreply, assign(socket, :candidates, list_candidates())}
  end

  def handle_event("down", %{"id"=> id}, socket) do
    candidate = Ballot.get_candidate!(id)
    if candidate.score > 0, do: Ballot.update_candidate(candidate, %{score: candidate.score - 1})

    {:noreply, assign(socket, :candidates, list_candidates())}
  end

  defp list_candidates do
    sort_options = %{sort_by: :score, sort_order: :desc}
    Ballot.list_candidates(sort: sort_options)
  end
end
