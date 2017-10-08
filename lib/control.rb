require './getpage'
require './searchforcryptominers'
require './sentences'

# Get a new sentence
sentence = Sentences.new
sentence = "#{sentence.sentence}"
# Print some information
puts "Check for Miner"
# Print a (maybe stupid) sentence
puts "\n#{sentence}\n"
puts ""
# Ask the user for typing in the URL
print "Type in the URL you want to check: "
# Save the URL in a variable
url = gets.chomp
# Get the source code
source = GetPage.new url
puts "\nDownloaded the source code of the site"
# Check if the site uses Coin Hive
uses = SearchForCryptoMiners.new(source)
puts "Searched for known crypto miner domains/locations (#{uses.miner.join(", ")})"
# Check if the variable "uses" is true
if uses.contains
  # Print that the site uses Coin Hive
  puts "\nThe site '#{url}' uses a crypto miner"
else
  # Print that the site doesn't use Coin Hive
  puts "\nThe site '#{url}' doesn't use a crypto miner"
end
