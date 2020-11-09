require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe "when I visit a hospital's show page" do
    it "I see the hospital name, number of doctors at hospital, and a unique list of universities the doctor's attend" do
      hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

      doctor_1 = hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery",
                                university: "Harvard University")
      doctor_2 = hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery",
                                university: "Johns Hopkins University")
      doctor_3 = hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery",
                                university: "Stanford University")
      doctor_4 = hospital.doctors.create!(name: "Derek Shepherd", specialty: "Attending Surgeon",
                                university: "Harvard University")

      visit hospital_path(hospital)

      within ".hospital-info" do
        expect(page).to have_content(hospital.name)
      end

      within ".doctors" do
        expect(page).to have_content(4)
      end

      within ".doctor-universities" do
        expect(page).to have_css('li', count:3)
        expect(page).to have_content(doctor_1.university)
        expect(page).to have_content(doctor_2.university)
        expect(page).to have_content(doctor_3.university)
      end

    end
  end
end
