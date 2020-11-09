require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit a patient index page' do
    it "I see a list of the hospital's patient names from oldest to youngest" do
      @hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

      @doctor_1 = @hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery",
                                university: "Harvard University")
      @doctor_2 = @hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery",
                                university: "Johns Hopkins University")
      @doctor_3 = @hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery",
                                university: "Stanford University")

      @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
      @patient_2 = Patient.create!(name: "Rebecca Pope", age: 32)
      @patient_3 = Patient.create!(name: "Zola Shepherd", age: 2)
      @patient_4 = Patient.create!(name: "Denny Duquette", age: 44)

      @doctor_1.patients << @patient_1
      @doctor_1.patients << @patient_2
      @doctor_2.patients << @patient_3
      @doctor_3.patients << @patient_4
      @doctor_3.patients << @patient_1

      visit patients_path(@hospital)

      within '.patients' do
        expect(page.all('li')[0]).to have_content(@patient_4.name)
        expect(page.all('li')[1]).to have_content(@patient_2.name)
        expect(page.all('li')[2]).to have_content(@patient_1.name)
        expect(page.all('li')[3]).to have_content(@patient_3.name)
      end

    end
  end
end
