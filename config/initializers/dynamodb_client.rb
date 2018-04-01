## /config/initializers/dynamodb_client.rb
module DynamodbClient
    def self.initialize!
      client_config = if Rails.env.development?
                        {
                          access_key_id: 'AKIAJA2CCM2SXX4VAFCA',
                          secret_access_key: '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',
                          region: 'us-east-2'
                        }
                      else
                        {
                            access_key_id: 'AKIAJA2CCM2SXX4VAFCA',
                            secret_access_key: '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',
                            region: 'us-east-2'
                        }
                      end
      @@client ||= Aws::DynamoDB::Client.new(client_config)
    end
  
    module_function
  
    def client
      @@client
    end
  end