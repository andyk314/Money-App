
class PortfoliosController < ApplicationController
require 'stock_quote'
require 'net/http'
  def index
  end
  
  def new
  	@portfolio = Portfolio.new
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end
# @stockdata = StockQuote::Stock.quote(company).ask
# Portfolio.find_by(name:'Chase').stocks.find_by(company: "Google").ticker

   def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      current_user.portfolios.push(@portfolio)
			redirect_to action: 'index'
			flash[:notice] = 'successfully added portfolio!'
		else
			render action: 'new'
		end
	end


  def destroy
  	Portfolio.find(params[:id]).destroy
	       redirect_to portfolios_path
  end


private
  
  def portfolio_params
    params.require(:portfolio).permit(:name, :type)
  end

  def company
    current_portfolio.stocks[0].ticker
    # @stock = current_portfolio.stocks.find_by(params[:company]).ticker
  end



end
