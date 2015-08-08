# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  quantity   :integer
#  status     :string
#  delivery   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
end
