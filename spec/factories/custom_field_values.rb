FactoryBot.define do
  factory :custom_field_value do
    building { nil }
    custom_field_configuration { nil }
    value { "MyString" }
  end
end
