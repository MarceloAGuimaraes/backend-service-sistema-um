class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :neighborhood
      t.string :street
      t.string :uf
      t.string :zip_code
      t.string :lat
      t.string :long
      t.belongs_to :request
      t.timestamps
    end
  end
end
