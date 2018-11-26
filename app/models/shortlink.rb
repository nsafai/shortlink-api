class Shortlink < ApplicationRecord
  validates :short_url, presence: true,
                    length: { minimum: 1 }
  validates :long_url, presence: true, url: true
end
