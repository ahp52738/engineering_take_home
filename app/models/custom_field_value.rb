class CustomFieldValue < ApplicationRecord
  belongs_to :building
  belongs_to :custom_field_configuration
end