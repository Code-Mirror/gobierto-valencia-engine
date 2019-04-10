# frozen_string_literal: true

require "savon"

class GobiertoValenciaEngine
  class ActionMailer
    class Base
      def initialize( options = {} )

        @client = Savon.client(
          wsdl: options[:wsdl],
          ssl_verify_mode: :none,
          log: true,
          log_level: :info,
          pretty_print_xml: true
        )
      end

      def send_email(options = {})
      end
      def send_raw_email(mail, args = {})
        xml_message = <<-XML
<soapenv:Envelope xmlns:not="http://www.valencia.es/services/ayWebFwk/NotificationServiceDomain/NotificationService"
  xmlns:not1="http://xmlns.oracle.com/ias/pcbpel/NotificationService"
  xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:v10="http://www.valencia.es/services/esb/ayWebFwk/NotificationService/v10">
  <soapenv:Header>
    <wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
      xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
      <wsse:UsernameToken wsu:Id="UsernameToken-02727E4E6871D5520C15474594702081">
        <wsse:Username>UPCARSER</wsse:Username>
        <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">carser46250p</wsse:Password>
      </wsse:UsernameToken>
    </wsse:Security>
  </soapenv:Header>
  <soapenv:Body>
    <v10:SendEmailNotificationsRequest version="1.0">
      <not:Email>
        <not1:To>#{mail.to.first}</not1:To>
        <not1:Subject>#{mail.subject}</not1:Subject>
        <not1:Content>
          <not1:MimeType>text/html</not1:MimeType>
          <not1:ContentBody>#{::ActionController::Base.helpers.strip_tags(mail.body.to_s)}</not1:ContentBody>
          <not1:ContentEncoding>UTF-8</not1:ContentEncoding>
        </not1:Content>
        <not1:NotificationContext></not1:NotificationContext>
      </not:Email>
    </v10:SendEmailNotificationsRequest>
  </soapenv:Body>
</soapenv:Envelope>
XML

        @client.call(
          :send_email_notifications,
          xml: xml_message
        )
      end

      alias :deliver! :send_raw_email
      alias :deliver  :send_raw_email
    end
  end
end
