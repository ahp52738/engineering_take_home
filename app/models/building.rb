class Building < ApplicationRecord
  belongs_to :client
  has_many :custom_field_values, dependent: :destroy
  accepts_nested_attributes_for :custom_field_values

  validates :address, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
