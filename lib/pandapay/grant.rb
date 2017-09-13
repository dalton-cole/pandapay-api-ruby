module PandaPay
	class Grant

		attr_reader :id, :object, :created, :livemode, :amount, :status, :currency, :type, :destination, :restriction
		
		def initialize(attributes)
			@id = attributes["id"]
			@object = attributes["object"]
			@created = attributes["created"]
			@livemode = attributes["livemode"]
			@amount = attributes["amount"]
			@status = attributes["status"]
			@currency = attributes["currency"]
			@type = attributes["type"]
			@destination = attributes["destination"]
			@restriction = attributes["restriction"]
		end
		
		def self.create(amount: , destination: , restricted: "", currency: "USD")
			conn = Faraday.new(:url => "https://#{PandaPay.secret_key}:@#{PandaPay_API_URL}")     
			response = conn.post '/v1/grants', {:restricted => restricted, :amount => amount, :currency => currency, :destination => destination}
			attributes = JSON.parse(response.body)
			if attributes.has_key? "error" or attributes.has_key? "errors"
				raise response.body
			else 
				new(attributes)
			end
		end
	end
end