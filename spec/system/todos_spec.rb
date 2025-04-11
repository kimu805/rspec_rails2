require "rails_helper"

RSpec.describe "Todo管理", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "正常系" do
    it "Todo一覧を表示する" do
      Todo.create!(title: "testTodo", description: "これはテストTodoの説明です。")
      visit todos_path
      expect(page).to have_content("Todo一覧")
      expect(page).to have_content("testTodo")
      expect(page).to have_content("これはテストTodoの説明です。")
      expect(page).to have_content("未完了")
    end

    it "新規Todoを作成できる" do
      visit new_todo_path

      fill_in "タイトル", with: "RSpecを学ぶ"
      fill_in "説明", with: "システムスペックについて理解を深める"

      click_button "作成"

      expect(current_path).to eq(todos_path)

      expect(page).to have_content("RSpecを学ぶ")
      expect(page).to have_content("システムスペックについて理解を深める")
    end
  end

  context "バリデーション" do
    it "タイトルと説明が未入力の場合、エラーメッセージが表示される" do
      visit new_todo_path

      click_button "作成"
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end
end
