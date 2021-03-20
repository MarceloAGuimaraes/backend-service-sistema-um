require 'net/http'

class SistemaDoisService
  HOST = 'http://localhost:4000/api/v1/address_coordinates'

  def initiliaze; end

  def call(request_id, address)
    uri = URI(HOST)
    params = { address: address, request_id: request_id }
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end
end
