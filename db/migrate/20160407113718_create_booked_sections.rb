class CreateBookedSections < ActiveRecord::Migration
  def change
    create_table :booked_sections do |t|

      t.integer :user_id
      t.integer :available_section_id
      t.integer :booked_id  #訂單id

      t.timestamps null: false

    end
  end
end
