require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "記事一覧ページの表示に成功する" do
      get "/articles"
      expect(response).to have_http_status(200)
    end
  end
end
