class CreateShortlinks < ActiveRecord::Migration[5.2]
  def change
    create_table :shortlinks do |t|
      t.string :short_url
      t.string :long_url

      t.timestamps
    end
    add_index :shortlinks, :short_url, unique: true
  end
end
