# look up drug expiry date

class Drugs
  RESPONSE_CODES = {
      :found => "200 OK",
      :missing => "404 Not Found",
      :error => "500 Internal Server Error"
  }

  def initialize
    @store = YAML::load_file(File.join(__dir__, '../database/drugs.yml'))
  end


  def find(name)
    response = {}

    if @store["drugs"].has_key?(name)

      response[:code] = RESPONSE_CODES[:found]
      response[:message] =  "#{name} expires: #{@store["drugs"][name].to_date.strftime("%d %B %Y")}"

      response
    else
      response[:code] = RESPONSE_CODES[:missing]
      response[:message] = "Sorry, no drug found with name: #{name}"

      response
    end
  end
end