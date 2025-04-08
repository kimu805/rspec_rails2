require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { article.valid? }
  let(:title) { "RSpecの基本" }
  let(:content) { "RSpecを学びましょう。楽しいですよ！" }
  let(:article) { Article.new(title: title, content: content) }

  context "正常系" do
    it "タイトルとコンテンツがあれば有効" do
      expect(subject).to be true
    end
  end

  context "異常系" do
    context "タイトルがない場合" do
      let(:title) { nil }
      it "無効である" do
      expect(subject).not_to be true
      end
    end
    context "コンテンツがない場合" do
      let(:content) { nil }
      it "無効である" do
        expect(subject).not_to be true
      end
    end
    context "コンテンツが10文字未満の場合" do
      let(:content) { "123456789" }
      it "無効である" do
        expect(subject).not_to be true
      end
    end
  end
end
