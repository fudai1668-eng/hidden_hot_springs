class RemoveSpringsFromTweets < ActiveRecord::Migration[7.2]
  def change
    remove_column :tweets, :springs, :string
  end
end
