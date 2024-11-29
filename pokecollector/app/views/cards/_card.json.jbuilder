json.extract! card, :id, :card_name, :card_type, :card_image, :set, :card_price, :user_id, :created_at, :updated_at
json.url card_url(card, format: :json)
