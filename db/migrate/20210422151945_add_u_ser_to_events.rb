class AddUSerToEvents < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :user, null: false, foreign_key: true
  end
end
