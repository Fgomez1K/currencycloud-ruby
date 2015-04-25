require 'spec_helper'
require 'net/http'

describe 'Authentication', :vcr => true do
  before(:each) do
    CurrencyCloud.environment = :demonstration
    CurrencyCloud.login_id = 'rjnienaber@gmail.com'
    CurrencyCloud.api_key = 'ef0fd50fca1fb14c1fab3a8436b9ecb65f02f129fd87eafa45ded8ae257528f0'
    CurrencyCloud.token = nil
  end

  after(:each) do
    CurrencyCloud.reset_session
  end

  it 'happens lazily' do
    expect(CurrencyCloud.session).to_not be_nil
    expect(CurrencyCloud.session.token).to eq('57ef449f6316f2f54dfec37c2006fe50')
  end

  it 'can use just a token' do
    CurrencyCloud.login_id = nil
    CurrencyCloud.api_key = nil
    CurrencyCloud.token = '7fbba909f66ee6721b2e20a5fa1ccae7'

    response = CurrencyCloud::Beneficiary.find
    expect(response).to_not be_nil
  end

  it 'can be closed' do
    CurrencyCloud.session 
    expect(CurrencyCloud.close_session).to eq(true)
  end

  it 'handles session timeout error' do
    CurrencyCloud.token = '3907f05da86533710efc589d58f51f45'

    response = CurrencyCloud::Beneficiary.find
    expect(response).to_not be_nil
  end
end