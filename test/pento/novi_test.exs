defmodule Pento.NoviTest do
  use Pento.DataCase

  alias Pento.Novi

  describe "prod" do
    alias Pento.Novi.Pro

    import Pento.NoviFixtures

    @invalid_attrs %{}

    test "list_prod/0 returns all prod" do
      pro = pro_fixture()
      assert Novi.list_prod() == [pro]
    end

    test "get_pro!/1 returns the pro with given id" do
      pro = pro_fixture()
      assert Novi.get_pro!(pro.id) == pro
    end

    test "create_pro/1 with valid data creates a pro" do
      valid_attrs = %{}

      assert {:ok, %Pro{} = pro} = Novi.create_pro(valid_attrs)
    end

    test "create_pro/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Novi.create_pro(@invalid_attrs)
    end

    test "update_pro/2 with valid data updates the pro" do
      pro = pro_fixture()
      update_attrs = %{}

      assert {:ok, %Pro{} = pro} = Novi.update_pro(pro, update_attrs)
    end

    test "update_pro/2 with invalid data returns error changeset" do
      pro = pro_fixture()
      assert {:error, %Ecto.Changeset{}} = Novi.update_pro(pro, @invalid_attrs)
      assert pro == Novi.get_pro!(pro.id)
    end

    test "delete_pro/1 deletes the pro" do
      pro = pro_fixture()
      assert {:ok, %Pro{}} = Novi.delete_pro(pro)
      assert_raise Ecto.NoResultsError, fn -> Novi.get_pro!(pro.id) end
    end

    test "change_pro/1 returns a pro changeset" do
      pro = pro_fixture()
      assert %Ecto.Changeset{} = Novi.change_pro(pro)
    end
  end
end
