class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  after_create_commit { broadcast_append_to self.chat_room }
end
