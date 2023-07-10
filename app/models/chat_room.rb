# frozen_string_literal: true

class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :delete_all
  has_many :users, through: :chat_room_users
  has_many :messages, dependent: :delete_all

  validates :name, presence: true, uniqueness: true
  before_validation :set_name, on: :create

  after_create_commit { broadcast_append_to 'chat_rooms' }

  private

  def set_name
    self.name = "Болталка ##{rand(999)}" if name.blank?
  end
end
