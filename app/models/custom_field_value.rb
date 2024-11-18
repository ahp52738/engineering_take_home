class CustomFieldValue < ApplicationRecord
  belongs_to :building
  belongs_to :custom_field_configuration

  validates :value, presence: true
  validate :validate_value_type

  private

  def validate_value_type
    if custom_field_configuration.nil?
      errors.add(:custom_field_configuration, "must be present")
      return
    end

    case custom_field_configuration.field_type
    when CustomFieldConfiguration::FIELD_TYPES[:number]
      # Check if value is a valid number
      errors.add(:value, "must be a number") unless valid_number?(value)
    when CustomFieldConfiguration::FIELD_TYPES[:freeform]
      # No validation needed for freeform fields
    when CustomFieldConfiguration::FIELD_TYPES[:enum]
      # Check if value is in allowed enum values
      allowed_values = CustomFieldConfiguration.allowed_enum_values
      errors.add(:value, "is not a valid option") unless allowed_values.include?(value)
    end
  end

  # Helper method to validate numeric value
  def valid_number?(value)
    true if Float(value) rescue false
  end
end
