require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    before do
      @article1 = Article.create(title: "最初の記事", content: "最初の記事の本文です。")
      @article2 = Article.create(title: "2番目の記事", content: "2番目の記事の本文です。")
    end

    it "全ての記事を取得できる" do
      get "/articles"
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json.first["title"]).to eq("最初の記事")
      expect(json.second["title"]).to eq("2番目の記事")
    end
  end
end
