module PandaPay
	class Donation
		attr_reader :id, :object, :created, :livemode, :charge_amount, :platform_fee, :donation_after_fees, :currency, :payment_token, :customer, :grants, :receipt_email, :destination, :restriction
		
		def initialize(attributes)
			@id = attributes["id"]
			@object = attributes["object"]
			@created = attributes["created"]
			@livemode = attributes["livemode"]
			@charge_amount = attributes["charge_amount"]
			@platform_fee = attributes["platform_fee"]
			@donation_after_fees = attributes["donation_after_fees"]
			@currency = attributes["currency"]
			@payment_token = attributes["payment_token"]
			@customer = attributes["customer"]
			@grants = attributes["grants"]
			@receipt_email = attributes["receipt_email"]
			@destination = attributes["destination"]
			@restriction = attributes["restriction"]
		end
		
		def self.create(amount: , destination: "", restriction: "", source: , receipt_email: , platform_fee: "0", currency: "USD")
			conn = Faraday.new(:url => "https://#{PandaPay.secret_key}:@#{PandaPay_API_URL}")     
			response = conn.post '/v1/donations', { :amount => amount, :currency => currency, :source => source, :receipt_email => receipt_email, :platform_fee => platform_fee, :destination => destination, :restriction => restriction }
			attributes = JSON.parse(response.body)
			if attributes.has_key? "error" or attributes.has_key? "errors"
				raise response.body
			else 
				new(attributes)
			end
		end
	end 
end