class PatientsController < ApplicationController

  def index
    hospital = Hospital.find(params[:hospital_id])
    @patients = hospital.ordered_patients
  end

end
