require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe 'relationships' do
    it {should have_many :doctors}
  end

  describe 'instance methods' do
    describe '#doctor_count' do
      before :each do
        @hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

        @doctor_1 = @hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery",
                                  university: "Harvard University")
        @doctor_2 = @hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery",
                                  university: "Johns Hopkins University")
        @doctor_3 = @hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery",
                                  university: "Stanford University")
      end

      it 'should return a count of doctors for a hospital' do
        expect(@hospital.doctor_count).to eq(3)
      end

      it 'should return a count of doctors only for one hospital' do
        @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")

        @doctor_4 = @hospital_2.doctors.create!(name: "Derek Shepherd", specialty: "Attending Surgeon",
                                  university: "Harvard University")

        expect(@hospital.doctor_count).to eq(3)
        expect(@hospital_2.doctor_count).to eq(1)
      end
    end
  end
end
