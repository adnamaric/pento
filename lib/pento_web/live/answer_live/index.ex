defmodule PentoWeb.AnswerLive.Index do
  use PentoWeb, :live_view

  alias Pento.FAQ_answers
  alias Pento.FAQ_answers.Answer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :answers, list_answers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Answer")
    |> assign(:answer, FAQ_answers.get_answer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Answer")
    |> assign(:answer, %Answer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Answers")
    |> assign(:answer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    answer = FAQ_answers.get_answer!(id)
    {:ok, _} = FAQ_answers.delete_answer(answer)

    {:noreply, assign(socket, :answers, list_answers())}
  end

  defp list_answers do
    FAQ_answers.list_answers()
  end
end
