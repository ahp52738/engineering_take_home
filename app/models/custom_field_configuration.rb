class CustomFieldConfiguration < ApplicationRecord
  belongs_to :client, optional: true
  validates :field_type, presence: true
  FIELD_TYPES = { number: 0, freeform: 1, enum: 2 }.freeze

  # Define allowed enum values as a constant
  ENUM_VALUES = ["Option1", "Option2", "Option3"].freeze

  # Validation for field type
  validates :field_type, inclusion: { 
    in: FIELD_TYPES.values, 
    message: "must be a valid field type"
  }

  # Helper method to get allowed enum values
  def self.allowed_enum_values
    ENUM_VALUES
  end
  
end
