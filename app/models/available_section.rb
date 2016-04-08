class AvailableSection < ActiveRecord::Base
  has_one :booked_section
end
