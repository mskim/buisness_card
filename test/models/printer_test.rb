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

require 'test_helper'

class PrinterTest < ActiveSupport::TestCase
  test "Printer should have a email" do
    printer = Printer.new(email: "someemail@google.com")
    assert_not printer.email ==nil?
  end
  
  test "Printer should have a dropbox path" do
    printer = Printer.new(email: "somesemail@google.com")
    assert printer.printer_dropbox_path =="/Users/mskim/Dropbox/somesemail@google.com" , "should be #{printer.printer_dropbox_path}"
  end
end
