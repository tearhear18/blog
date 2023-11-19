# frozen_string_literal: true

FactoryBot.define do
  factory :blog_content do
    title { 'Blog Title' }
    body { 'Blog Body' }
  end
end
