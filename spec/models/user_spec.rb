require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){FactoryBot.create :user, email: "test@test.com", password: "123123"}
  subject { user }
  
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should be_valid }
  
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value("example@domain.com").for(:email) }
end
