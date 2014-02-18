
class PortfoliosController < ApplicationController
require 'stock_quote'
require 'net/http'
  def index
    @users = User.all
    @user = User.new
  end
  
  def new
  	@portfolio = Portfolio.new
    @user = User.new
  end

  def show
    @user = User.new
    @portfolio = Portfolio.find(params[:id])
    @info = []
    @portfolio.stocks.each do |s|
      @info.push(StockQuote::Stock.quote(s.ticker))
    end
  end

  def edit
    @user = User.new
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

  def update
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update portfolio_params
      flash[:notice] = "Successfully updated my portfolios"
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

private
  
  def portfolio_params
    params.require(:portfolio).permit(:name, :type)
  end

end
