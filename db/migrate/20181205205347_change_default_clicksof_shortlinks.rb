class ChangeDefaultClicksofShortlinks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :shortlinks, :clicks, 0
  end
end
