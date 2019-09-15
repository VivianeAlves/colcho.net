class AddCounterCacheToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :reviews_count, :integer
  end
end
