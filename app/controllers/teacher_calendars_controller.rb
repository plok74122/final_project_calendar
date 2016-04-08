class TeacherCalendarsController < ApplicationController
  def index

  end

  def insert
    start_time = '2016-4-10 16:00:00'.to_time
    end_time = '2016-4-10 18:00:00'.to_time
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
  end
end
