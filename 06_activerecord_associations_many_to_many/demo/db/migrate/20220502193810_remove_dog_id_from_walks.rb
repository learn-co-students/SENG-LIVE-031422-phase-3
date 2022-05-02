class RemoveDogIdFromWalks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :walks, :dog, foreign_key: true
  end
end
