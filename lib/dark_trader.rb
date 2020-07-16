require 'rubygems'
require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))



currencies = page.xpath('//div[@class="cmc-table__column-name sc-1kxikfi-0 eTVhdN"]//a[@class="cmc-link"]')
rates = page.xpath('//tr[@class="cmc-table-row"]/td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/a[@class="cmc-link"]' )


def crypto_scrapper(currencies, rates)
	currencies_rates_array = []

	my_hash = Hash.new

	for i in 0..( currencies.length - 1 )
		
		my_hash[currencies[i].text] = rates[i].text.gsub(/[$,]/, "").to_f
		currencies_rates_array << my_hash
		my_hash = Hash.new

	end
	
	return currencies_rates_array
end

# puts crypto_scrapper(currencies, rates)
