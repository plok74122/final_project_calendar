class BookedSection < ActiveRecord::Base
  has_one :available_section
end
