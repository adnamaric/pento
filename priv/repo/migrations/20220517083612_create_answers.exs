defmodule Pento.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :answer, :string
      add :user_id, references( :users, on_delete: :delete_all)
      add :question_id, references( :questions, on_delete: :delete_all)

      timestamps()
    end
  

  end
 
end
