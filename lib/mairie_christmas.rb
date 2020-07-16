require 'rubygems'
require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

def get_townhall_email(page)

	emails = page.xpath('//section[@class="well section-border"]/div[@class="container"]/table[@class="table table-striped table-mobile mobile-primary round-small"]//tr[@class="txt-primary tr-last"]/td[text()[contains(., "@")]]')

	emails.each do |email|
		puts email.text
	end
end

def get_townhall_urls(page)

	townhalls = page.xpath('//td[@bgcolor="#EEEAEA"]/table[@class="Style20"]//p/a[text()]')
	
end

def get_all_emails(page)
	
	get_townhall_urls(page).each do |town|
	
		get_townhall_email(Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/#{town.text.downcase.gsub(/[ ]/, "-")}.html")))
	end
end


get_all_emails(page)