require 'rails_helper'

RSpec.describe UsosAuthLib::Configuration do
  subject { UsosAuthLib::Configuration.new }

  it 'has nil as the default value for api_key' do
    expect(subject.api_key).to be_nil
  end

  it 'has nil as the default value for api_secret' do
    expect(subject.api_secret).to be_nil
  end

  it 'has nil as the default value for usos_base_url' do
    expect(subject.usos_base_url).to be_nil
  end

  it 'has nil as the default value for scopes' do
    expect(subject.scopes).to be_nil
  end

  it 'has nil as the default value for redirect_path' do
    expect(subject.redirect_path).to be_nil
  end

  describe '#configure' do
    before do
      UsosAuthLib.configure do |config|
        config.api_key = 'test_key'
        config.api_secret = 'test_secret'
        config.usos_base_url = 'https://usos.test.com'
        config.scopes = 'email|grades'
        config.redirect_path = '/callback'
      end
    end

    it 'allows custom configuration of api_key' do
      expect(UsosAuthLib.configuration.api_key).to eq('test_key')
    end

    it 'allows custom configuration of api_secret' do
      expect(UsosAuthLib.configuration.api_secret).to eq('test_secret')
    end

    it 'allows custom configuration of usos_base_url' do
      expect(UsosAuthLib.configuration.usos_base_url).to eq('https://usos.test.com')
    end

    it 'allows custom configuration of scopes' do
      expect(UsosAuthLib.configuration.scopes).to eq('email|grades')
    end

    it 'allows custom configuration of redirect_path' do
      expect(UsosAuthLib.configuration.redirect_path).to eq('/callback')
    end
  end
end
