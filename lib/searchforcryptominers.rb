class SearchForCryptoMiners
  # Initialize the Array and make it accessable from the outside
  attr_accessor :miner, :contains
  
  def initialize(code)
    # Fill the array with data (the miner domains)
    @miner =  [
      "https://coinhive.com/lib/coinhive.min.js",
      "https://coin-hive.com/lib/coinhive.min.js",
      "https://coinhive.com/lib/cryptonight.wasm",
      "https://coin-hive.com/lib/cryptonight.wasm",
      "https://crypto-loot.com/lib/miner.min.js",
      "https://ppoi.org/lib/projectpoi.min.js",
      "lib/coinhive.min.js",
      "lib/cryptonight.wasm",
      "lib/miner.min.js",
      "lib/projectpoi.min.js"
    ]
    # Get the code variable from the class object
    code = code.source
    # Set the @contains variable to the standard value "false"
    @contains = false
    # Check if the code contains "coinhive.com/lib", "coin-hive.com/lib", "crypto-loot.com/lib", "lib/coinhive.min.js"
    if @miner.any? { |check| code.include? check }
      # Set "contains" to true
      @contains = true
    end
  end
end
