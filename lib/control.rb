require 'mongo'
require './lib/getpage'
require './lib/searchforcryptominers'
require './lib/domains'
require 'thread/pool'

# Tell it to shutup
Mongo::Logger.logger.level = Logger::FATAL

# Our mongo db 
client = Mongo::Client.new('mongodb://mongo/domains')
@collection = client[:domains]

def pt(what)
  puts what
  STDOUT.flush
end

def buildDocument(domain, doc)
	unless domain.error.nil?
		doc[:errors] << {
			error: domain.error
		}
	end
	
	if domain.source.nil?
		# Add to our document
		doc[:pages] << {
			url: domain.url,
			data: nil
		}
	else
		# Search
		uses = SearchForCryptoMiners.new domain.source

		# add to our document
		doc[:pages] << {
			url: domain.url,
			data: {
				miner: uses.contains
			}
		}
	end

	return doc
end

def fetchDomains(domain)
	# Output a starting
	pt(domain.to_s + " starting")

	# Begin building our mongo document
	doc = { domain: domain }

	# Multi page array
	doc[:pages] = []
	doc[:errors] = []

	# Fetch our page info and return domain object (source and sub pages)
	domain_info = GetPage.new domain

	doc = buildDocument(domain_info, doc)

	if(domain_info.subpages.kind_of?(Array))
		# Go through subpages
		domain_info.subpages.each do |page|

			page_source = GetPage.new page
			doc = buildDocument(page_source, doc)
	 	end
	end
	result = @collection.insert_one(doc)
	pt(result.inserted_id.to_s)
	return
end

# Ger our huge list of domains
@domains = Domains.domains

# Setup for "fake" multithread in ruby
pool = Thread.pool(20000)

# For each domain let's go through and do things.
@domains.each_with_index do |domain, i|
	pool.process {
		fetchDomains(domain)
	}
end

pool.shutdown
