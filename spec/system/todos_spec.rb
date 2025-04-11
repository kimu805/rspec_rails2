require "rails_helper"

RSpec.describe "Todo管理", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "Todo一覧を表示する" do
    Todo.create!(title: "testTodo", description: "これはテストTodoの説明です。")
    visit todos_path
    expect(page).to have_content("Todo一覧")
    expect(page).to have_content("testTodo")
    expect(page).to have_content("これはテストTodoの説明です。")
    expect(page).to have_content("未完了")
  end
end
