class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.datetime :from
      t.datetime :to
      t.references :user

      t.timestamps
    end
  end
end
