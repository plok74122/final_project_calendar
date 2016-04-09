class BookedSection < ActiveRecord::Base
  belongs_to :available_section
end
