require 'rails_helper'

RSpec.describe PatientDoctor do
  describe 'relationships' do
    it {should belong_to :doctor}
    it {should belong_to :patient}
  end
end
