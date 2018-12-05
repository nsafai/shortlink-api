class AddNumberOfClicksToShortlinks < ActiveRecord::Migration[5.2]
  def change
    add_column :shortlinks, :clicks, :integer
  end
end
