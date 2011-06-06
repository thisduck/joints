require 'spec_helper'

describe JointsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'near'" do
    it "should be successful" do
      get 'near'
      response.should be_success
    end
  end

end
