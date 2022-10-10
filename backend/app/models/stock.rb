class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    require 'uri'
    require 'net/http'
    @key = Rails.application.credentials.alpha_vantage[:api_key]

    def self.new_lookup(ticker_symbol)
        uri = URI("https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{ticker_symbol}&interval=5min&apikey=${@key}")
        res = Net::HTTP.get_response(uri)
        if res.is_a?(Net::HTTPSuccess)
            # this gets you the whole damn intraday data, remember to pick out your deserved info on the frontend
            # or just make more methods on the backend to specifically access certain attributes
            JSON.parse(res.body)
        else
            return "Error, response was not received"
        end
    end

    def self.check_db(ticker_symbol)
        self.where(ticker: ticker_symbol).first
    end
end
