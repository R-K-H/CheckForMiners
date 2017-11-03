require 'mongo'
require './lib/getpage'
require './lib/searchforcryptominers'
#require './lib/domainsshort'
require 'typhoeus'
require 'nokogiri'
require './lib/domains'
require 'thread/pool'

Mongo::Logger.logger.level = Logger::FATAL

def pt(what)
  puts what
  STDOUT.flush
end

pool = Thread.pool(4)
pool.shutdown


client = Mongo::Client.new('mongodb://mongo/domains')

collection = client[:domains]

domains = Domains.domains

# Print some information
pt("Check for Miners")

domains.each do |domain|
	# Get the source code

	doc = { domain: domain }
	doc[:pages] = []

	domain_info = GetPage.new domain

	if domain_info.source.nil?
		result = collection.insert_one(doc)
		pt(result.inserted_id.to_s)
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
	domain_info.subpages.each_with_index do |page, i|
		if i > 40000
		page_source = GetPage.new page
		if page_source.source.nil?
			doc[:pages] << {
				url: page,
				data: {}
			}
			result = collection.insert_one(doc)
			pt(result.inserted_id.to_s)
			next
		end
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
	pt(result.inserted_id.to_s)
end

