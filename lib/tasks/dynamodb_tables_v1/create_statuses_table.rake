# lib/tasks/dynamodb_tables_v1/create_activity_table.rake
# Rake task to create activities table 

namespace :dynamodb_tables_v1 do
    desc "bundle exec rake dynamodb_tables_v1:create_statuses_table RAILS_ENV=<ENV>"
    task :create_statuses_table => :environment do
      puts "Creating statuses table in #{Rails.env}\n"
      create_statuses_table
      puts "Completed task\n"
    end
  
    def create_statuses_table
  
      params = {
          table_name: 'statuses', # required
          key_schema: [ # required
              {
                  attribute_name: 'name', # required User:1
                  key_type: 'HASH', # required, accepts HASH, RANGE
              },
              {
                  attribute_name: 'created_at', # timestamp
                  key_type: 'RANGE'
              }
          ],
          attribute_definitions: [ # required
              {
                  attribute_name: 'name', # required
                  attribute_type: 'S', # required, accepts S, N, B
              },
              {
                  attribute_name: 'created_at', # Timestamp
                  attribute_type: 'N', # required, accepts S, N, B
              }
          ],
  
          provisioned_throughput: { # required
                                    read_capacity_units: 5, # required
                                    write_capacity_units: 5, # required
          }
      }
  
      begin
        result = DynamodbClient.client.create_table(params)
        puts 'Created table: statuses\n Status: ' + result.table_description.table_status;
      rescue Aws::DynamoDB::Errors::ServiceError => error
        puts 'Unable to create table: statuses\n'
        puts "#{error.message}"
      end
    end
  end