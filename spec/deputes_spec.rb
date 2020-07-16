require_relative '../lib/deputes'

page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))

names = page.xpath('//span[@class="list_nom"]')


describe 'the find_email method' do
	
	it "works" do
		expect(find_email("damien", "abad")).to eq("damien.abad@assemblee-nationale.fr")
	end
end

describe 'the deputes_contact method' do
	it "works" do
		expect(deputes_contact(names, 0, 2)).not_to be_nil
		expect(deputes_contact(names, 0, 2)).to be_an(Array)
	end
end