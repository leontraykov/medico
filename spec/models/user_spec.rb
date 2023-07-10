# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: 'test@example.com', password: 'password') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create!(name: 'duplicate', email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
    end

    it 'assigns a default name if none is provided' do
      user.save!
      expect(user.name).to match(/Болтун #\d{1,3}/)
    end
  end

  describe 'callbacks' do
    it 'does not overwrite an existing name' do
      user.name = 'Existing name'
      user.save!
      expect(user.name).to eq('Existing name')
    end

    it 'sets a default name if none is provided' do
      user.save!
      expect(user.name).to match(/Болтун #\d{1,3}/)
    end
  end
end
