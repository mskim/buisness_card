# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  contact    :string
#  email      :string
#  variables  :text
#  user_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Company < ActiveRecord::Base
  belongs_to :user
  serialize :variables, Hash
  has_many :members
  
  def printer
    user
  end
  
  def company_path
    "#{Rails.root}/public/#{id}"
  end
  
  def company_data_path
    "#{Rails.root}/public/#{id}/data"
  end
  
  def company_preview_path
    "#{Rails.root}/public/#{id}/preview"
  end
  
  def company_dropbox_qrcode_path 
    company_dropbox_path + "/images/qrcode"
  end
    
  def company_dropbox_picture_path
    company_dropbox_path + "/images/picture"
  end
  
  def company_dropbox_path
    printer.printer_dropbox_path + "/#{name}"
  end
  
  def setup
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_data_path}") unless File.exist?(company_data_path)
    system("mkdir -p #{company_preview_path}") unless File.exist?(company_preview_path)
    system("mkdir -p #{company_dropbox_path}") unless File.exist?(company_dropbox_path)
    system("mkdir -p #{company_dropbox_qrcode_path}") unless File.exist?(company_dropbox_qrcode_path)
    system("mkdir -p #{company_dropbox_picture_path}") unless File.exist?(company_dropbox_picture_path)
  end
  
  def parse_company_info
    company_info_path = company_path + "/company_info.yml"
    puts "company_info_path:#{company_info_path}"
    if File.exists?(company_info_path)
      h= YAML::load_file(company_info_path) 
      puts "company_info.class:#{company_info.class}"
      puts "h.class:#{h.class}"
      puts "h:#{h}"
      company_info = h
    else
      puts "company_info.yml does not exist!!"
    end
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
  
  def generate_member_qrcode
    members.each do |member|
      member.generate_qrcode
    end
  end
end

