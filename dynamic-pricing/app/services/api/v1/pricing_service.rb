module Api::V1
  class PricingService < BaseService
    def initialize(period:, hotel:, room:)
      @period = period
      @hotel = hotel
      @room = room
    end

    def run
      rate = Rails.cache.fetch("rate", expires_in: 5.minutes) do
        RateApiClient.get_rate(period: @period, hotel: @hotel, room: @room)
      end
      if rate.success?
        parsed_rate = JSON.parse(rate.body)
        @result = parsed_rate['rates'].detect { |r| r['period'] == @period && r['hotel'] == @hotel && r['room'] == @room }&.dig('rate')
      else
        errors << rate.body['error']
      end
    end
  end
end
