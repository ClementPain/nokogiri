require 'rubygems'
require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))

names = page.xpath('//span[@class="list_nom"]')


def deputes_contact(list_names)

	deputes_contact_array = []

	my_hash = {}

	for i in 0..400#( list_names.length - 1 )
		if !list_names[i].nil?
			my_hash["first_name"] = list_names[i].text.split(', ')[1].strip
			my_hash["last_name"] = list_names[i].text.split(', ')[0].strip
			my_hash["email"] = find_emails(my_hash["first_name"], my_hash["last_name"])

			deputes_contact_array << my_hash

			my_hash = Hash.new
		end
	end

	return deputes_contact_array
end



def find_emails(firstname, lastname)

	first_name_mail = firstname.downcase.unicode_normalize(:nfkd).encode('ASCII', replace: '').gsub(/[ ']/, "-")

	last_name_mail = lastname.downcase.gsub(/[ö]/, "oe").unicode_normalize(:nfkd).encode('ASCII', replace: '').gsub(/[ ']/, "-")

	last_name_mail = last_name_mail.partition("-").first if last_name_mail.include? ("cloa")

	page = Nokogiri::HTML(open("https://www.nosdeputes.fr/#{first_name_mail}-#{last_name_mail}"))

	mail = page.xpath('//li[text()[contains(., "Par e-mail")]]//a[text()[contains(., "@")]]')[0]

	if mail.nil?
		return ""
	else
		return mail.text
	end
end

# puts find_emails("damien", "abad")

puts deputes_contact(names)