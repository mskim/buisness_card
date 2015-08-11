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
  
  def preview_page_1
    "/#{company_id}/#{name}_1.jpg"
    # "/#{company_id}/1.jpg"
  end
  
  def preview_page_2
    "/#{company_id}/#{name}_2.jpg"
    # "/#{company_id}/2.jpg"
  end
  
  def setup
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_dropbox_path}") unless File.exist?(company_dropbox_path)
  end
  
  def generate_pdf
    template_file   = File.open("#{layout_company_erb_path}", 'r').read
    @name           = name
    @email          = email
    variables.each do |key, value|
      # puts "key:#{key}"
      # puts "value:#{value}"
      instance_eval("@#{key}='#{value}'")
    end
    erb = ERB.new(template_file)
    layout = erb.result(binding)
    File.open(member_template_path, 'w'){|f| f.write layout}
    system("/Applications/rjob.app/Contents/MacOS/rjob #{company_dropbox_path} #{member_template_path} #{member_dropbox_pdf_path} -jpg")
    # move jpg files to
    system("mv #{member_preview1_dropbox_path} #{company_path}/")
    system("mv #{member_preview2_dropbox_path} #{company_path}/")
  end
  
  def generate_step_n_repreat
    
  end
end
