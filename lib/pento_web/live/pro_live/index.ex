defmodule PentoWeb.ProLive.Index do
  use PentoWeb, :live_view

  alias Pento.Novi
  alias Pento.Novi.Pro

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :prod, list_prod())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pro")
    |> assign(:pro, Novi.get_pro!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pro")
    |> assign(:pro, %Pro{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Prod")
    |> assign(:pro, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pro = Novi.get_pro!(id)
    {:ok, _} = Novi.delete_pro(pro)

    {:noreply, assign(socket, :prod, list_prod())}
  end

  defp list_prod do
    Novi.list_prod()
  end
end
