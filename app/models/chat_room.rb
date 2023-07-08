class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :delete_all
  has_many :users, through: :chat_room_users
  has_many :messages, dependent: :delete_all

  validates :name, presence: true, uniqueness: true

  after_create_commit {broadcast_append_to "chat_rooms"}
end
