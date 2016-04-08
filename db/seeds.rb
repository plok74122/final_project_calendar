# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 創造假的可用課程表
start_time = AvailableSection.time_shif_to_half_an_hour('2016-4-09 16:20:00'.to_time , 'after')
end_time = AvailableSection.time_shif_to_half_an_hour('2016-4-09 22:45:00'.to_time , 'before')
z = (end_time - start_time) / 30.minute
section_attr = Array.new

temp_time = start_time
(1..z).each do |n|
  section_attr.push({:start => temp_time, :end => temp_time + 30.minute, :user_id => 1})
  temp_time += 30.minute
end
AvailableSection.bulk_insert do |work|
  section_attr.each do |attr|
    if AvailableSection.where(attr).count==0
      work.add(attr)
    end
  end
end
