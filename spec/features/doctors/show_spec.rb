require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe "when I visit a doctor's show page" do
    it "I see the doctor's name, specialty, university, hospital, and patients" do
      hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")

      doctor_1 = hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery",
                                university: "Harvard University")
      doctor_2 = hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery",
                                university: "Johns Hopkins University")
      doctor_3 = hospital_2.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery",
                                university: "Stanford University")

      patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
      patient_2 = Patient.create!(name: "Rebecca Pope", age: 32)
      patient_3 = Patient.create!(name: "Zola Shepherd", age: 2)
      patient_4 = Patient.create!(name: "Denny Duquette", age: 44)

      doctor_1.patients << patient_1
      doctor_1.patients << patient_2
      doctor_2.patients << patient_3
      doctor_3.patients << patient_4
      doctor_3.patients << patient_1

      visit "/hospitals/#{hospital.id}/doctors/#{doctor_1.id}"

      within ".hospital" do
        expect(page).to have_content(hospital.name)
      end

      within ".doctor-info" do
        expect(page).to have_content(doctor_1.name)
        expect(page).to have_content(doctor_1.specialty)
        expect(page).to have_content(doctor_1.university)
        expect(page).to_not have_content(doctor_2.name)
        expect(page).to_not have_content(doctor_2.specialty)
        expect(page).to_not have_content(doctor_2.university)
      end

      within ".patient-caseload" do
        expect(page).to have_content(patient_1.name)
        expect(page).to have_content(patient_2.name)
      end

    end
  end
end