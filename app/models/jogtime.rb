class Jogtime < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :minutes, presence: true
  validates :distance, presence: true
  validates :weekday, presence: true
end
