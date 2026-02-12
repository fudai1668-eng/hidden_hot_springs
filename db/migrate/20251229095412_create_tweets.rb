class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :hot
      t.string :springs
      t.string :place
      t.integer :birth
      t.text :explain
      t.string :picture

      t.timestamps
    end
  end
end
