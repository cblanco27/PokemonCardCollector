require 'rails_helper'

RSpec.describe User, type: :model do  
  context 'Should validate' do
    it 'with valid fields' do
      @user = User.create!(first_name: 'Test', last_name: 'User', email: 'testEmail@email.com', password: '123456', password_confirmation: '123456')
      expect(@user).to be_valid 
    end
  end
  
  context 'Should not validate' do
    it 'throws error with no first_name is given' do
      expect {
        User.create!(first_name: '', last_name: 'User', email: 'testEmail@email.com', password: '123456', password_confirmation: '123456')
      }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: First name can't be blank/)
    end

    it 'throws an when a dupulicate emaial is provided' do
      @user = User.create!(first_name: 'Test', last_name: 'User', email: 'testEmail@email.com', password: '123456', password_confirmation: '123456')
      # create a new user with a duplicate email
      expect {
        User.create!(first_name: 'New-test', last_name: 'User', email: 'testEmail@email.com', password: '123456', password_confirmation: '123456')
      }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Email has already been taken/)
    end
    
    it 'throws an error when password does not meet criteria - too short' do
      expect {
        User.create!(first_name: 'New-test', last_name: 'User', email: 'testEmail@email.com', password: '1234', password_confirmation: '1234')
      }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Password is too short/)
    end
  end
end
