class AddUserVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.references :user

      t.timestamps
    end
  end
end
