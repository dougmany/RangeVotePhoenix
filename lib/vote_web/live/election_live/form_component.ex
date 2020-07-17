defmodule VoteWeb.ElectionLive.FormComponent do
  use VoteWeb, :live_component

  alias Vote.Ballot

  @impl true
  def update(%{election: election} = assigns, socket) do
    changeset = Ballot.change_election(election)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"election" => election_params}, socket) do
    changeset =
      socket.assigns.election
      |> Ballot.change_election(election_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"election" => election_params}, socket) do
    save_election(socket, socket.assigns.action, election_params)
  end

  defp save_election(socket, :edit, election_params) do
    case Ballot.update_election(socket.assigns.election, election_params) do
      {:ok, _election} ->
        {:noreply,
         socket
         |> put_flash(:info, "Election updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_election(socket, :new, election_params) do
    case Ballot.create_election(election_params) do
      {:ok, _election} ->
        {:noreply,
         socket
         |> put_flash(:info, "Election created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
