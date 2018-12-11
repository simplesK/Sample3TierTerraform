@echo off
echo "##### Ensure that SSH keys are configured to download aws terraform modules from github #####"
echo "##### ~/.ssh/config should contain configuration for no strict hostname check for github #####"
echo "##### ~/.ssh/id_rsa and id_rsa.pub should exist #####"
REM Access Key 
set AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxxxxxxxx
REM Secret Access Key
set AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxx

C:\Users\te163408\Downloads\terraform\terraform.exe %1