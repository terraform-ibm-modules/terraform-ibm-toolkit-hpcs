#!/bin/bash

export ACCESS_TOKEN=`ibmcloud iam oauth-tokens | grep IAM | cut -d \: -f 2 | sed 's/^ *//'`

curl -X PUT \
"https://api.${REGION}.hs-crypto.cloud.ibm.com:${PORT}/api/v2/instance/policies?policy=allowedNetwork" \
-H "accept: application/vnd.ibm.kms.policy+json" \
-H "authorization: ${ACCESS_TOKEN}" \
-H "bluemix-instance: ${HPCS_INSTANCE_ID}" \
-H "content-type: application/vnd.ibm.kms.policy+json" \
-d "$(cat <<EOF
{
    "metadata": {
        "collectionType": "application/vnd.ibm.kms.policy+json",
        "collectionTotal": 1
    },
    "resources": [
        {
            "policy_type": "allowedNetwork",
            "policy_data": {
                "enabled": true,
                "attributes": {
                "allowed_network": "${ALLOWED_NETWORK}"
                }
            }
        }
    ]
}
EOF
)"
