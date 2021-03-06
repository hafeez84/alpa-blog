class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show, :search]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page:5)
  end
  
  def new
    @article = Article.new
    @image = ImageUploader.new
  end
  
  def create
    # debugger #for debuggin porpuse in the server terminal. to see what has been passed on
    @article = Article.new(article_params)
    @image = params[:image]
    @article.user = current_user if logged_in?# ///
    if @article.save
      flash[:success] = "Article was created succesfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated succesfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was deleted..."
    redirect_to articles_path
  end

  def search
    if params[:s].blank?
      flash.now[:danger] = "You have entered an empty string !"
    else
      @objs = Article.search(params[:s])
      flash.now[:danger] = "No results match your search criteria, please try again" if @objs.blank?
    end
    # render json: @objs
    render partial: 'shared/results'
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description, :image, category_ids: [])
  end
  
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit your own articles !"
      redirect_to articles_path
    end
  end
  
end
