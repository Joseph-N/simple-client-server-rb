require 'nokogiri'
require 'open-uri'
require 'yaml'


yml_file = File.join(__dir__, '../database/drugs.yml')
file = YAML::load_file(yml_file)
file['drugs'] = {}

def random_date from = Time.now, to = Time.now + 1000000000
  Time.at(from + rand * (to.to_f - from.to_f))
end

urls = ["http://www.drugs.com/condition/anxiety.html", "http://www.drugs.com/condition/pain.html"]

print "Fetching drugs from drugs.com"

urls.each do |url|
  doc = Nokogiri::HTML(open(url))
  doc.css('#conditionbox a b').each do |drug|
    expiry_date = random_date
    file["drugs"][drug.text.downcase] = expiry_date
    print "."
  end
end

print " OK"

puts "\nWriting yml file"

File.write(yml_file, file.to_yaml(line_width: -1))

                

