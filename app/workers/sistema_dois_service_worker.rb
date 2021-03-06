require 'net/http'

class SistemaDoisServiceWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true
  HOST = 'http://172.25.0.6:4000/api/v1/address_coordinates'.freeze

  def perform(request_id, address)
    uri = URI(HOST)
    params = { address: address, request_id: request_id }
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end
end
