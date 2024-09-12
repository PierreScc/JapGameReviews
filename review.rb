class Review < ApplicationRecord
  belongs_to :game

  validates :source, presence: true
  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
