class SearchForCryptoMiners
  # Initialize the Array and make it accessable from the outside
  attr_accessor :miner, :contains
  
  def initialize(source)
    # Should add in a type so we could flag it as to what miner is found
    
    # Fill the array with data (the miner domains)
    @miner =  [
      "coinhive.com/lib/coinhive.min.js",
      "coin-hive.com/lib/coinhive.min.js",
      "coinhive.com/lib/cryptonight.wasm",
      "coin-hive.com/lib/cryptonight.wasm",
      "crypto-loot.com/lib/miner.min.js",
      "ppoi.org/lib/projectpoi.min.js",
      "coinhive.min.js",
      "cryptonight.wasm",
      "miner.min.js",
      "coin-hive",
      "ppoi.org",
      "cryptonight",
      "projectpoi.min.js",
      "lib/coinhive.min.js",
      "lib/cryptonight.wasm",
      "lib/miner.min.js",
      "lib/projectpoi.min.js",
      "coinhive.com/lib",
      "coin-hive.com/lib",
      "coinhive.com/captcha",
      "coin-hive.com/captcha",
      "coinhive.com/proxy",
      "coin-hive.com/proxy",
      "jsecoin.com/server",
      "server.jsecoin.com",
      "load.jsecoin.com",
      "static.reasedoper.pw",
      "mataharirama.xyz",
      "jsecoin.com",
      "listat.biz",
      "lmodr.biz",
      "minecrunch.co/web",
      "minemytraffic.com",
      "crypto-loot.com/lib",
      "crypto-loot.com/proxy",
      "2giga.link/wproxy",
      "2giga.link/hive/lib",
      "ppoi.org/lib",
      "ppoi.org/token",
      "coinerra.com/lib",
      "coin-have.com/c",
      "kisshentai.net/Content/js/c-hive.js",
      "miner.pr0gramm.com/xmr.min.js",
      "kiwifarms.net/js/Jawsh/xmr/xmr.min.js",
      "anime.reactor.cc/js/ch/cryptonight.wasm",
      "joyreactor.cc/ws/ch",
      "kissdoujin.com/Content/js/c-hive.js",
      "minero.pw/miner.min.js",
      "coinnebula.com/lib",
      "afminer.com/code",
      "coinblind.com/lib",
      "webmine.cz/miner",
      "monerominer.rocks/scripts/miner.js",
      "monerominer.rocks/miner.php",
      "cdn.cloudcoins.co/javascript/cloudcoins.min.js",
      "coinlab.biz/lib/coinlab.js",
      "cnhv.co",
      "coinlab.js",
      "miner.js",
      "cloudcoins.min.js",
      "c-hive.js",
      "xmr.min.js"
    ]
   
      # Set the @contains variable to the standard value "false"
      @contains = false
      # Check if the code contains "coinhive.com/lib", "coin-hive.com/lib", "crypto-loot.com/lib", "lib/coinhive.min.js", etc.
      if @miner.any? { |check| source.include? check }
        # Set "contains" to true
        @contains = true
      end
    end
end
