require 'rails_helper'

RSpec.feature "User sign in", :type => :feature do
  let!(:user) { User.create!(email: 'test@example.com', password: 'password') }

  scenario 'User signs in with valid details' do
    visit new_user_session_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Пароль', with: 'password'
    click_button 'Войти'

    expect(page).to have_text('Это ЧатЧат! Болтать разрешено!')
  end
end
