class CreatePostlabels < ActiveRecord::Migration[6.1]
  def change
    create_table :postlabels do |t|
      t.references :post, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
