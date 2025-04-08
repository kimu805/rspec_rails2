require 'rails_helper'

RSpec.describe Article, type: :model do
  it "記事を正しく作成できる" do
    article = Article.new(title: "RSpecの基本", content: "RSpecを学びましょう")
    expect(article).to be_valid
  end
end
