namespace :bcard do
  
  task :generate_pdf =>:environment do
    puts "generating pdf for all members"
    Member.all.each do |member|
      member.generate_pdf
    end 
    
  end
  
end