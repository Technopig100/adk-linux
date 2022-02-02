#!/bin/bash

rm adk_local_repo*

echo "repo-add"
#repo-add -s -n -R adk_local_repo.db.tar.gz *.pkg.tar.zst
repo-add -n -R adk_local_repo.db.tar.gz *.pkg.tar.zst
sleep 5
#cp adk_local_repo_testing.db.tar.gz adk_local_repo_testing.db

echo "####################################"
echo "Repo Updated!!"
echo "####################################"
