require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:title) { "RSpecの基本" }
  let(:content) { "RSpecを学びましょう。楽しいですよ！" }

  describe "#comments_count" do
    before do
      @article = Article.create(title: title, content: content)
    end

    context "紐づくコメントがある場合" do
      it "コメントの数を正しく返す" do
        @article.comments.create(content: "hogehogehoge")
        @article.comments.create(content: "fugafugafuga")

        expect(@article.comments_count).to eq(2)
      end
    end

    context "紐づくコメントがない場合" do
      it "0を返す" do
        expect(@article.comments_count).to eq(0)
      end
    end
  end
end
