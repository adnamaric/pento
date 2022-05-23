defmodule Pento.NoviFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Novi` context.
  """

  @doc """
  Generate a pro.
  """
  def pro_fixture(attrs \\ %{}) do
    {:ok, pro} =
      attrs
      |> Enum.into(%{

      })
      |> Pento.Novi.create_pro()

    pro
  end
end
