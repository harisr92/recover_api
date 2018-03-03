class Platue < ApplicationRecord
  has_many :states, dependent: :destroy

  validates :width, :height, presence: true, numericality: { greater_than: 0 }
end
