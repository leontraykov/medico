require 'rails_helper'

RSpec.feature "Site Navigation", type: :feature do
  let(:user) { create(:user) }

  context "Navigate to the homepage" do
    it "displays welcome text after login" do
      # Вход в систему
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
      click_button 'Войти'
  
      # Проверка текста на главной странице
      expect(page).to have_text("Это ЧатЧат! Болтать разрешено!")
    end
  end

  context "Navigate to a chat room" do
    it "displays the chat room after login" do
      # Создание чат комнаты
      chat_room = create(:chat_room)

      # Вход в систему
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
      click_button 'Войти'
  
      # Переход в чат комнату
      visit chat_room_path(chat_room)
  
      # Проверка названия чат комнаты на странице
      expect(page).to have_text(chat_room.name)
    end
  end
end

require 'rails_helper'

RSpec.feature "Site Navigation", :type => :feature do
  let(:user) { create(:user) }

  scenario "Navigate to the homepage" do
    # Вход в систему
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Пароль', with: user.password
    click_button 'Войти'

    visit root_path

    expect(page).to have_text("Это ЧатЧат! Болтать разрешено!")
  end

  scenario "Navigate to a chat room" do
    login_as(user)
    chat_room = create(:chat_room)

    visit chat_room_path(chat_room)

    expect(page).to have_text(chat_room.name)
  end
end
