require 'rails_helper'

RSpec.describe Article, type: :model do
  context "正常系" do
    it "タイトルとコンテンツがあれば有効" do
      article = Article.new(title: "RSpecの基本", content: "RSpecを学びましょう。楽しいですよ！")
      expect(article).to be_valid
    end
  end

  context "異常系" do
  end
end
