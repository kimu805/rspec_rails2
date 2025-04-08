require 'rails_helper'

RSpec.describe Article, type: :model do
  context "正常系" do
    it "タイトルとコンテンツがあれば有効" do
      article = Article.new(title: "RSpecの基本", content: "RSpecを学びましょう。楽しいですよ！")
      expect(article).to be_valid
    end
  end

  context "異常系" do
    it "タイトルがなければ無効" do
      article = Article.new(title: nil, content: "RSpecを学びましょう。楽しいですよ！")
      expect(article).not_to be_valid
    end
    it "コンテンツがなければ無効" do
      article = Article.new(title: "RSpecの基本", content: nil)
      expect(article).not_to be_valid
    end
    it "コンテンツが10文字未満なら無効" do
      article = Article.new(title: "RSpecの基本", content: "短い")
      expect(article).not_to be_valid
    end
  end
end
