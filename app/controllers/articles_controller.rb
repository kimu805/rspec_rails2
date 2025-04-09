class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created # 201
    else
      render json: @article.errors, status: :unprocessable_entity # 422
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
