defmodule Pento.Novi.Pro do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prod" do


    timestamps()
  end

  @doc false
  def changeset(pro, attrs) do
    pro
    |> cast(attrs, [])
    |> validate_required([])
  end
end
