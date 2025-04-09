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

  describe "POST /articles" do
    context "有効なパラメーターの場合" do
      it "記事を作成できる" do
        expect {
          post "/articles", params: {
            article: {
              title: "新しい記事",
              content: "この記事は新しく作成されました。"
            }
          }
        }.to change(Article, :count).by(1)

        expect(response).to have_http_status(201)

        json = JSON.parse(response.body)
        expect(json["title"]).to eq("新しい記事")
        expect(json["content"]).to eq("この記事は新しく作成されました。")
      end
    end

    context "無効なパラメーターである場合" do
      it "記事を作成できない" do
        expect {
          post "/articles", params: {
            article: {
              title: "",
              content: ""
            }
          }
        }.not_to change(Article, :count)

        json = JSON.parse(response.body)
        expect(json["title"].first).to include("blank")
        expect(json["content"].first).to include("blank")
        expect(json["content"].second).to include("short")
      end
    end
  end
end
