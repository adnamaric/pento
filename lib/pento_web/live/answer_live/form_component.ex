defmodule PentoWeb.AnswerLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.FAQ_answers

  @impl true
  def update(%{answer: answer} = assigns, socket) do
    changeset = FAQ_answers.change_answer(answer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"answer" => answer_params}, socket) do
    changeset =
      socket.assigns.answer
      |> FAQ_answers.change_answer(answer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"answer" => answer_params}, socket) do
    save_answer(socket, socket.assigns.action, answer_params)
  end

  defp save_answer(socket, :edit, answer_params) do
    case FAQ_answers.update_answer(socket.assigns.answer, answer_params) do
      {:ok, _answer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Answer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_answer(socket, :new, answer_params) do
    case FAQ_answers.create_answer(answer_params) do
      {:ok, _answer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Answer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
