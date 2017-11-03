require 'mongo'
require './lib/getpage'
require './lib/searchforcryptominers'
#require './lib/domainsshort'
require 'typhoeus'
require 'nokogiri'
require './lib/domains'
require 'thread/pool'

Mongo::Logger.logger.level = Logger::FATAL
client = Mongo::Client.new('mongodb://mongo/domains')
@collection = client[:domains]

def pt(what)
  puts what
  STDOUT.flush
end

def getCracking(domain, pool)
	pt(domain.to_s + " starting")
	doc = { domain: domain }
	doc[:pages] = []

	domain_info = GetPage.new domain

	if domain_info.source.nil?
		result = @collection.insert_one(doc)
		pt(result.inserted_id.to_s)
		return
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
		if page_source.source.nil?
			doc[:pages] << {
				url: page,
				data: {}
			}
			result = @collection.insert_one(doc)
			pt(result.inserted_id.to_s)
			return
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

	result = @collection.insert_one(doc)
	pt(result.inserted_id.to_s)
	return
end

# Ger our huge list of domains
@domains = Domains.domains
pool = Thread.pool(2)
pt("Check for Miners")
# For each domain let's go through and do things.
@domains.each_with_index do |domain, i|
	pool.process {
		getCracking(domain, pool)
	}

end
pool.shutdown
