class Inspection
  include Mongoid::Document

  field :ident, type: String
  validates_uniqueness_of :ident
  index :ident, unique: true

  field :status, type: String
  field :details, type: String
  field :inspected_at, type: Date
  field :severity, type: String
  field :action, type: String
  field :court_outcome, type: String
  field :amount_fined, type: Float
end
