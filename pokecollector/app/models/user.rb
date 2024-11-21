class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #creates one to many relationship with card model
  has_many :cards

  #Validations for required attributes
  validates :first_name, presence: true 
  validates :last_name, presence: true 


end
