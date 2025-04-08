require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "アソシエーションのテスト" do
    before do
      @article = Article.create(title: "RSpecの基本", content: "RSpecを学びましょう。")

      @comment_1 = Comment.create(content: "良い記事ですね！", article: @article)
      @comment_2 = Comment.create(content: "分かりやすいです！", article: @article)
    end

    it "コメントを関連付けられる" do
      expect(@article.comments).to include(@comment_1, @comment_2)
    end

    it "記事に属していることを確認する" do
      expect(@comment_1.article).to eq(@article)
    end
  end
end
