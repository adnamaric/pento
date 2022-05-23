defmodule Pento.Repo.Migrations.AddTest do
  use Ecto.Migration

  def change do
    create table(:test) do
      add :name, :string
      add :number, :integer
      timestamps()

  end
 end
end
