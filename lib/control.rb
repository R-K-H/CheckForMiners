require 'mongo'
require './lib/getpage'
require './lib/searchforcryptominers'
require './lib/domainsshort'
require 'typhoeus'
require 'nokogiri'
require 'json'
require 'pp'
# require './lib/domains'

client = Mongo::Client.new('mongodb://mongo/domains')

collection = client[:domains]

domains = DomainsShort.domains
# Print some information
puts "Check for Miners"

domains.each do |domain|
	# Get the source code

	doc = { domain: domain }
	doc[:pages] = []

	domain_info = GetPage.new domain

	if domain_info.source.nil?
		result = collection.insert_one(doc)
		puts result.inserted_id.to_s
		next
	end

	uses = SearchForCryptoMiners.new domain_info.source
	doc[:pages] << {
		url: domain,
		data: {
			#source: domain_info.source,
			miner: uses.contains
		}
	}

	domain_info.subpages.each do |page|
		page_source = GetPage.new page
		pages_uses = SearchForCryptoMiners.new page_source.source

		doc[:pages] << {
			url: page,
			data: {
				#source: page_source.source,
				miner: pages_uses.contains
			}
		}
 	end

	result = collection.insert_one(doc)
	puts result.inserted_id.to_s
end
