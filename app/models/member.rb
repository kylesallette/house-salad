class Member
  attr_reader :name,
              :role,
              :party,
              :district,
              :seniority

  def initialize(attributes = {})
    @name       = attributes[:name]
    @role       = attributes[:role]
    @party      = attributes[:party]
    @district   = attributes[:district]
    @seniority  = attributes[:seniority].to_i
  end

  def find_all(state)

    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["propublica_key"]
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("/congress/v1/members/house/#{state}/current.json")

    results = JSON.parse(response.body, symbolize_names: true)[:results]

    @members  = results.map do |result|
      Member.new(result)
    end
  end

end
