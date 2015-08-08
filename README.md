# BusinessCard(www.namecard.me)

BusinessCard is a Rails App for managing and creating business cards for printers. We are setuping an web site for printers to create edit and take print orders from their customers.
Our customers are printers, usually ones with digital printers.
Printers customers are small to medium sized companies.

Using pgscript and Dropbox
Instead of using page layout application, such as InDesing or Quark, we use PageScript to create business card templates and created pdf with variable data. PageScript is a Ruby DSL for page layout.
PageScript uses Cocoa framework, using MacRuby,(now Rubymotion)
PageScript can eval templates created in Ruby Code and turn them into Objects that can generate NSView and PDF, taking full advantage of Mac graphics power.

## How it works
For each printer, we set up Dropbox to sync resources from and to the printers. 

Each printer's folder is created in Server's Dropbox folder with printers email
Each printer's client company folder is created under printers folder
Each compnay folder has 
	1. data.csv
		member data
	2. layout.erb.rb
		pgscript layout with variable elements
	3. /images
		images such as logo, background images are stored here.
	4. /pdf
		generated namecard are stored here
		step and repeated for A3 pdf are stored here
	5. /qrcode
		generated qrcode is stored here
	6. /pictures
		member pictures are stored here
		
### Members are parsed from data.csv and store in member db
### Member cards are created
		stored in dropbox for printes to get access
		sym linked to Rails/public/company/id/ for web server showing
### When member data is edited, pdf file is updated
### When member data is updated, data.csv is updated with latest data from server db.

### ordering print job
	member orders print 
	order is created and email is sent to printer
	step and repeated card is created for the memeber, if needed
	printer take pdf files from his Dropbox folder and prints them.
	
## Tables
Agent
	name
	email
	cell
	
Printer (Printer)
	name
	email
	cell
	
	belongs_to :agent
	has_many :companies
	has_many :orders

Company
	belongs_to :printer
	contact
	email
	company_info
	
Member
	name
	email
	title
	division
	cell
	member_info
	belongs_to :company

Order
	printer
	member
	unit_ordered
	delivery_method

	belongs_to :printer


## Role
Admin, 
	can do everything
Agent, 
	agents are the sales people who recited printers
	can create new printer
Printer, 
	can create new company
	can create new member
Member
	can edit his own data
	can order his card
	
## Welcome Page
	- login, for admin, agent, printers
	- sign-up
	
	email input field

## Member show page
## Member edit page

## Member order page

## About Page

## ContactUs Nearest Printers Page









