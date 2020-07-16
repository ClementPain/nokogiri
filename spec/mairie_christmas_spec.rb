require_relative '../lib/mairie_christmas'

page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))


describe 'the get_townhall_email method' do
	it "works" do
		expect(get_townhall_email(Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/ableiges.html"))).text).to eq("mairie.ableiges95@wanadoo.fr")
	end

end

describe 'the get_townhall_urls method' do
	it "works" do
		expect(get_townhall_urls(Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html")))).not_to be_nil
	end
end

describe 'the get_all_emails method' do
	it "works" do
		expect(get_all_emails(Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html")))).not_to be_nil
		expect(get_all_emails(Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html")))).to be_an(Array)
	end
end