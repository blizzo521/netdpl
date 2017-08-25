class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.string :thumbnail
      t.string :author
      t.string :summary

      t.timestamps
    end
  end
end
