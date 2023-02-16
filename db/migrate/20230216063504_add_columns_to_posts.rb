class AddColumnsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :genre, foreign_key: true
    add_reference :posts, :label, foreign_key: true
    add_reference :posts, :user, foreign_key: true
  end
end
