class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      puts t.class
      t.string :name
      t.string :age
      t.string :breed
      t.string :favorite_treats
      t.datetime :last_walked_at
      t.datetime :last_fed_at
    end
  end
end
