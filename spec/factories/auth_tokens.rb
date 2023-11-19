# frozen_string_literal: true

FactoryBot.define do
  factory :auth_token do
    token { 'T' * 30 }
  end
end
