module CNPJa
  class Serializer
    def self.call(response)
      new(response).perform
    end

    def initialize(response)
      @response = response
    end

    def perform
      {
        cnpj: body[:taxId],
        city: address_body[:city],
        state: address_body[:state],
        zipCode: address_body[:zip],
        streetName: address_body[:street],
        addressNumber: address_body[:number],
        neighborhood: address_body[:district],
        companyName: company_body[:name],
        tradingName: body[:alias],
        email: email_body[:address],
        phoneNumber: "#{phone_body[:area]}#{phone_body[:number]}".presence,
        cellNumber: "#{cell_body[:area]}#{cell_body[:number]}".presence
      }
    end

    private

    def body
      @body ||= JSON.parse(@response.body, symbolize_names: true)
    rescue JSON::ParserError
      {}
    end

    def address_body
      @address_body ||= body[:address] || {}
    end

    def company_body
      @company_body ||= body[:company] || {}
    end

    def email_body
      @email_body ||= body.dig(:emails, 0) || {}
    end

    def phone_body
      @phone_body ||= body.dig(:phones, 0) || {}
    end

    def cell_body
      @cell_body ||= body.dig(:phones, 1) || {}
    end
  end
end
