require 'spec_helper'

describe Inspection do
  it "should load from xml" do
    file = File.open("#{Rails.root}/spec/fixtures/one_joint.xml")
    Inspection.load_xml(file)

    Joint.count.should == 1
    joint = Joint.first
    joint.ident.should == "1222579"
    joint.name.should == "SAI-LILA KHAMAN DHOKLA HOUSE"
    joint.kind_of.should == "Food Take Out"
    joint.address.should == "870 MARKHAM RD "

    Inspection.count.should == 3
    inspection = Inspection.first
    inspection.joint.id.should == joint.id
    inspection.status.should == "Pass"
  end
end
