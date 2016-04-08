class CreateBookedSections < ActiveRecord::Migration
  def change
    create_table :booked_sections do |t|

      t.integer :user_id
      t.integer :available_sections_id

      t.timestamps null: false

    end
  end
end
