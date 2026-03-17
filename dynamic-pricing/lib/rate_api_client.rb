class RateApiClient
  include HTTParty
  require 'timeout'
  base_uri ENV.fetch('RATE_API_URL', 'http://localhost:8080')
  headers "Content-Type" => "application/json"
  headers 'token' => ENV.fetch('RATE_API_TOKEN', '04aa6f42aa03f220c2ae9a276cd68c62')

  def self.get_rate(period:, hotel:, room:, retry_count: 0)
    @period = period
    @hotel = hotel
    @room = room
    begin
      status = Timeout::timeout(5) {
        params = {
          attributes: [
            {
              period: @period,
              hotel: @hotel,
              room: @room
            }
          ]
        }.to_json
        self.post("/pricing", body: params)
      }
    rescue Timeout::Error => e
      errors << e.message
      retry_fetch(retry_count)
    end
  end

  private
  
  def retry_fetch(retry_count)
    retry_count += 1

    if retry_count <= 3
      get_rate(@period, @hotel, @room)
    else
      raise "Unable to fetch rate at this time."
    end
  end
end
