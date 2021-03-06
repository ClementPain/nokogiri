require 'rubygems'
require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

def get_townhall_email(page)

	page.xpath('//section[@class="well section-border"]/div[@class="container"]/table[@class="table table-striped table-mobile mobile-primary round-small"]//tr[@class="txt-primary tr-last"]/td[text()[contains(., "@")]]')

end

def get_townhall_urls(page)

	page.xpath('//td[@bgcolor="#EEEAEA"]/table[@class="Style20"]//p/a[text()]')

end

def get_all_emails(page)
	townhall_emails_array = []

	my_hash = Hash.new

	get_townhall_urls(page).each do |town|
	
		my_hash[town.text.capitalize] = get_townhall_email(Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/#{town.text.downcase.gsub(/[ ]/, "-")}.html"))).text
		townhall_emails_array << my_hash
		my_hash = Hash.new
	end

	return townhall_emails_array
end


puts get_all_emails(page)