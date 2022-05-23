defmodule Pento.FAQ_answers.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :answer, :string
    belongs_to :question, Pento.FAQ.Question
    belongs_to :user, Pento.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:answer, :user_id, :question_id])
    |> validate_required([:answer, :user_id, :question_id])
  end
end
