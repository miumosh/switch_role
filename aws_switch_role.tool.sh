#!/bin/bash

unset

serial_number=$(
  cat assume_role_conf.json \
  | jq -r '.serial_number[]' \
  | fzf
)

service=$(
  cat assume_role_conf.json \
  | jq -r '.service[].id' \
  | fzf
)

role_arn=$(
  cat assume_role_conf.json \
  | jq -r \
    --arg service $service \
      '.service[] | select(.id = $service) | .role_arn[]' \
  | fzf
)

output=

export


# switch_source_profile=$(
#   aws configure list-profiles \
#   | fzf
# )

# switch_source_iam_user=$(
#   aws sts get-caller-identity \
#   | jq -r '.Arn' \
#   | awk -F '/' '{print $2}'
# )

# switch_source_policy=$(
#     aws iam list-attached-user-policies --user-name ${switch_source_iam_user} \
#     | jq -r '.AttachedPolicies[].PolicyName' \
#     | fzf
# )

# switch_source_policy_arn=$(
#     aws iam list-attached-user-policies --user-name ${switch_source_iam_user} \
#     | jq  -r --arg switch_source_policy ${switch_source_policy} \
#         '.AttachedPolicies[] | select(.PolicyName == $switch_source_policy) | .PolicyArn'
# )

# switch_destination_role=$(
# aws iam get-policy-version --policy-arn ${switch_source_policy_arn} --version-id v2 \
#     | jq -r '.PolicyVersion.Document.Statement[].Resource[]'
# )


