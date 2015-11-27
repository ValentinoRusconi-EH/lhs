require 'rails_helper'

describe LHS::Service do
  let(:datastore) { 'http://local.ch/v2' }

  before(:each) do
    LHC.config.placeholder(:datastore, datastore)
    class SomeService < LHS::Service
      endpoint ':datastore/content-ads/:campaign_id/feedbacks'
      endpoint ':datastore/content-ads/:campaign_id/feedbacks/:id'
      endpoint ':datastore/feedbacks'
      endpoint ':datastore/feedbacks/:id'
    end
  end

  context 'find_by' do
    it 'finds a single record' do
      stub_request(:get, "#{datastore}/feedbacks/z12f-3asm3ngals?limit=1")
        .to_return(status: 200, body: load_json(:feedback))
      expect(
        SomeService.find_by(id: 'z12f-3asm3ngals').source_id
      ).to be_kind_of String
    end

    it 'returns nil if no record was found' do
      stub_request(:get, "#{datastore}/feedbacks/something-inexistent?limit=1")
        .to_return(status: 404)
      expect(
        SomeService.find_by(id: 'something-inexistent')
      ).to eq nil
    end

    it 'return first item by parameters' do
      json = load_json(:feedbacks)
      stub_request(:get, "#{datastore}/feedbacks?has_reviews=true&limit=1")
        .to_return(status: 200, body: json)
      expect(
        SomeService.find_by(has_reviews: true).id
      ).to eq json['items'].first['id']
    end
  end

  context 'find_by!' do
    it 'raises if nothing was found with parameters' do
      stub_request(:get, "#{datastore}/feedbacks?has_reviews=true&limit=1")
        .to_return(status: 200, body: { items: [] }.to_json)
      expect { SomeService.find_by!(has_reviews: true) }
        .to raise_error LHC::NotFound
    end
  end
end
