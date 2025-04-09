class AddBodyToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :body, :text
  end
end 