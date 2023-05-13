require 'rails_helper'
require 'webmock/rspec'


RSpec.describe PropertiesController, type: :controller do
  describe 'GET #index' do
    it 'fetches properties from the API' do
      url = 'https://api.stagingeb.com/v1/properties?page=1&limit=50'
      response_body = { 'content' => [{ 'id' => 1, 'title' => 'Property 1' }] }.to_json

      stub_request(:get, url)
        .to_return(status: 200, body: response_body, headers: { 'Content-Type': 'application/json' })

      get :index

      expect(response).to have_http_status(200)
      expect(assigns(:next_page)).to eq(nil)
    end
  end

  describe 'GET #next_page' do
    it 'fetches properties from the next page URL' do
      url = 'https://api.stagingeb.com/v1/properties?page=2&limit=50'
      response_body = { 'content' => [{ 'id' => 2, 'title' => 'Property 2' }] }.to_json

      stub_request(:get, url)
        .to_return(status: 200, body: response_body, headers: { 'Content-Type': 'application/json' })

      get :next_page, params: { url: url }

      expect(response).to have_http_status(200)
      expect(assigns(:next_page)).to eq(nil)
      expect(response).to render_template(:index)
    end
  end
end
