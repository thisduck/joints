class Inspection
  include Mongoid::Document

  field :ident, type: String
  validates_uniqueness_of :ident
  validates_presence_of :ident
  index :ident, unique: true

  field :status, type: String
  field :details, type: String
  field :inspected_at, type: Date
  field :severity, type: String
  field :action, type: String
  field :court_outcome, type: String
  field :amount_fined, type: Float

  belongs_to :joint

  def self.load_xml(file)
    doc = Nokogiri::XML(file)

    doc.css("ROWDATA ROW").each do |row|
      joint_data = {
        ident: row.at_css("ESTABLISHMENT_ID").content,
        name: row.at_css("ESTABLISHMENT_NAME").content,
        kind_of: row.at_css("ESTABLISHMENTTYPE").content,
        address: row.at_css("ESTABLISHMENT_ADDRESS").content,
      }

      joint = Joint.where(ident: joint_data[:ident]).first
      joint = Joint.create(joint_data) if !joint

      inspection_data = {
        joint_id: joint.id,
        ident: row.at_css("INSPECTION_ID").content,
        status: row.at_css("ESTABLISHMENT_STATUS").content,
        details: row.at_css("INFRACTION_DETAILS").content,
        inspected_at: row.at_css("INSPECTION_DATE").content,
        severity: row.at_css("SEVERITY").content,
        action: row.at_css("ACTION").content,
        court_outcome: row.at_css("COURT_OUTCOME").content,
        amount_fined: row.at_css("AMOUNT_FINED").content,
      }

      inspection = Inspection.where(ident: inspection_data[:ident]).first
      inspection = Inspection.create(inspection_data) if !inspection
    end
  end
end
