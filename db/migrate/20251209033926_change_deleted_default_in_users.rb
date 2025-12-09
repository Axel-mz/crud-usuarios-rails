class ChangeDeletedDefaultInUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :deleted, 0
  end
end
