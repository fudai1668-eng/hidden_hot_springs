class TagsController < ApplicationController
   def index
        @tags = Tag.all
    end
    def new
    @tag = Tag.new
  end

  def create
    tag = Tag.new(tag_params)
    if tag.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end

