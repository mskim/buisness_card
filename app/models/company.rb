# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  contact    :string
#  email      :string
#  variables  :text
#  printer_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Company < ActiveRecord::Base
  belongs_to :printer
  serialize :variables, Hash
  
  def company_path
    "#{Rails.root}/public/#{id}"
  end
  
  def company_dropbox_path
    printer.printer_dropbox_path + "/#{name}"
  end
  
  def setup
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_dropbox_path}") unless File.exist?(company_dropbox_path)
  end
  
  def parse_members
    require 'csv'
    csv_path = company_dropbox_path + "/data.csv"
    puts "csv_path:#{csv_path}"
    unless File.exist?(csv_path)
      puts "data file not found!!!"
      return
    end
    csv   = File.open(csv_path, 'r'){|f| f.read}
    rows  = CSV.parse(csv)
    keys  = rows.shift
    name_index = keys.index('name')
    email_index = keys.index('email')
    keys.delete('name')
    keys.delete('email')
    rows.each do |row|
      name = row[name_index]
      email = row[email_index]
      row.delete_at(email_index)
      row.delete_at(name_index)
      h = Hash[keys.zip row]
      member = Member.where(company_id: self, name: name, email: email).first_or_create
      member.variables = h
      member.save!
    end
  end
  
  def generate_member_pdf
    members.each do |member|
      member.generate_pdf
    end
  end
end

