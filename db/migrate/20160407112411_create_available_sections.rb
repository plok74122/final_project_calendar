class CreateAvailableSections < ActiveRecord::Migration
  def change
    create_table :available_sections do |t|

      t.integer :user_id , :index

      t.datetime :start
      t.datetime :end

      t.timestamps null: false

    end
  end
end
