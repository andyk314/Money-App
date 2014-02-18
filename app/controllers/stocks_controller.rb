class StocksController < ApplicationController
require 'stock_quote'
require 'net/http'

  def index
    @user = User.new 
    @stocks = Stock.all   
  end
  

  def new
    @user = User.new    
    # # @portfolio = Portfolio.find(params[:id])
    # # @portfolio = Portfolio.new
    # # @stock = @portfolio.stock.new
    # @portfolio = Portfolio.find(portfolio_params[:id])
    # @stock = @portfolio.stock.new
  end

  def create
    @stock = @portfolio.stock.create(stock_params)
		if @stock.save
				redirect_to stocks_path
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
    all_info = StockQuote::Stock.quote(@stock.ticker)
    @name = all_info.name.split[0]
    @price = all_info.ask_realtime
    @change = all_info.change_realtime
    @pe = all_info.pe_ratio
    @percent_change = all_info.percent_change
    @price = all_info.ask_realtime
    @dividend = all_info.dividend_yield
    @days_high = all_info.days_high
    @days_low = all_info.days_low
    @volume = all_info.volume
    @average_daily_volume = all_info.average_daily_volume
    @market_cap = all_info.market_capitalization
  end

private
  def stock_params
    params.require(:stock).permit(:ticker)
  end


end

