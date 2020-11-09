class PatientDoctorsController < ApplicationController

  def destroy
    hospital = Hospital.find(params[:hospital_id])
    doctor = Doctor.find(params[:id])
    patient_doctor = PatientDoctor.find_by(doctor_id: doctor, patient_id: params[:patient_id])
    patient_doctor.destroy
    redirect_to doctor_path(hospital, doctor)
  end

end
