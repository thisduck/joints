class Joint
  include Mongoid::Document

  field :ident, type: String
  validates_uniqueness_of :ident
  index :ident, unique: true

  field :name, type: String
  field :kind_of, type: String
  field :address, type: String
end
