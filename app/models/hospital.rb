class Hospital < ApplicationRecord
  has_many :doctors


  def doctor_count
    self.doctors.count
  end
end
