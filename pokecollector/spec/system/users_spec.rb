require 'rails_helper'

RSpec.describe "Users", type: :system do
  it 'user creation - happy' do
    visit new_user_registration_path

    fill_in 'First name', with: 'Test'
    fill_in 'Last name', with: 'User'
    fill_in 'Email', with: 'testemail@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(User.last.email).to eq('testemail@email.com')
  end
  
  it 'user creation - sad' do
    @user_count = User.count

    visit new_user_registration_path

    fill_in 'First name', with: 'Test'
    fill_in 'Last name', with: ''
    fill_in 'Email', with: 'testemail@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_button 'Sign up'
    expect(page).to have_content("Last name can't be blank")
    expect(User.count).to eq(@user_count)
  end

  it 'card creation - happy' do
    #must be a user to create a card
    @user = User.create!(first_name: 'Test', last_name: 'User', email: 'testEmail@email.com', password: '123456', password_confirmation: '123456')
    visit root_path
    click_link_or_button "Sign In"
    fill_in 'Email', with: 'testemail@email.com'
    fill_in 'Password', with: '123456'
    expect(page).to have_content('Log in')
    click_button 'Log in'
    

    visit user_path(@user.id)
    expect(page).to have_content("First name: #{@user.first_name}")
    

    click_link_or_button 'Create new card'
    expect(current_path).to eq(new_card_path)

    fill_in 'Card name', with: 'Mewtwo'
    fill_in 'Set', with: 'base'
    click_link_or_button 'Create Card'
    expect(page).to have_content("Card name: Mewtwo")
    expect(page).to have_content("User: #{@user.id}")
  end

  it 'card creation - happy' do
    #must be a user to create a card
    @user = User.create!(first_name: 'Test', last_name: 'User', email: 'testEmail@email.com', password: '123456', password_confirmation: '123456')
    visit root_path
    click_link_or_button "Sign In"
    fill_in 'Email', with: 'testemail@email.com'
    fill_in 'Password', with: '123456'
    expect(page).to have_content('Log in')
    click_button 'Log in'
    

    visit user_path(@user.id)
    expect(page).to have_content("First name: #{@user.first_name}")
    

    click_link_or_button 'Create new card'
    expect(current_path).to eq(new_card_path)

    fill_in 'Card name', with: 'Mewtwo'
    fill_in 'Set', with: ''
    click_link_or_button 'Create Card'
    expect(page).to have_content "Set can't be blank"
  end
end