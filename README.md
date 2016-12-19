# BusinessCard(www.namecard.name)

BusinessCard is a Rails app for managing and creating business cards for printers. BusinessCard app provides web site for printers to create edit and take print orders from their customers.
BusinessCard customers are printers, usually ones with digital printers.
Printers customers are small to medium sized companies.
Members information is entered in batch mode with csv file.
csv file can be configured with flexible input elements. multiple lanugage items, such as en_name, ch_name, kr_name can be suppoerted for multiple languge business_card

Members can find their own card and edit their own business card at the site by entering their email.

## qrcode generating
qrcode can be generated for each member in vcard format, making it possible to automatically insert each member information to smart phone address book.  

## multiple language business card

generating various combinations of different language card is possible.

1. English front and Chinese back 
1. Chinese front and  English back 
1. English front and Japanese back
1. Korean front and Chinese back 

## How it works
Using pgscript and Dropbox
Instead of using page layout application, such as InDesing or Quark, we use PageScript to create business card templates and created pdf with variable data. PageScript is a Ruby DSL for page layout.
PageScript uses Cocoa framework, using MacRuby,(now Rubymotion)
PageScript can eval templates created in Ruby Code and turn them into Objects that can generate NSView and PDF, taking full advantage of Mac graphics power, such as PDF engine, OTF fonts, and color profile.

For each printer, we set up Dropbox to sync resources from and to the printers. Each printer's folder is created in Server's Dropbox folder with printers email. Each printer's client company folder is created under printers folder

Each compnay folder has 

	1. data.csv: member data
		
	2. layout.erb.rb: pgscript layout with variable elements
	
	3. /images: images such as logo, background images are stored here.

	4. /pdf: generated namecard are stored here, step and repeated for A3 pdf are stored here
	
	5. /qrcode: generated qrcode is stored here
	
	6. /pictures: member pictures are stored here
		
### Members are parsed from data.csv and store in member db
### Member cards are created
		stored in dropbox for printes to get access
		sym linked to Rails/public/company/id/ for web server showing
### When member data is edited, pdf file is updated
### When member data is updated, data.csv is updated with latest data from server db.

### ordering print job
1. member orders print 
1. order is created and email is sent to printer
1. step and repeated card is created for the memeber, if needed
1. pdf and files and step and repeated card are dropped to printer's Dropbox.


