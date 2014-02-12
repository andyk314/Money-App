class StocksController < ApplicationController
require 'stock_quote'
require 'net/http'
  def index
    @user = User.new
    
  end
  

  def new
  	@stock = Stock.new
    @user = User.new
  end

  def create
    @stock = Stock.new(stock_params)
		if @stock.save
      current_portfolio.stocks.push(@stock)
				redirect_to action: 'index'
				flash[:notice] = 'successfully added stock!'
		else
			render action: 'new'
		end
	end

  def destroy
    Stock.find(params[:id]).destroy
    redirect_to stocks_path
  end

  def show
    @stock = Stock.find(params[:id])
    @user = User.new
    @name = StockQuote::Stock.quote(@stock.ticker).name.split[0]
    @price = StockQuote::Stock.quote(@stock.ticker).ask_realtime
    @change = StockQuote::Stock.quote(@stock.ticker).change_realtime
    @pe = StockQuote::Stock.quote(@stock.ticker).pe_ratio
    @percent_change = StockQuote::Stock.quote(@stock.ticker).percent_change
    @price = StockQuote::Stock.quote(@stock.ticker).ask_realtime
    @dividend = StockQuote::Stock.quote(@stock.ticker).dividend_yield
    @days_high = StockQuote::Stock.quote(@stock.ticker).days_high
    @days_low = StockQuote::Stock.quote(@stock.ticker).days_low
    @volume = StockQuote::Stock.quote(@stock.ticker).volume
    @average_daily_volume = StockQuote::Stock.quote(@stock.ticker).average_daily_volume
    @market_cap = StockQuote::Stock.quote(@stock.ticker).market_capitalization
  end

private
  def stock_params
    params.require(:stock).permit(:ticker, :company)
  end


end

