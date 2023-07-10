require 'rails_helper'

RSpec.feature "User registration", :type => :feature do
  scenario 'User registers with valid details' do
    visit new_user_registration_path

    fill_in 'Имя', with: 'TestUser'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Пароль', with: 'password'
    fill_in 'Повторите пароль', with: 'password'
    click_button 'Зарегистрироваться'

    expect(page).to have_text('Это ЧатЧат! Болтать разрешено!')
  end
end
