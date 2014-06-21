require 'nokogiri'
require 'open-uri'

file = File.join(__dir__, "../misc/words.txt")

url = "http://www.englishclub.com/vocabulary/regular-verbs-list.htm"
puts "Fetching English Verbs"

doc = Nokogiri::HTML(open(url))
print "Fetching words"

doc.css('li').each do |verb|
        File.open(file, 'a') { |file| file.puts verb.text }
        print "."
end

puts "Success"