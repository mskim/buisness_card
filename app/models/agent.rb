# == Schema Information
#
# Table name: agents
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  cell       :string
#  bank_info  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Agent < ActiveRecord::Base
  has_many :printers
    
end
