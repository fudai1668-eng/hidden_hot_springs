class AddHotSpringsToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :hot_springs, :string
  end
end
