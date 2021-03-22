class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  # The new action instantiates a new article, but does not save it.
  # This article will be used in the view when building the form
  def new
    @article = Article.new
  end

  # this is called as a traditional post that causes a page refresh or a redirect
  def create
    @article = Article.new(article_params)

    if @article.save
      # redirect_to will cause the browser to make a new request,
      # whereas render renders the specified view for the current 
      # request. It is important to use redirect_to after mutating 
      # the database or application state. Otherwise, if the user 
      # refreshes the page, the browser will make the same request,
      # and the mutation will be repeated.
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
