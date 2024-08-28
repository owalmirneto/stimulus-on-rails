require "net/http"

module CNPJa
  class Client
    BASE_URL = "https://api.cnpja.com/office"

    class << self
      def call(cnpj)
        new(cnpj).perform
      end
    end

    def initialize(cnpj)
      @uri = URI("#{BASE_URL}/#{cnpj.to_s.delete("^0-9")}")
    end

    def perform
      Serializer.call(response)
    end

    private

    def response
      Net::HTTP.get_response(@uri, **headers)
    end

    def headers
      {Authorization: Rails.application.credentials.cnpja_token}
    end
  end
end
