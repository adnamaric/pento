defmodule PentoWeb.ProLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.Novi

  @impl true
  def update(%{pro: pro} = assigns, socket) do
    changeset = Novi.change_pro(pro)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"pro" => pro_params}, socket) do
    changeset =
      socket.assigns.pro
      |> Novi.change_pro(pro_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"pro" => pro_params}, socket) do
    save_pro(socket, socket.assigns.action, pro_params)
  end

  defp save_pro(socket, :edit, pro_params) do
    case Novi.update_pro(socket.assigns.pro, pro_params) do
      {:ok, _pro} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pro updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_pro(socket, :new, pro_params) do
    case Novi.create_pro(pro_params) do
      {:ok, _pro} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pro created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
