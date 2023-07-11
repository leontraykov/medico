require 'rails_helper'

RSpec.feature "Message management", :type => :feature do
  let(:user) { create :user }
  let(:chat_room) { create :chat_room }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Пароль", with: user.password
    click_button "Войти"
    visit chat_room_path(chat_room)
  end

  scenario "User sends a message" do
    fill_in "chat-text", with: "Hello, world!"
    click_button "Отправить"
    
    expect(page).to have_text("Hello, world!")
  end
end
