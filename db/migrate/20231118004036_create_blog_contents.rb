class CreateBlogContents < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_contents do |t|
      t.references :user, foreign_key: { to_table: :users}
      t.string :title 
      t.text :body
      t.timestamps
    end
  end
end
