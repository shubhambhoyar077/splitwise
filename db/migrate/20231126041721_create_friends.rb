class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.reference :user
      t.integer :friend_id

      t.timestamps
    end
  end
end
