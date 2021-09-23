require 'httparty'
require 'aws-sdk-route53'

loop do
  hosted_zone_id = ENV['HOSTED_ZONE_ID']
  ip = HTTParty.get('https://ifconfig.me/ip').body

  change = {
    action: 'UPSERT',
    resource_record_set: {
      name: ENV['DOMAIN'],
      type: 'A',
      ttl: 300,
      resource_records: [{ value: ip }]
    }
  }

  r53 = Aws::Route53::Client.new
  r53.change_resource_record_sets(hosted_zone_id: hosted_zone_id,
                                  change_batch: { changes: [ change ] })

  sleep 300
end
