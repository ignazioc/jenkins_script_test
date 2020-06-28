#! /bin/bash

# Note:
# [X] 1. Schedule a job every thu at 17.5
# [X] 2. Download new vendor list and translation
# [X] 3. Run some sanity check.
# [X] 4. Replace old vendor list and translation with the new one.
# [X] 5. Commit
# [ ] 6. Deploy on production
# [ ] 7. Send notification when job fails


# Exit on errors
set -e


# Jump into a tmp folder.
pushd $(mktemp -d)

# Clone the current Consent service
git clone git@github.corp.ebay.com:eBay-Kleinanzeigen/consent-service.git


BRANCH='scheduled_deploy'

# download the new vendor list
curl https://vendorlist.consensu.org/v2/vendor-list.json -o 'vendor-list-tmp.json'

# download the translation file
curl https://vendorlist.consensu.org/v2/purposes-de.json -o 'purposes-de-tmp.json'


# Validate both JSON
jq -e . >/dev/null 2>&1 <<<`cat vendor-list-tmp.json`
jq -e . >/dev/null 2>&1 <<<`cat purposes-de-tmp.json`

# Extract new and old version of consent string
VENDOR_VERSION=`jq '.vendorListVersion' vendor-list-tmp.json` 
PURPOSES_VERSION=`jq '.vendorListVersion' purposes-de-tmp.json`
OLD_VENDOR_VERSION=`jq '.vendorListVersion' consent-service/src/main/resources/vendor/vendorList.json`

# Assert the two new versions are the same
if [ ${VENDOR_VERSION} != ${PURPOSES_VERSION} ]; then
    echo "Vendor list and purposes do not match"
    exit 1
fi

# Assert the new is different from the old
if [ ${VENDOR_VERSION} == ${OLD_VENDOR_VERSION} ]; then
    echo "New version is equal to the current one"
    exit 1
fi

# git checkout ${BRANCH}

# Overwrite the old files with the new one.
mv vendor-list-tmp.json consent-service/src/main/resources/vendor/vendorList.json
mv purposes-de-tmp.json consent-service/src/main/resources/vendor/purposes-de.json

pushd consent-service
git commit -am "Automatically update Vendor list from ${OLD_VENDOR_VERSION} to ${VENDOR_VERSION}"
git push
popd


popd


