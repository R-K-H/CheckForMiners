require 'net/http'
require 'uri'

class GetPage
    attr_accessor :source
    def initialize(host)
    # Initialize a new URI object and create a new connection to the website
    @source = Net::HTTP.get(URI("#{host}"))
  end
end
