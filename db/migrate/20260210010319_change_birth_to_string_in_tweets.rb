class ChangeBirthToStringInTweets < ActiveRecord::Migration[7.2]
  def change
    change_column :tweets, :birth, :string
  end
end
