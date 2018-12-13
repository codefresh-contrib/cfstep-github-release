# !/bin/bash

# check if the required vars are set
for reqVar in GITHUB_TOKEN CF_REPO_OWNER CF_REPO_NAME CF_BRANCH_TAG_NORMALIZED; do
    if [ -z ${!reqVar} ]; then echo "The variable $reqVar is not set, stopping..."; exit 1; fi
done

if [ "$PRERELEASE" = "true" ]; then PRERELEASE="-p"; fi

    github-release release --user $CF_REPO_OWNER --repo $CF_REPO_NAME --tag $CF_BRANCH_TAG_NORMALIZED --name "$CF_BRANCH_TAG_NORMALIZED" $PRERELEASE

if [ ! -z "$FILES" ]; then
    for file in $FILES; do
        echo "Uploading file $file........"
        github-release upload --user $CF_REPO_OWNER --repo $CF_REPO_NAME --tag $CF_BRANCH_TAG_NORMALIZED --name $(basename $file) --file $file
    done 
fi