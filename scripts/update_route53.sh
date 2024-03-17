#!/bin/bash

# Check arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <domain name> <subdomain> <new IP address>"
  exit 1
fi

# Get domain name, subdomain, and new IP address from arguments
DOMAIN_NAME="$1."
SUBDOMAIN="$2."
NEW_IP="$3"

# Get hosted zone ID
HOSTED_ZONE_ID=$(aws route53 list-hosted-zones-by-name --dns-name "$DOMAIN_NAME" --query "HostedZones[0].Id" --output text)

# Get current A record
CURRENT_RECORD=$(aws route53 list-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --query "ResourceRecordSets[?Name == '$SUBDOMAIN']" --output json)
CURRENT_RECORD_A=`echo $CURRENT_RECORD | jq -r '.[0]'`
# Create change batch for record set
if [ -z "$CURRENT_RECORD" ] || [ "$CURRENT_RECORD" == "[]" ]; then
  # If there is no existing A record, only add
  CHANGE_BATCH=$(cat <<EOF
{
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "$SUBDOMAIN",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "$NEW_IP"
          }
        ]
      }
    }
  ]
}
EOF
)
else
  # If there is an existing A record, delete it first then add
  CHANGE_BATCH=$(cat <<EOF
{
  "Changes": [
    {
      "Action": "DELETE",
      "ResourceRecordSet": $CURRENT_RECORD_A
    },
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "$SUBDOMAIN",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "$NEW_IP"
          }
        ]
      }
    }
  ]
}
EOF
)
fi

# Execute change of Route 53 record set
aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --change-batch "$CHANGE_BATCH"
echo "Record set change has been completed."