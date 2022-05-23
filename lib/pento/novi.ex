defmodule Pento.Novi do
  @moduledoc """
  The Novi context.
  """

  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.Novi.Pro

  @doc """
  Returns the list of prod.

  ## Examples

      iex> list_prod()
      [%Pro{}, ...]

  """
  def list_prod do
    Repo.all(Pro)
  end

  @doc """
  Gets a single pro.

  Raises `Ecto.NoResultsError` if the Pro does not exist.

  ## Examples

      iex> get_pro!(123)
      %Pro{}

      iex> get_pro!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pro!(id), do: Repo.get!(Pro, id)

  @doc """
  Creates a pro.

  ## Examples

      iex> create_pro(%{field: value})
      {:ok, %Pro{}}

      iex> create_pro(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pro(attrs \\ %{}) do
    %Pro{}
    |> Pro.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pro.

  ## Examples

      iex> update_pro(pro, %{field: new_value})
      {:ok, %Pro{}}

      iex> update_pro(pro, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pro(%Pro{} = pro, attrs) do
    pro
    |> Pro.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pro.

  ## Examples

      iex> delete_pro(pro)
      {:ok, %Pro{}}

      iex> delete_pro(pro)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pro(%Pro{} = pro) do
    Repo.delete(pro)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pro changes.

  ## Examples

      iex> change_pro(pro)
      %Ecto.Changeset{data: %Pro{}}

  """
  def change_pro(%Pro{} = pro, attrs \\ %{}) do
    Pro.changeset(pro, attrs)
  end
end
