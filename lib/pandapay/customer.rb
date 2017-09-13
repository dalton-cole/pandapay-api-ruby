module PandaPay
	class Customer

		attr_reader :id, :object, :email, :livemode, :cards
		
		def initialize(attributes)
			@id = attributes["id"]
			@object = attributes["object"]
			@email = attributes["email"]
			@livemode = attributes["livemode"]
			@cards = attributes["cards"]
		end
		
		def self.create(email: , source: )
			conn = Faraday.new(:url => "https://#{PandaPay.secret_key}:@#{PandaPay_API_URL}")     
			response = conn.post '/v1/customers', { :email => email, :source => source}
			attributes = JSON.parse(response.body)
			if attributes.has_key? "error" or attributes.has_key? "errors"
				raise response.body
			else 
				new(attributes)
			end
		end

		def self.update(customer_id: , email: nil, source: nil)
			params = {}
			unless email.nil?
				params[:email] = email
			end 
			unless source.nil?
				params[:source] = source
			end 
			conn = Faraday.new(:url => "https://#{PandaPay.secret_key}:@#{PandaPay_API_URL}")     
			response = conn.put "/v1/customers/#{customer_id}", params
			attributes = JSON.parse(response.body)
			if attributes.has_key? "error" or attributes.has_key? "errors"
				raise response.body
			else 
				new(attributes)
			end
		end

		def self.delete(customer_id: )
			conn = Faraday.new(:url => "https://#{PandaPay.secret_key}:@#{PandaPay_API_URL}")     
			response = conn.delete "/v1/customers/#{customer_id}"
			attributes = JSON.parse(response.body)
			if attributes.has_key? "error" or attributes.has_key? "errors"
				raise response.body
			else 
				new(attributes)
			end
		end
	end
end