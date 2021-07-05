class CreateUserFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_feedbacks do |t|
      t.text :comment
      t.integer :rating
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
