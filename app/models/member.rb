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
  
  def member_pdf_path
    "#{company.company_path}/#{name}.pdf"
  end
  
  def member_template_path
    "#{company_path}/laytout_#{name}.rb"
  end
  
  def preview_page_1
    "/#{company_id}/#{name}_1.jpg"
    # "/#{company_id}/1.jpg"
  end
  
  def preview_page_2
    "/#{company_id}/#{name}_2.jpg"
    # "/#{company_id}/2.jpg"
  end
  
  
  def layout_erb_path
    "#{company_path}/layout.rb.erb"
  end
  
  def member_dropbox_pdf_path
    "#{company_dropbox_path}/#{name}.pdf"
  end
  
  def setup
    system("mkdir -p #{company_path}") unless File.exist?(company_path)
    system("mkdir -p #{company_dropbox_path}") unless File.exist?(company_dropbox_path)
  end
  
  def generate_pdf
    template_file   = File.open("#{layout_erb_path}", 'r').read
    @name           = name
    @email          = email
    @variables_hash = variables
    erb     = ERB.new(template_file)
    layout  = erb.result(binding)
    # can I send the file direct to rjob instead of writing to file first?
    File.open(member_template_path, 'w'){|f| f.write layout}
    system("rjob #{member_template_path} #{member_pdf_path}")
  end
  
end
