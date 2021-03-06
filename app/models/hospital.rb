class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors

  def doctor_count
    self.doctors.count
  end

  def distinct_universities
    self.doctors.distinct.pluck(:university)
  end

  def ordered_patients
    self.patients.order(age: :desc).distinct
  end
end
