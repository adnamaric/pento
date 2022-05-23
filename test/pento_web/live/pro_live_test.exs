defmodule PentoWeb.ProLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pento.NoviFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_pro(_) do
    pro = pro_fixture()
    %{pro: pro}
  end

  describe "Index" do
    setup [:create_pro]

    test "lists all prod", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.pro_index_path(conn, :index))

      assert html =~ "Listing Prod"
    end

    test "saves new pro", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.pro_index_path(conn, :index))

      assert index_live |> element("a", "New Pro") |> render_click() =~
               "New Pro"

      assert_patch(index_live, Routes.pro_index_path(conn, :new))

      assert index_live
             |> form("#pro-form", pro: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pro-form", pro: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_index_path(conn, :index))

      assert html =~ "Pro created successfully"
    end

    test "updates pro in listing", %{conn: conn, pro: pro} do
      {:ok, index_live, _html} = live(conn, Routes.pro_index_path(conn, :index))

      assert index_live |> element("#pro-#{pro.id} a", "Edit") |> render_click() =~
               "Edit Pro"

      assert_patch(index_live, Routes.pro_index_path(conn, :edit, pro))

      assert index_live
             |> form("#pro-form", pro: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pro-form", pro: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_index_path(conn, :index))

      assert html =~ "Pro updated successfully"
    end

    test "deletes pro in listing", %{conn: conn, pro: pro} do
      {:ok, index_live, _html} = live(conn, Routes.pro_index_path(conn, :index))

      assert index_live |> element("#pro-#{pro.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pro-#{pro.id}")
    end
  end

  describe "Show" do
    setup [:create_pro]

    test "displays pro", %{conn: conn, pro: pro} do
      {:ok, _show_live, html} = live(conn, Routes.pro_show_path(conn, :show, pro))

      assert html =~ "Show Pro"
    end

    test "updates pro within modal", %{conn: conn, pro: pro} do
      {:ok, show_live, _html} = live(conn, Routes.pro_show_path(conn, :show, pro))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pro"

      assert_patch(show_live, Routes.pro_show_path(conn, :edit, pro))

      assert show_live
             |> form("#pro-form", pro: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#pro-form", pro: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_show_path(conn, :show, pro))

      assert html =~ "Pro updated successfully"
    end
  end
end
