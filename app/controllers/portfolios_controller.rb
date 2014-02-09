class PortfoliosController < ApplicationController

  def index
  end
  
  def new
  	@portfolio = Portfolio.new
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

   def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
		# if Portfolio.create(params[:id])
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



end
