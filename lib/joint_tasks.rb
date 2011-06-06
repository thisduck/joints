module JointTasks
  def self.find_locations
    Joint.where(full_address: nil).all.each do |joint|
      sleep 0.2
      joint.address = joint.address + " "
      joint.set_location
      joint.address.strip!
      joint.save
    end.count
  end

  def self.store_inspections
    Joint.where(cached_inspections: nil).each do |joint|
      joint.cache_inspections!
    end
  end
end
