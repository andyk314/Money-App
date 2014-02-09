

class Portfolio
  include Mongoid::Document
  field :name, type: String
  field :type, type: String

  belongs_to :user
  has_many :stocks
  validates :name, presence: true

end
