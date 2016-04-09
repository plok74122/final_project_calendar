class TeacherCalendarsController < ApplicationController
  def index

  end

  def fullcalendar
  end

  def teacher_available_section
    @teacher_calendar = AvailableSection.all()
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @teacher_calendar.to_xml }
      format.json { render :json => @teacher_calendar.to_json }
    end
  end

  def insert
    start_time = AvailableSection.time_shif_to_half_an_hour('2016-4-10 16:20:00'.to_time , 'after')
    end_time = AvailableSection.time_shif_to_half_an_hour('2016-4-10 19:45:00'.to_time , 'before')
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
