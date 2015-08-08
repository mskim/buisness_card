# == Schema Information
#
# Table name: printers
#
#  id         :integer          not null, primary key
#  name       :string
#  contact    :string
#  email      :string
#  cell       :string
#  agent_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Printer < ActiveRecord::Base
  belongs_to :agent
  has_many :companies
  
  def printer_dropbox_path
    user_path = File.expand_path("~")
    "#{user_path}/Dropbox/#{email}"
  end
  
  def setup
    system("mkdir -p #{printer_dropbox_path}") unless File.exist?(printer_dropbox_path)
  end
end
