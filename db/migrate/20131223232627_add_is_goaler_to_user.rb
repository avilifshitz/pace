class AddIsGoalerToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_goaler, :boolean, :default => false
  end
end
