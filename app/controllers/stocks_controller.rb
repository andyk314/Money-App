class StocksController < ApplicationController
require 'stock_quote'
require 'net/http'
  def index
  end
  

  def new
  	@stock = Stock.new
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
    @name = StockQuote::Stock.quote(@stock.ticker).name
    @price = StockQuote::Stock.quote(@stock.ticker).ask_realtime
    @change = StockQuote::Stock.quote(@stock.ticker).change_realtime
    @pe = StockQuote::Stock.quote(@stock.ticker).pe_ratio
    @percent_change = StockQuote::Stock.quote(@stock.ticker).percent_change
    @price = StockQuote::Stock.quote(@stock.ticker).ask_realtime
    @dividend = StockQuote::Stock.quote(@stock.ticker).dividend_yield
  end

private
  def stock_params
    params.require(:stock).permit(:ticker, :company)
  end


end

