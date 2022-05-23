defmodule Pento.FAQ.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    field :vote_count, :integer, default: 0
   
    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question,  :vote_count ])
    |> validate_required([:question,  :vote_count])
   
  end
end
