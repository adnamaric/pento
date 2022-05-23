defmodule Pento.Testna.Test do
    alias Pento.Testna.Test
    alias Pento.Repo
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "testna" do
      field :name, :string
      field :number, :integer

      timestamps()
    end
  
  @doc false
  def changeset(test, attrs) do
    test
    |> cast(attrs, [:name, :number])
    |> validate_required([:name, :number])
    |> validate_number(:number, greater_than: 0)
  end

  end