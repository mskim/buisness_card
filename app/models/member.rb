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

class Member < ActiveRecord::Base
  belongs_to :company
  serialize :variables, Hash
  
  def self.search(params)
    # where('name like ?',"%#{search}%").order('company_id ASC, name ASC').paginate(:per_page=>20, :page=>page)
    where('email like ?',"#{params[:email]}").order('company_id ASC, name ASC')
    # where('name like ?',"#{search}").order('company_id ASC, name ASC')
  end
  
  def company_path
    company.company_path
  end
  
  def member_pdf_path
    "#{company_path}/#{name}.pdf"
  end
    
  def company_dropbox_path
    company.company_dropbox_path
  end
  
  def member_dropbox_pdf_path
    "#{company_dropbox_path}/#{name}.pdf"
  end
  
  def member_template_path
    # "#{company_path}/laytout_#{name}.rb"
    "#{company_path}/data/layout_#{id}.rb.erb"
  end
    
  def layout_company_erb_path
    # "#{company_path}/layout.rb.erb"
    "#{company_dropbox_path}/layout.rb.erb"
  end
  
  def member_preview1_dropbox_path
    "#{company_dropbox_path}/#{name}_1.jpg"
  end
  
  def member_preview2_dropbox_path
    "#{company_dropbox_path}/#{name}_2.jpg"
  end
  
  def company_preview_path
    "/#{company_path}/preview"
  end
  
  def member_preview1_path
    "#{company_preview_path}/#{name}_1.jpg"
  end
  
  def member_preview2_path
    "#{company_preview_path}/#{name}_2.jpg"
  end
  
  def preview_page_1
    "/#{company_preview_path}/#{name}_1.jpg"
    # "/#{company_id}/1.jpg"
  end
  
  def preview_page_2
    "/#{company_preview_path}/#{name}_2.jpg"
    # "/#{company_id}/2.jpg"
  end
  
  def setup
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_dropbox_path}") unless File.exist?(company_dropbox_path)
  end
  
  def vcard_content
    # company_info = company.company_info
    # puts "company_info:#{company_info}"
    # name      = personal[:name]
    # email     = personal[:email]
    # title     = variables["title"]
    # division  = variables["division"]
    # phone     = variables["phone"]
    # cell      = variables["cell"]
    name_array = name.split(//)  
    last_name = name_array[0].force_encoding('UTF-8')
    name_array.delete_at(0)
    first_name = name_array.join.force_encoding('UTF-8')
    new_string = ""
    @text = new_string.force_encoding('UTF-8')
    @text="BEGIN:VCARD\n"
    @text+="VERSION:2.1\n"
    @text+="N:#{last_name};#{first_name}\n"
    @text+="FN:#{last_name} #{first_name}\n"
    # if company_info[:name]
      # @text+="ORG:#{company_info[:name]}\n" 
    # else
    @text+="ORG:#{company.name}\n" 
    # end
    if variables["title"] && variables["division"]
      if variables["title"] !="" && variables["division"] !=""
        @text+="TITLE:#{variables["title"]}/#{variables["division"]}\n" 
      else
        @text+="TITLE:#{variables["title"]}n" 
      end
    end
    # @text+="PHOTO;JPG:#{member_site_url}"
    if variables["phone"] != ""
      @text+="TEL;WORK;VOICE:#{variables["phone"]}\n" if variables["phone"]
    else
      @text+="TEL;WORK;VOICE:#{variables["cell"]}\n" if variables["cell"]
      
    end
    @text+="TEL;WORK;CELL:#{variables["cell"]}\n" if variables["cell"]
    # @text+="ADR:#{company_info[:street]};#{company_info[:city]};#{company_info[:country]}\n"
    @text+="EMAIL:#{variables["email"]}\n"
    @text+="REV:20080424T195243Z\n"
    @text+="END:VCARD"
    @text
  end
  
  def company_dropbox_qrcode_path
    company.company_dropbox_qrcode_path
  end
  
  def member_qrcode_path
    "#{company_dropbox_qrcode_path}/#{name}.png"
  end
  
  def generate_qrcode
    system("mkdir -p #{company_dropbox_qrcode_path}") unless File.exist?(company_dropbox_qrcode_path)
    system "/usr/local/bin/qrencode -o #{member_qrcode_path} '#{vcard_content}'"
  end
  
  def generate_pdf
    generate_qrcode if true  #if qrcode
    template_file   = File.open("#{layout_company_erb_path}", 'r').read
    @name           = name
    @email          = email
    variables.each do |key, value|
      instance_eval("@#{key}='#{value}'")
    end
    erb = ERB.new(template_file)
    layout = erb.result(binding)
    File.open(member_template_path, 'w'){|f| f.write layout}
    system("/Applications/rjob.app/Contents/MacOS/rjob #{company_dropbox_path} #{member_template_path} #{member_dropbox_pdf_path} -jpg")
    system("mv #{member_preview1_dropbox_path} #{member_preview1_path}")
    system("mv #{member_preview2_dropbox_path} #{member_preview2_path}")
  end
  
  def generate_step_n_repreat
    
  end
end
