class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      # creates the self-referential relationship
      t.references :friend, references: :users, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
