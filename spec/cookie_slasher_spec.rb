# coding: utf-8

describe CookieSlasher do
  include Rack::Test::Methods

  let(:status) { 500 }
  let(:cookie) { 'nope' }
  let :app do
    described_class.new(
      ->(env) { [status, { 'Set-Cookie' => cookie, 'Wat' => '1' }, []] }
    )
  end

  context 'when the response is 200' do
    let(:status) { 200 }
    let(:cookie) { 'yey' }

    it 'leaves the cookies alone' do
      get '/'
      expect(last_response.headers).to include('Set-Cookie' => 'yey')
    end

    it 'leaves other headers alone' do
      get '/'
      expect(last_response.headers).to include('Wat' => '1')
    end
  end

  context 'when the response is 404' do
    let(:status) { 404 }
    let(:cookie) { 'foo' }

    it 'removes cookies' do
      get '/'
      expect(last_response.headers.keys).to_not include('Set-Cookie')
    end

    it 'leaves other headers alone' do
      get '/'
      expect(last_response.headers).to include('Wat' => '1')
    end

  end

  context 'when the response is 301' do
    let(:status) { 301 }
    let(:cookie) { 'bar' }

    it 'removes cookies' do
      get '/'
      expect(last_response.headers.keys).to_not include('Set-Cookie')
    end

    it 'leaves other headers alone' do
      get '/'
      expect(last_response.headers).to include('Wat' => '1')
    end
  end

  context 'when Rails is defined and no custom logger is given' do
    let(:status) { 404 }

    before do
      require 'logger'

      module Rails
        def self.logger
          @logger ||= Logger.new('/dev/null')
        end
      end
    end

    after { Object.send(:remove_const, :Rails) }

    it 'uses Rails.logger.warn' do
      Rails.logger.should_receive(:warn)
      get '/'
    end
  end
end
