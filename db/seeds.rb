
agent   = Agent.where(name: "Jongsoon Whang", email: "js1896@naver.com" ).first_or_create
printer = Printer.where(agent_id: agent.id, name: "Jeil Print", email: "namecard@gmail.com" ).first_or_create
company = Company.where(printer_id: printer.id, name: "SoftwareLab", contact: "Jeeyoon Kim", email: "jyk0129@gmail.com" ).first_or_create
# setup folders
company.setup
# parse members from data.csv
# company.parse_members