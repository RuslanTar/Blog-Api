class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update delete]

  # get '/articles'
  def index
    @articles = Article.all
    render json: @articles, each_serializer: ArticlesSerializer, status: :ok
  end

  # get '/articles/:id'
  def show
    render json: @article, status: :ok
  end

  # post '/create-article'
  def create
    @article = Article.new(permitted_parameters)
    if @article.save
      render json: @article, status: :ok
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # put '/edit-article/:id'
  def update
    if @article.update(permitted_parameters)
      render json: @article, status: :ok
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # delete '/articles/:id'
  def delete
    if @article.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def permitted_parameters
    params.permit(:title, :body)
  end

end
