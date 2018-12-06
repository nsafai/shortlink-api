class Shortlink < ApplicationRecord
  validates :short_url, presence: true,
                    length: { minimum: 1 },
                    uniqueness: true
  validates :long_url, presence: true, url: true
end
