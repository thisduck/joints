class Joint
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :ident, type: String
  validates_uniqueness_of :ident
  index :ident, unique: true

  field :name, type: String
  field :kind_of, type: String

  field :address, type: String
  field :full_address, type: String
  field :location, type: Array
  index [[ :location, Mongo::GEO2D ]]

  geocoded_by :address, :coordinates => :location
  has_many :inspections

  before_save :set_location

  def set_location
    if self.new_record? || self.address_changed?
      first = Geocoder.search(self.address + ", Toronto, Ontario").first
      return if !first

      self.location = first.coordinates
      self.full_address = first.address
    end
  end
end
