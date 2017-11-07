require 'typhoeus'
require 'nokogiri'

class GetPage
    attr_accessor :source, :subpages, :error, :url
    def initialize(domain)
    	@url = domain
		request = Typhoeus::Request.new("#{domain}", headers: {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"}, followlocation: true, timeout: 40, ssl_verifypeer: false, ssl_verifyhost: 0)

		request.on_complete do |response|
		  if response.success?
		  	subpages = []
		  	page = Nokogiri::HTML(response.body, nil, Encoding::UTF_8.to_s)
		  	
		  	# Find three subpages
		  	links = page.css("a").select{|link| link['href'] =~ /^(https?):\/\/(www\.)?#{domain}\//ix}
			links.each{|link| subpages << link['href'] }
			if(subpages.length >= 3)
				@subpages = subpages.sample(3)
			else
				@subpages = subpages
			end
		    @source = response.body.to_s
		    @error = nil
		  elsif response.timed_out?
		    # aw hell no
		    @error = "got a time out"
		  elsif response.code == 0
		    # Could not get an http response, something's wrong.
		    @error = response.return_message
		  else
		    # Received a non-successful http response.
		    @error = "HTTP request failed: " + response.code.to_s
		  end
		end

		request.run
  	end
end
