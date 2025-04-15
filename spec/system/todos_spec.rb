require "rails_helper"

RSpec.describe "Todo管理", type: :system do
  describe "CRUD機能" do
    before do
      driven_by(:rack_test)
    end

    context "一覧機能" do
      it "Todo一覧を表示する" do
        Todo.create!(title: "testTodo", description: "これはテストTodoの説明です。")
        visit todos_path
        expect(page).to have_content("Todo一覧")
        expect(page).to have_content("testTodo")
        expect(page).to have_content("これはテストTodoの説明です")
        expect(page).to have_content("未完了")
      end
    end

    context "新規作成機能" do
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

      it "説明が10文字未満の場合、エラーメッセージが表示される" do
        visit new_todo_path

        fill_in "タイトル", with: "テストTodo"
        fill_in "説明", with: "短すぎ"

        click_button "作成"
        expect(page).to have_content("Description is too short (minimum is 10 characters)")
      end

      it "エラー後、正しい入力で登録できる" do
        visit new_todo_path

        click_button "作成"
        expect(page).to have_content("Title can't be blank")

        fill_in "タイトル", with: "RSpecを学ぶ"
        fill_in "説明", with: "システムスペックについて理解を深める"
        click_button "作成"

        expect(current_path).to eq(todos_path)
        expect(page).to have_content("RSpecを学ぶ")
        expect(page).to have_content("システムスペックについて理解を深める")
      end
    end

    context "編集機能" do
      before do
        @todo = Todo.create(title: "テスト駆動開発", description: "アプリケーションをテスト駆動で実装する")
      end

      it "Todoを編集できる" do
        visit todos_path
        click_link "編集"

        fill_in "タイトル", with: "RSpec入門"
        fill_in "説明", with: "システムスペックについて理解を深める"
        click_button "更新"

        expect(current_path).to eq(todos_path)
        expect(page).to have_content("RSpec入門")
        expect(page).to have_content("システムスペックについて理解を深める")
      end

      it "編集画面で不正な値を入力するとエラーメッセージが表示される" do
        visit edit_todo_path(@todo)
        fill_in "タイトル", with: ""
        fill_in "説明", with: "短すぎ"

        click_button "更新"

        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Description is too short (minimum is 10 characters)")
      end
    end
  end

  describe "javaScript" do
    before do
      driven_by(:selenium_chrome_headless)
    end

    describe "javascriptの動作確認" do
      it "ボタンをクリックするとテキストの表示/非表示が切り替わる" do
        visit todos_path

        expect(page).to have_selector("#js_text", visible: false)
        expect(page).not_to have_content("こんにちは！")

        click_button "クリックしてね"
        expect(page).to have_selector("#js_text", visible: true)
        expect(page).to have_content("こんにちは！")

        click_button "クリックしてね"
        expect(page).to have_selector("#js_text", visible: false)
        expect(page).not_to have_content("こんにちは！")
      end
    end
  end
end
