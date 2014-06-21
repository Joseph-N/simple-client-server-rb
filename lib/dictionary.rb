require 'yaml'

# Class to lookup given names from yml file database

class Dictionary

  RESPONSE_CODES = {
      :found => "200 OK",
      :missing => "404 Not Found",
      :error => "500 Internal Server Error"
  }

  def initialize
    @drugs = YAML::load_file(File.join(__dir__, '../database/definitions.yml'))
  end

  def find(name)
    response = {}

    if @drugs["dictionary"].has_key?(name)

      response[:code] = RESPONSE_CODES[:found]
      response[:message] =  @drugs["dictionary"][name]

      response
    else
      response[:code] = RESPONSE_CODES[:missing]
      response[:message] = "Sorry, no match found for: #{name}"

      response
    end

  end
end