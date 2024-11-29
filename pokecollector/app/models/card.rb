class Card < ApplicationRecord
  
  #creates relationship of child to user model
  belongs_to :user

  #validations for required model attributes
  validates :card_name, presence: true 
  validates :set, presence: true 


end
