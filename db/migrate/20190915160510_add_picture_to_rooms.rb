class AddPictureToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :picture, :string
  end
end
