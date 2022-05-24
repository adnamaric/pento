defmodule Pento.Catalog.Product do
  alias Pento.Catalog.Product
  alias Pento.Repo
  alias Pento.Survey.Rating  
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string
    timestamps()
    has_many :ratings, Rating
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end
  
 # def unit_price_changeset(product, attrs) do
    # markdown_changeset(product,attrs)|> change_product()
  #end
 
 
  def markdown_changeset(product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_number(:unit_price, less_than: product.unit_price)
  end
 
end
