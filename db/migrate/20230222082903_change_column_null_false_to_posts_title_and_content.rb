class ChangeColumnNullFalseToPostsTitleAndContent < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :title, :string, null: false
    change_column :posts, :content, :text, null: false
  end
end
