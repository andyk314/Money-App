class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :stock_name
  helper_method :current_user
  helper_method :current_portfolio
  helper_method :stock_price
  helper_method :stock_change
  helper_method :stock_percent_change

  require 'stock_quote'

  # Who is currently logged in, if anyone
  def current_user
  	if session[:user_id]
  		User.find_by(id: session[:user_id])
    end
  end

  # def current_portfolio
  #   if session[:user_id]
  #     Portfolio.find_by(user_id: session[:user_id])
  #   end
  # end


# Took this out because the functionality is now in the portfolios controller
  def stock_name(stock)
    StockQuote::Stock.quote(stock).name
  end

  def stock_price(stock)
    StockQuote::Stock.quote(stock).ask_realtime
  end

  def stock_change(stock)
    StockQuote::Stock.quote(stock).change_realtime
  end

  def stock_percent_change(stock)
    StockQuote::Stock.quote(stock).percent_change
  end



end