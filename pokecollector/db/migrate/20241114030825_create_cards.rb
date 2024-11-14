class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :card_name
      t.string :card_type
      t.string :card_image
      t.string :set
      t.float :card_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
