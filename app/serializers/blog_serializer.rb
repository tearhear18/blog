# frozen_string_literal: true

class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
