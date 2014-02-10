class StocksController < ApplicationController
require 'stock_quote'
require 'net/http'
  def index
  end
  

  def new
  	@stock = Stock.new
  end

  def create
		if Stock.create(params.require(:stock).permit(:ticker, :company))
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

end

