class WorkSpace < ApplicationRecord

  #validation
  validates :name, presence: true
  validates :user_id, presence: true

  #Assosiation
  belongs_to :user
  has_many :horons, dependent: :destroy

  #method

end
