class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :companies
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def user_dropbox_path
   "#{File.expand_path("~")}/Dropbox/#{email}"
  end

  def setup
   system("mkdir -p #{user_dropbox_path}") unless File.exist?(user_dropbox_path)
  end
  
end
