class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews, id: :uuid do |t|
      t.references :product, type: :uuid, foreign_key: true

      t.string :author, null: false
      t.integer :rating, null: false
      t.string :headline, null: false
      t.string :body

      t.timestamps
    end
  end
end
