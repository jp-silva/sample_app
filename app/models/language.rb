# == Schema Information
# Schema version: 20101227164221
#
# Table name: linguagems
#
#  id         :integer         not null, primary key
#  ling       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
    attr_accessible :ling
    
    validates :ling, :presence=>true,:length => { :maximum => 200 }
end
