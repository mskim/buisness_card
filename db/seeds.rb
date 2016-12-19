
user = nil
if User.count == 0
  user = User.create(name: "mskim", email: "namecard@gmail.com",  password: "love1030")
else
  user = User.first
end
puts "user:#{user}"
if user
  # user = User.where(email: "namecard@gmail.com", password: "love1030", password_confirmation: "love1030" ).first_or_create
  company = Company.where(user_id: user.id, name: "SoftwareLab").first_or_create
  # setup folders
  company.setup
  # parse members from data.csv
  company.parse_members
end