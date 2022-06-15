# frozen_string_literal: true

class Member < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
