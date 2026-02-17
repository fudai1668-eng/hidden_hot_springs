class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @tweets = Tweet.all

    @rank_tweets = Tweet.all.sort do |a, b|
      b.liked_users.count <=> a.liked_users.count
    end

    if params[:tag_ids].present?
      @tweets = []

      params[:tag_ids].each do |key, value|
        if value == "1"
          tag = Tag.find_by(name: key)
          @tweets += tag.tweets if tag
        end
      end

      @tweets.uniq!
    end

    if params[:tag].present?
      Tag.create(name: params[:tag])
    end
  end

  # ✅ ★★★ これを追加 ★★★
 def list
  @tweets = Tweet.all.order(created_at: :desc)

  @rank_tweets = Tweet.all.sort do |a, b|
    b.liked_users.count <=> a.liked_users.count
  end
end


  def show
  @tweet = Tweet.find(params[:id])

  @comments = @tweet.comments
  @comment = Comment.new

  @rank_tweets = Tweet.all.sort do |a, b|
    b.liked_users.count <=> a.liked_users.count
  end
end


  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id

    if tweet.save
      redirect_to tweets_list_path
    else
      render :new
    end
  end

 def destroy
  @tweet = Tweet.find(params[:id])
  @tweet.destroy
  redirect_to user_path(current_user), notice: "投稿を削除しました"
end



  private

  def tweet_params
    params.require(:tweet)
          .permit(:hot_springs, :place, :birth, :explain,
                  :picture, :image, tag_ids: [])
  end
end
