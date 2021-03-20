class Request < ApplicationRecord
  has_one :address
  has_many :questions
  belongs_to :user
end
