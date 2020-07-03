defmodule VoteWeb.Ballot_ItemLive.FormComponent do
  use VoteWeb, :live_component

  alias Vote.Ballot

  @impl true
  def update(%{ballot__item: ballot__item} = assigns, socket) do
    changeset = Ballot.change_ballot__item(ballot__item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"ballot__item" => ballot__item_params}, socket) do
    changeset =
      socket.assigns.ballot__item
      |> Ballot.change_ballot__item(ballot__item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ballot__item" => ballot__item_params}, socket) do
    save_ballot__item(socket, socket.assigns.action, ballot__item_params)
  end

  defp save_ballot__item(socket, :edit, ballot__item_params) do
    case Ballot.update_ballot__item(socket.assigns.ballot__item, ballot__item_params) do
      {:ok, _ballot__item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ballot  item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_ballot__item(socket, :new, ballot__item_params) do
    case Ballot.create_ballot__item(ballot__item_params) do
      {:ok, _ballot__item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ballot  item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
