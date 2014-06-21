require 'nokogiri'
require 'open-uri'
require 'yaml'

userAgent = 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36'

yml_file =  File.join(__dir__, "../database/definitions.yml")
file = YAML::load_file(yml_file)
file['dictionary'] = {}

words = File.readlines(File.join(__dir__, "../misc/words.txt"));


(0..40).map.each do |word|
        random_word = words[rand(words.size)].chop
        url = "http://dictionary.reference.com/browse/#{random_word}"
        doc = Nokogiri::HTML(open(url, 'User-Agent' => userAgent))
        definitions = doc.css('.td3n2')
        if definitions.any?
                puts "Found definition for: #{random_word}"
                file['dictionary'][random_word.strip] =   definitions[0].text.strip
        else
                puts "No definition found for: #{random_word}"
        end
        puts "sleeping one second"
        sleep 1
end

p "Writing yml file"

File.write(yml_file, file.to_yaml(line_width: -1))
                

