class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  # コメント作成
  def create
    @comment = @tweet.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "コメントしました"
    else
      flash[:alert] = "コメントできませんでした"
    end
    redirect_back(fallback_location: tweet_path(@tweet))
  end

  # コメント削除
  def destroy
    @comment = Comment.find(params[:id])  
    @tweet = @comment.tweet 
    @comment.destroy 
    flash[:success] = "コメントを削除しました" 
    redirect_back(fallback_location: tweet_path(@tweet))
  end

  private

  # ツイートを取得
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  # コメントを取得
  def set_comment
    @comment = @tweet.comments.find(params[:id])
  end

  # 投稿者本人か確認
  def correct_user
    unless @comment.user == current_user
      flash[:alert] = "他人のコメントは削除できません"
      redirect_back(fallback_location: tweet_path(@tweet))
    end
  end

  # Strong Parameters
  def comment_params
    params.require(:comment).permit(:content)
  end
end
