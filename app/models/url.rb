require 'uri'
require 'net/http'

class Url < ActiveRecord::Base

  belongs_to :user
  
  validates :url, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
  before_save :valid_response

  def valid_response
      case p Net::HTTP.get_response(URI.parse(url))
      when Net::HTTPSuccess, Net::HTTPMovedPermanently, Net::HTTPFound, Net::HTTPForbidden
      else
        errors.add(:url, "invalid")
      end
      errors.empty?
  end
end