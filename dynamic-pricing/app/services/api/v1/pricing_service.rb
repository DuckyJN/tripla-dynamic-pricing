module Api::V1
  class PricingService < BaseService
    def initialize(period:, hotel:, room:)
      @period = period
      @hotel = hotel
      @room = room
    end

    def run
      @result = Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
        response = RateApiClient.get_rate(period: @period, hotel: @hotel, room: @room)

        unless response.success?
          raise "Rate API error: #{response.code}"
        end

        parsed = JSON.parse(response.body)
        rate = parsed['rates']
          &.detect { |r| r['period'] == @period && r['hotel'] == @hotel && r['room'] == @room }
          &.dig('rate')

        raise "Rate not found for #{@period}/#{@hotel}/#{@room}" if rate.nil?

        rate
      end
    rescue StandardError => e
      errors << e.message
    end

    private
    def cache_key
      "rate_#{@period}_#{@hotel}_#{@room}"
    end
  end
end
