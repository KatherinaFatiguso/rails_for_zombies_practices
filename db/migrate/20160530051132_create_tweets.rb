class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :zombie, index: true, foreign_key: true
      t.text :status

      t.timestamps null: false
    end
  end
end
