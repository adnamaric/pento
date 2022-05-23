defmodule Pento.FAQ_answersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.FAQ_answers` context.
  """

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question_id: 42,
        user_id: 42
      })
      |> Pento.FAQ_answers.create_answer()

    answer
  end
end
