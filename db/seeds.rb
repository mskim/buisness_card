
agent   = Agent.where(name: "JongSoonWhang", email: "js" ).first_or_create
printer = Printer.where(agent_id: agent.id, name: "Jeil Print", email: "jeil@naver.com" ).first_or_create
company = Company.where(printer_id: printer.id, name: "ChoonMooBank", contact: "Chong Mu Lee", email: "jeil@naver.com" ).first_or_create
