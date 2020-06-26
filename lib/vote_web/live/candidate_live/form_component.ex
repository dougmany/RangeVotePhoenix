defmodule VoteWeb.CandidateLive.FormComponent do
  use VoteWeb, :live_component

  alias Vote.Ballot

  @impl true
  def update(%{candidate: candidate} = assigns, socket) do
    changeset = Ballot.change_candidate(candidate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"candidate" => candidate_params}, socket) do
    changeset =
      socket.assigns.candidate
      |> Ballot.change_candidate(candidate_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"candidate" => candidate_params}, socket) do
    save_candidate(socket, socket.assigns.action, candidate_params)
  end

  defp save_candidate(socket, :edit, candidate_params) do
    case Ballot.update_candidate(socket.assigns.candidate, candidate_params) do
      {:ok, _candidate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Candidate updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_candidate(socket, :new, candidate_params) do
    case Ballot.create_candidate(candidate_params) do
      {:ok, _candidate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Candidate created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
