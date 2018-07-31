class CommentsController < ApplicationController
	before_action :comment_params, except: [:destroy]
	before_action :set_article, :require_user

	def create
		@comment = @art.comments.new comment_params
		@comment.user = current_user
		if @comment.save
			flash[:success] = "Your comment has been successfully created !"
			redirect_to @art
		else
			flash[:danger] = "There was an error creating your commet please try again !"
			redirect_to @art
		end
	end

	def destroy
		@comment = @art.comments.find(params[:id])
		@comment.destroy
		flash[:danger] = "Your comment have been deleted !"
		redirect_to @art
	end


	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def set_article
		@art = Article.find(params[:article_id])
	end

end