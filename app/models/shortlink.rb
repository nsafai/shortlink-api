class Shortlink < ApplicationRecord
  before_validation :smart_add_url_protocol

  validates :short_url, presence: true,
                    length: { minimum: 1 },
                    uniqueness: true
  validates :long_url, presence: true, :url => true

  protected

  def smart_add_url_protocol
    unless self.long_url[/\Ahttp:\/\//] || self.long_url[/\Ahttps:\/\//]
      self.long_url = "http://#{self.long_url}"
    end
  end

end
