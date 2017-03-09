require_relative 'plaid_test'

# Internal: The test for Plaid::CreditDetails.
class PlaidCreditDetailsTest < PlaidTest
  def setup
    @client = create_client
    @item = @client.item.create(credentials: CREDENTIALS,
                                institution_id: SANDBOX_INSTITUTION,
                                initial_products: [:credit_details])
    @access_token = @item['access_token']
  end

  def teardown
    @client.item.delete(@access_token)
  end

  def test_get
    response = @client.credit_details.get(@access_token)
    refute_empty(response['accounts'])
    refute_empty(response['credit_details'])
  end

  def test_get_invalid_access_token
    assert_raises(Plaid::InvalidInputError) do
      @client.credit_details.get(BAD_STRING)
    end
  end
end
