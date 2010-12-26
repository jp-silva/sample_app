# == Schema Information
# Schema version: 20101225185605
#
# Table name: participantes
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  concurso_id :integer
#  dataRegisto :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Participante < ActiveRecord::Base
end
