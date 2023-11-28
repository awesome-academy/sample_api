class CreateModel < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :email
      t.timestamps
    end

    create_table :articles do |t|
      t.string :title
      t.string :content
      t.integer :author_id

      t.timestamps
    end

    create_table :comments do |t|
      t.string :body
      t.integer :article_id
      t.integer :author_id
      t.timestamps
    end
  end
end
