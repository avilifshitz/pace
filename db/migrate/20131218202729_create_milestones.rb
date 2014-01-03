class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.datetime :from
      t.datetime :to
      t.references :goal

      t.timestamps
    end
  end
end
