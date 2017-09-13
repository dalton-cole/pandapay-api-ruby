require './test/test_helper'

class PandaPayDonationTest < Minitest::Test
	def test_exists
		assert PandaPay::Donation
	end

	def test_it_creates_a_donation
		VCR.use_cassette('created_donation') do
			donation = PandaPay::Donation.create(source: "MkZO20xPRPf1segAvqxXihZPd1N", receipt_email: "firsttest@PandaPay.io", amount: "5000")
			assert_equal PandaPay::Donation, donation.class
			assert_equal "firsttest@PandaPay.io", donation.receipt_email
			assert_equal 5000, donation.charge_amount
			assert_equal "donation", donation.object
			assert_equal "MkZO20xPRPf1segAvqxXihZPd1N", donation.payment_token
			assert_equal true, donation.respond_to?(:id)
			assert_equal true, donation.respond_to?(:created)
			assert_equal true, donation.respond_to?(:livemode)
			assert_equal true, donation.respond_to?(:platform_fee)
			assert_equal true, donation.respond_to?(:donation_after_fees)
			assert_equal true, donation.respond_to?(:currency)
			assert_equal true, donation.respond_to?(:customer)
			assert_equal true, donation.respond_to?(:grants)
			assert_equal true, donation.respond_to?(:destination)
			assert_equal true, donation.respond_to?(:restriction)
			assert_equal false, donation.respond_to?(:force_false)
		end
	end

	def test_it_errors_if_no_amount
		assert_raises ArgumentError do
			PandaPay::Donation.create(receipt_email: "test@PandaPay.io", source: "MkZO20xPRPf1segAvqxXihZPd1N")
		end
	end

	def test_it_errors_if_no_payment_source
		assert_raises ArgumentError do
			PandaPay::Donation.create(amount: "5000", receipt_email: "test@PandaPay.io")
		end
	end

	def test_it_errors_if_no_receipt_email
		assert_raises ArgumentError do
			PandaPay::Donation.create(amount: "5000", source: "MkZO20xPRPf1segAvqxXihZPd1N")
		end
	end
end
