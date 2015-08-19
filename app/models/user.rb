class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :companies
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def printer_dropbox_path
   user_path = File.expand_path("~")
   "#{user_path}/Dropbox/#{email}"
  end

  def setup
   system("mkdir -p #{printer_dropbox_path}") unless File.exist?(printer_dropbox_path)
  end
  
end
