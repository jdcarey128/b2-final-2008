class CreatePatientDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_doctors do |t|
      t.references :patient, foreign_key: true
      t.references :doctor, foreign_key: true
    end
  end
end
