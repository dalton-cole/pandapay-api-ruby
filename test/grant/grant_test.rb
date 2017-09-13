require './test/test_helper'

class PandaPayGrantTest < Minitest::Test
	def test_exists
		assert PandaPay::Grant
	end

	def test_it_creates_a_grant
		VCR.use_cassette('created_grant') do
			grant = PandaPay::Grant.create(destination: "95-4604782", amount: "5000")
			assert_equal PandaPay::Grant, grant.class
			assert_equal "95-4604782", grant.destination
			assert_equal 5000, grant.amount
			assert_equal "grant", grant.object
			assert_equal true, grant.respond_to?(:id)
			assert_equal true, grant.respond_to?(:created)
			assert_equal true, grant.respond_to?(:livemode)
			assert_equal true, grant.respond_to?(:status)
			assert_equal true, grant.respond_to?(:currency)
			assert_equal true, grant.respond_to?(:type)
			assert_equal true, grant.respond_to?(:restriction)
			assert_equal false, grant.respond_to?(:force_false)
		end
	end

	def test_it_errors_if_no_amount
		assert_raises ArgumentError do
			PandaPay::Grant.create(destination: "95-4604782")
		end
	end

	def test_it_errors_if_no_destination
		assert_raises ArgumentError do
			PandaPay::Grant.create(amount: "5000")
		end
	end
end