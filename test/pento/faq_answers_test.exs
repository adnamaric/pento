defmodule Pento.FAQ_answersTest do
  use Pento.DataCase

  alias Pento.FAQ_answers

  describe "answers" do
    alias Pento.FAQ_answers.Answer

    import Pento.FAQ_answersFixtures

    @invalid_attrs %{answer: nil, question_id: nil, user_id: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert FAQ_answers.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert FAQ_answers.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{answer: "some answer", question_id: 42, user_id: 42}

      assert {:ok, %Answer{} = answer} = FAQ_answers.create_answer(valid_attrs)
      assert answer.answer == "some answer"
      assert answer.question_id == 42
      assert answer.user_id == 42
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FAQ_answers.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{answer: "some updated answer", question_id: 43, user_id: 43}

      assert {:ok, %Answer{} = answer} = FAQ_answers.update_answer(answer, update_attrs)
      assert answer.answer == "some updated answer"
      assert answer.question_id == 43
      assert answer.user_id == 43
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = FAQ_answers.update_answer(answer, @invalid_attrs)
      assert answer == FAQ_answers.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = FAQ_answers.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> FAQ_answers.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = FAQ_answers.change_answer(answer)
    end
  end
end
