# rubocop:disable Style/GlobalVars
require 'uri'
require 'net/http'
require 'openssl'

class PropertiesController < ApplicationController
  def index(url = 'https://api.stagingeb.com/v1/properties?page=1&limit=50')
    $url = URI(url)

    http = Net::HTTP.new($url.host, $url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new($url)
    request['accept'] = 'application/json'
    request['X-Authorization'] = 'l7u502p8v46ba3ppgvj5y2aad50lb9'

    response = http.request(request)
    result = JSON.parse(response.read_body)

    $properties = result['content']

    if result['pagination'].present?
      @next_page = result['pagination']['next_page']
    end
  end

  def next_page
    to_fetch = params[:url]

    index(to_fetch)

    render :index
  end

  def show
  end
end
# rubocop:enable Style/GlobalVars
