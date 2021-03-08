class ArticlesController < ApplicationController
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
    @article = Article.new(title: "...", body: "...")

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
end

