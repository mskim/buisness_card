
# this goes at top left
logo 	= RLayout::Image.new(tag: "logo", local_image: "1.pdf", image_fit_type: 4)
qrcode 	= RLayout::Image.new(tag: "qrcode", local_image: "qrcode/김형규.png", width: 200, height: 200)
# This goes somewhere in the middle
personal = RLayout::Container.new(tag: "personal", width: 150, height: 60) do
  text("김형규", tag: "name", text_size: 12, font: "smGothicP-W70")
  text("대표", tag: "title", text_size: 12, font: "smMyungjoP-W30")
  text("mskimsid@gmail.com", tag: "email", text_size: 12)
  text("010-7468-8222", tag: "cell",  text_size: 12)
  relayout!
end

# This goes at the bottom
company = RLayout::Container.new(tag: "company", width: 200, height: 40) do
  text("102 Happy Rd.", text_size: 10, tag: "address1", text_alignment: "left")
  text("Sung Nam, Kyunggi-Do Korea 11356", tag: "address2", text_size: 10, text_alignment: "left")
  text("www.my_site.com", tag: "www", text_size: 10, text_alignment: "left")
  relayout!
end


# Assign place holders for partials,  
# and replace it with partial graphics above, logo, personal, and company.
# each partial is also replaced with variable data from csv.

front_page = RLayout::Page.new(margin: 10, paper_size: 'NAMECARD', grid_base: "6x6", gutter: 20, v_gutter: 5) do
  container(tag: "logo", grid_frame: [0,0,4,1], layout_expand: nil)
  container(tag: "personal", grid_frame: [2,0,4,3], layout_expand: nil)
  container(tag: "company", grid_frame: [1,4,5,2], layout_expand: nil)
  place(logo)
  place(personal)
  place(company)
end

personal2 = RLayout::Container.new(tag: "personal2", width: 150, height: 60) do
  text("Min Soo Kim", tag: "name", text_size: 12)
  text("CEO", tag: "title", text_size: 12)
  text("mskimsid@gmail.com", tag: "email", text_size: 12)
  text("010-7468-8222", tag: "cell", text_size: 12)
  relayout!
end

back_page = RLayout::Page.new(margin: 10, paper_size: 'NAMECARD', grid_base: "6x6", gutter: 20, v_gutter: 5) do
  container(tag: "qrcode", grid_frame: [2,1,2,4], layout_expand: nil)
  #container(tag: "personal2", grid_frame: [2,0,4,3], layout_expand: nil)
  # container(tag: "company", grid_frame: [1,4,5,2], layout_expand: nil)
  place(qrcode)
  #place(personal2)
  # place(company)
end

RLayout::Document.new(paper_size: 'NAMECARD', initial_page:false) do
  add_page(front_page)
  add_page(back_page)
end