# == Schema Information
# Schema version: 20101227164221
#
# Table name: funcaos
#
#  id         :integer         not null, primary key
#  func       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Function < ActiveRecord::Base
  attr_accessible :func
  
  validates :func, :presence=>true, :length => { :maximum => 200 }
end
