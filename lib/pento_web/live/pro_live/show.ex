defmodule PentoWeb.ProLive.Show do
  use PentoWeb, :live_view

  alias Pento.Novi

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pro, Novi.get_pro!(id))}
  end

  defp page_title(:show), do: "Show Pro"
  defp page_title(:edit), do: "Edit Pro"
end
