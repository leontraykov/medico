# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :nullify
  has_many :chat_rooms, through: :chat_room_users

  validates :name, :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :set_name, on: :create
  scope :without_me, ->(user) { where.not(id: user) }

  after_create_commit { broadcast_append_to 'users' }

  private

  def set_name
    self.name = "Болтун ##{rand(999)}" if name.blank?
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
