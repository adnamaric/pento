defmodule PentoWeb.AnswerLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pento.FAQ_answersFixtures

  @create_attrs %{answer: "some answer", question_id: 42, user_id: 42}
  @update_attrs %{answer: "some updated answer", question_id: 43, user_id: 43}
  @invalid_attrs %{answer: nil, question_id: nil, user_id: nil}

  defp create_answer(_) do
    answer = answer_fixture()
    %{answer: answer}
  end

  describe "Index" do
    setup [:create_answer]

    test "lists all answers", %{conn: conn, answer: answer} do
      {:ok, _index_live, html} = live(conn, Routes.answer_index_path(conn, :index))

      assert html =~ "Listing Answers"
      assert html =~ answer.answer
    end

    test "saves new answer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.answer_index_path(conn, :index))

      assert index_live |> element("a", "New Answer") |> render_click() =~
               "New Answer"

      assert_patch(index_live, Routes.answer_index_path(conn, :new))

      assert index_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#answer-form", answer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.answer_index_path(conn, :index))

      assert html =~ "Answer created successfully"
      assert html =~ "some answer"
    end

    test "updates answer in listing", %{conn: conn, answer: answer} do
      {:ok, index_live, _html} = live(conn, Routes.answer_index_path(conn, :index))

      assert index_live |> element("#answer-#{answer.id} a", "Edit") |> render_click() =~
               "Edit Answer"

      assert_patch(index_live, Routes.answer_index_path(conn, :edit, answer))

      assert index_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#answer-form", answer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.answer_index_path(conn, :index))

      assert html =~ "Answer updated successfully"
      assert html =~ "some updated answer"
    end

    test "deletes answer in listing", %{conn: conn, answer: answer} do
      {:ok, index_live, _html} = live(conn, Routes.answer_index_path(conn, :index))

      assert index_live |> element("#answer-#{answer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#answer-#{answer.id}")
    end
  end

  describe "Show" do
    setup [:create_answer]

    test "displays answer", %{conn: conn, answer: answer} do
      {:ok, _show_live, html} = live(conn, Routes.answer_show_path(conn, :show, answer))

      assert html =~ "Show Answer"
      assert html =~ answer.answer
    end

    test "updates answer within modal", %{conn: conn, answer: answer} do
      {:ok, show_live, _html} = live(conn, Routes.answer_show_path(conn, :show, answer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Answer"

      assert_patch(show_live, Routes.answer_show_path(conn, :edit, answer))

      assert show_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#answer-form", answer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.answer_show_path(conn, :show, answer))

      assert html =~ "Answer updated successfully"
      assert html =~ "some updated answer"
    end
  end
end
