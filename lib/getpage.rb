require 'net/http'
require 'uri'

class GetPage
    attr_accessor :source
    def initialize(host)
    # Create a new URI object from the given URL
    uri = URI("#{host}")
    # Create a new empty string variable
    source = ""
    # Create a new connection to the website
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |conn|
      # Create a new request
      request = Net::HTTP::Get.new uri
      # Get the response (source code) of the site
      response = conn.request request
      # Save the content of "response" in the public variable "@source"
      @source = response.body
    end
  end
end
