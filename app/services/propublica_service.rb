class PropublicaService

  def initialize(state)
    @state = state
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def find_house_members
    get_url("/congress/v1/members/house/#{state}/current.json")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.find_house_members(state)
    new(state).find_house_members
  end
end
