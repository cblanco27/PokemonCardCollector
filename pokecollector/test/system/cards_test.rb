require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @card = cards(:one)
  end

  test "visiting the index" do
    visit cards_url
    assert_selector "h1", text: "Cards"
  end

  test "should create card" do
    visit cards_url
    click_on "New card"

    fill_in "Card image", with: @card.card_image
    fill_in "Card name", with: @card.card_name
    fill_in "Card price", with: @card.card_price
    fill_in "Card type", with: @card.card_type
    fill_in "Set", with: @card.set
    fill_in "User", with: @card.user_id
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "should update Card" do
    visit card_url(@card)
    click_on "Edit this card", match: :first

    fill_in "Card image", with: @card.card_image
    fill_in "Card name", with: @card.card_name
    fill_in "Card price", with: @card.card_price
    fill_in "Card type", with: @card.card_type
    fill_in "Set", with: @card.set
    fill_in "User", with: @card.user_id
    click_on "Update Card"

    assert_text "Card was successfully updated"
    click_on "Back"
  end

  test "should destroy Card" do
    visit card_url(@card)
    click_on "Destroy this card", match: :first

    assert_text "Card was successfully destroyed"
  end
end
