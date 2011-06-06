class JointsController < ApplicationController
  def index
  end

  def near
    location = [params[:lat], params[:long]].collect(&:to_f).reverse
    render :json => Joint.near(location).and(:kind_of.in => ["Food Take Out", "Restaurant"] )
  end

end
