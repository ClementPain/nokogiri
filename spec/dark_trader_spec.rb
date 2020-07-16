require_relative '../lib/dark_trader'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
currencies = page.xpath('//div[@class="cmc-table__column-name sc-1kxikfi-0 eTVhdN"]//a[@class="cmc-link"]')
rates = page.xpath('//tr[@class="cmc-table-row"]/td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/a[@class="cmc-link"]' )

describe 'the crypto_scrapper method' do

	it 'works'do 
		expect(crypto_scrapper(currencies, rates)).is_a? Array
	end

	it 'contains currencies and rates' do
		expect(crypto_scrapper(currencies, rates).length).to be > 50

		expected_3 = ""
		crypto_scrapper(currencies, rates).each do |hashs|
			expected_3 = hashs["Bitcoin"] if !hashs["Bitcoin"].nil?
		end

		expect(expected_3).is_a? Float
		
	end
end