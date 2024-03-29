class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :user_name
      t.references :event, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
