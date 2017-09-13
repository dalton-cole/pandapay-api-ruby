require_relative "pandapay/version"
require_relative "pandapay/customer"
require_relative "pandapay/donation"
require_relative "pandapay/grant"
require 'faraday'
require 'json'

PandaPay_API_URL = "api.pandapay.io"

module PandaPay
	class << self
		attr_accessor :secret_key
	end
end