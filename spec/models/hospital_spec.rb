require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe 'relationships' do
    it {should have_many :doctors}
    it {should have_many(:patients).through(:doctors)}
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

    describe '#distinct_universities' do
      before :each do
        @hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

        @doctor_1 = @hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery",
                                  university: "Harvard University")
        @doctor_2 = @hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery",
                                  university: "Johns Hopkins University")
        @doctor_3 = @hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery",
                                  university: "Stanford University")
        @expected_list = ["Harvard University", "Johns Hopkins University", "Stanford University"]
      end

      it 'should return a list of university names of doctors who work at hosptial' do
        expect(@hospital.distinct_universities.sort).to eq(@expected_list.sort)
      end

      it 'should only return doctor universities of hospital' do
        @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")

        @doctor_4 = @hospital_2.doctors.create!(name: "Derek Shepherd", specialty: "Attending Surgeon",
                                  university: "Creighton University")

        @expected_list_2 = ["Creighton University"]
        expect(@hospital.distinct_universities.sort).to eq(@expected_list.sort)
        expect(@hospital_2.distinct_universities.sort).to eq(@expected_list_2.sort)
      end

      it 'should return a distinct list of doctor universities' do
        @doctor_4 = @hospital.doctors.create!(name: "Derek Shepherd", specialty: "Attending Surgeon",
                                  university: "Harvard University")
        @doctor_5 = @hospital.doctors.create!(name: "Harold Washington", specialty: "General Surgeon",
                                  university: "Stanford University")

        expect(@hospital.distinct_universities.sort).to eq(@expected_list.sort)
        expect(@hospital.distinct_universities.count).to eq(3)
      end

    end
  end
end
