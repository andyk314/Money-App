require 'ystock'
class Stock
  include Mongoid::Document
  field :ticker, type: String
  field :company, type: String
  field :price, type: String

  belongs_to :portfolio
end
