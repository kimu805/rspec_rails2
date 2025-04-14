require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:title) { "RSpecの基本" }
  let(:content) { "RSpecを学びましょう。楽しいですよ" }
  subject { Article.new(title: title, content: content) }

  describe "validation" do
    context "正常系" do
      it "タイトルとコンテンツがあれば有効" do
        expect(subject).to be_valid
      end
    end

    context "異常系" do
      context "タイトルがない場合" do
        let(:title) { nil }
        it "無効である" do
          expect(subject).not_to be_valid
        end
      end
      context "コンテンツがない場合" do
        let(:content) { nil }
        it "無効である" do
          expect(subject).not_to be_valid
        end
      end
      context "コンテンツが10文字より少ない場合" do
        let(:content) { "123456789" }
        it "無効である" do
          expect(subject).not_to be_valid
        end
      end
    end
  end

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
