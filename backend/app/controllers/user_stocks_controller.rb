class UserStocksController < ApplicationController
    def create
        stock = Stock.check_db(params[:ticker])

        if stock.blank?
            stock = Stock.new_lookup(ticker:params[:ticker]).first
            stock.save
        end

        @user_stock = UserStock.create(user:current_user, stock:stock)
    end
end
