class TeacherCalendarsController < ApplicationController
  protect_from_forgery :except => :create
  before_action :set_available_section, :only => [:create]

  def index

  end

  def fullcalendar
  end

  def create
    start_time = AvailableSection.time_shif_to_half_an_hour(@availabele_section_params[:start].to_time, 'after')
    end_time = AvailableSection.time_shif_to_half_an_hour(@availabele_section_params[:end].to_time, 'before')
    z = (end_time - start_time) / 30.minute
    section_attr = Array.new
    temp_time = start_time
    (1..z).each do |n|
      section_attr.push({:start => temp_time, :end => temp_time + 30.minute, :user_id => 1})
      temp_time += 30.minute
    end
    @return_insert_sections = Array.new
    section_attr.each do |attr|
      if AvailableSection.where(attr).count==0
        @return_insert_sections << AvailableSection.create(attr)
      end
    end
    respond_to do |format|
      format.json { render :json => @return_insert_sections.to_json }
    end
  end

  def teacher_available_section
    @teacher_calendar = AvailableSection.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @teacher_calendar.to_xml }
      format.json { render :json => @teacher_calendar.to_json }
    end
  end

  def student_booked_section
    booked_calendar_temp = BookedSection.select('booked_sections.id,min(available_sections.start) as start,max(available_sections.end) as end').joins(:available_section).group('booked_sections.booked_id')
    @booked_calendar = Array.new
    booked_calendar_temp.each do |booked|
      # @booked_calendar << {:id => booked.id , :start => Time.zone.parse(booked.start) , :end => Time.zone.parse(booked.end)}
      @booked_calendar << {:id => booked.id, :start => DateTime.parse(booked.start).to_time, :end => DateTime.parse(booked.end).to_time}

    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @booked_calendar.to_xml }
      format.json { render :json => @booked_calendar.to_json }
    end
  end

  def insert
    start_time = AvailableSection.time_shif_to_half_an_hour('2016-4-10 16:20:00'.to_time, 'after')
    end_time = AvailableSection.time_shif_to_half_an_hour('2016-4-10 19:45:00'.to_time, 'before')
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

  private

  def set_available_section
    @availabele_section_params =params.permit(:start, :end)
  end
end
