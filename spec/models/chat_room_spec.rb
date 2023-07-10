# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  let(:chat_room) { ChatRoom.new(name: 'Test Room') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(chat_room).to be_valid
    end

    it 'is not valid without a unique name' do
      duplicate_room = chat_room.dup
      chat_room.save
      expect(duplicate_room).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'sets a default name if none is provided' do
      chat_room.name = nil
      chat_room.valid? # will trigger the set_name callback
      expect(chat_room.name).to match(/Болталка #\d{1,3}/)
    end
  end
end
