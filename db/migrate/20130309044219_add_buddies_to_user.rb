class AddBuddiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :buddy_one_id, :int
    add_column :users, :buddy_two_id, :int
  end
end
