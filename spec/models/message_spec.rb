# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:chat_room) { ChatRoom.create!(name: 'Test Room') }
  let(:message) { Message.new(user:, chat_room:) }

  describe 'associations' do
    it 'belongs to user' do
      expect(message).to respond_to(:user)
    end

    it 'belongs to chat_room' do
      expect(message).to respond_to(:chat_room)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(message).to be_valid
    end

    it 'is not valid without a user' do
      message.user = nil
      expect(message).not_to be_valid
    end

    it 'is not valid without a chat_room' do
      message.chat_room = nil
      expect(message).not_to be_valid
    end
  end

  # Replace 'attribute' with the name of the attribute which is being broadcasted to the chat room
  describe 'callbacks' do
    it 'broadcasts to chat room after creation' do
      message = Message.new(user:, chat_room:, content: 'Hello')
      expect(message).to receive(:broadcast_append_to)
      message.save!
    end
  end
end
