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

require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  test "agent should have name" do
    agent = Agent.new(name: "Min Soo Kim")
    assert agent.name == "Min Soo Kim"
  end
  
end
