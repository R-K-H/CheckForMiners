require 'resolv-replace'
require 'net/http'
require 'uri'
require 'open-uri' 
require 'typhoeus'
require 'nokogiri'

class GetPage
    attr_accessor :source, :subpages
    def initialize(domain)
		request = Typhoeus::Request.new("#{domain}", followlocation: true, timeout: 10, ssl_verifypeer: false, ssl_verifyhost: 0)

		request.on_complete do |response|
		  if response.success?
		  	subpages = []
		  	page = Nokogiri::HTML(response.body)
		  	links = page.css("a").select{|link| link['href'] =~ /^(https?):\/\/(www\.)?#{domain}\//ix}
			links.take(3).each{|link| subpages << link['href'] }
			@subpages = subpages
		    @source = response.body.to_s
		  elsif response.timed_out?
		    # aw hell no
		    puts "got a time out"
		  elsif response.code == 0
		    # Could not get an http response, something's wrong.
		    puts response.return_message
		  else
		    # Received a non-successful http response.
		    puts "HTTP request failed: " + response.code.to_s
		  end
		end

		request.run
  	end
end
