class Group < ApplicationRecord
  has_many :admins
  has_one :owner, through: :admins, source: :user
  belongs_to :user
end
