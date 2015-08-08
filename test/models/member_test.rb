# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  variables  :text
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "member name" do
    member = Member.new(name: "MinSooKim", email: "mskimsid@gmail.com")
    assert member.name == "MinSooKim"
    assert member.email == "mskimsid@gmail.com"
  end
  
  test "member pdf path" do
    company = Company.create(name: "some_company")
    member = Member.create(company_id: company.id, name: "MinSooKim", email: "mskimsid@gmail.com")
    assert member.member_pdf_path == "/Users/mskim/Development/rails4/buisness_card/public/980190963/MinSooKim.pdf", "#{member.member_pdf_path}"
  end
end
