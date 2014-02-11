class StocksController < ApplicationController
require 'stock_quote'
require 'net/http'
  def index
  end
  

  def new
  	@stock = Stock.new
  end

  def create
		if Stock.create(stock_params)
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
    @price = StockQuote::Stock.quote(@stock.ticker).ask_realtime
    @change = StockQuote::Stock.quote(@stock.ticker).change_realtime
    @pe = StockQuote::Stock.quote(@stock.ticker).pe_ratio
    @percent_change = StockQuote::Stock.quote(@stock.ticker).percent_change
    @price = StockQuote::Stock.quote(@stock.ticker).ask_realtime
    

  end

private
  def stock_params
    params.require(:stock).permit(:ticker, :company)
  end


end

