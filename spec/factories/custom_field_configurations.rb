FactoryBot.define do
  factory :custom_field_configuration do
    client { nil }
    field_name { "MyString" }
    field_type { 1 }
  end
end
