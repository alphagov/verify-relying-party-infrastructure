#!/usr/bin/env bash

set -eu

export SERVICE_ENTITY_IDS='["https://blah"]'
export VERIFY_ENVIRONMENT="COMPLIANCE_TOOL"
export MSA_ENTITY_ID="https://test-test-test-msa"
export MSA_METADATA_URL="http://localhost:50230/metadata"
export SAML_SIGNING_KEY="$(openssl base64 -A -in pki/signing-private-key.pk8)"
export SAML_PRIMARY_ENCRYPTION_KEY="$(openssl base64 -A -in pki/encryption-private-key.pk8)"

verify-service-provider-*/bin/verify-service-provider

