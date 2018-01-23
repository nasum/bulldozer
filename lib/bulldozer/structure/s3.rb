module Bulldozer
  module Structure
    class S3
      def initialize(option)
        @client = Aws::S3::Client.new(
          access_key_id: option[:access_key],
          secret_access_key: option[:secret_access_key]
        )
        @region = option[:region]
      end

      def get(bucket_name, object)
        begin
          @client.get_object({
            bucket: bucket_name,
            key: object,
          })
        rescue Aws::S3::Errors::NoSuchKey => err
          puts "no structure"
        rescue Aws::S3::Errors::NoSuchBucket => err
          puts "no bucket and no structure"
        end
      end

      def put(bucket, name, body)
        @client.put_object(bucket: bucket, key: name, body: body)
      end

      def create(bucket_name)
        begin
          resp = @client.create_bucket({
            acl: 'private',
            bucket: bucket_name,
            create_bucket_configuration: {
              location_constraint: @region,
            }
          })
        rescue Aws::S3::Errors::BucketAlreadyOwnedByYou => err
          puts "bucket is already created"
        end
      end
    end
  end
end
