class Sentences
  # Make the sentence variable accessable from another class
  attr_accessor :sentence
  
  def initialize
    # Some (maybe stupid) phrases
    phrases = Array.new
    phrases = ["Because mining with JavaScript is a bad idea",
               "Because my cat wanted me to write this program",
               "Because I had too much free time",
               "Because it escalated",
               "Because schools are mining with Coin Hive, too"]
    # Pick a random number and save a sentence in the public variable "@sentence"
    @sentence = phrases[rand(phrases.count)]
  end
end
