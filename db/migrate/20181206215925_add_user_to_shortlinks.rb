class AddUserToShortlinks < ActiveRecord::Migration[5.2]
  def change
    add_reference :shortlinks, :user, foreign_key: true, optional: true
  end
end
