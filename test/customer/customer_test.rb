require './test/test_helper'

class PandaPayCustomerTest < Minitest::Test
	def test_exists
		assert PandaPay::Customer
	end

	def test_it_creates_a_customer
		VCR.use_cassette('created_customer') do
			customer = PandaPay::Customer.create(email: "test_email@PandaPay.io", source: "QD4gs3Fonhc2AIanNdsqM5lygVf")
			assert_equal PandaPay::Customer, customer.class
			assert_equal "test_email@PandaPay.io", customer.email
			assert_equal "customer", customer.object
			assert_equal true, customer.respond_to?(:id)  		
			assert_equal true, customer.respond_to?(:cards)
			assert_equal true, customer.respond_to?(:livemode)
			assert_equal false, customer.respond_to?(:force_false)
		end
	end

	def test_it_errors_on_create_if_no_email
		assert_raises ArgumentError do
			PandaPay::Customer.create(source: "QD4gs3Fonhc2AIanNdsqM5lygVf")
		end
	end

	def test_it_errors_on_create_if_no_payment_source
		assert_raises ArgumentError do
			PandaPay::Customer.create(email: "test_email@PandaPay.io")
		end
	end


	def test_it_updates_a_customer
		VCR.use_cassette('updated_customer') do
			customer = PandaPay::Customer.update(customer_id: "cus_0moNz0xVxp11OTPncj7w9Q", email: "new_test_email@PandaPay.io")
			assert_equal PandaPay::Customer, customer.class
			assert_equal "new_test_email@PandaPay.io", customer.email
			assert_equal "customer", customer.object
			assert_equal true, customer.respond_to?(:id)  		
			assert_equal true, customer.respond_to?(:cards)
			assert_equal true, customer.respond_to?(:livemode)
			assert_equal false, customer.respond_to?(:force_false)
		end
	end

	def test_it_errors_on_update_if_no_customer_id
		assert_raises ArgumentError do
			PandaPay::Customer.update(email: "new_test_email@PandaPay.io")
		end
	end


	def test_it_deletes_a_customer
		VCR.use_cassette('deleted_customer') do
			customer = PandaPay::Customer.delete(customer_id: "cus_0moNz0xVxp11OTPncj7w9Q")
			assert_equal PandaPay::Customer, customer.class
			assert_equal "new_test_email@PandaPay.io", customer.email
			assert_equal "customer", customer.object
			assert_equal true, customer.respond_to?(:id)  		
			assert_equal true, customer.respond_to?(:cards)
			assert_equal true, customer.respond_to?(:livemode)
			assert_equal false, customer.respond_to?(:force_false)
		end
	end

	def test_it_errors_on_delete_if_no_customer_id
		assert_raises ArgumentError do
			PandaPay::Customer.delete
		end
	end
end  