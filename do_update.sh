#!/bin/bash

function handle_exit() {
   echo $1
   exit
}


echo "Dockerised OpenCR updater - Xander Soldaat"
echo
echo "Updating OpenCR on port ${PORT} for model ${MODEL}"
echo -n "Continue: [yN]: "
read response
if [ "X$response" == "Xy" ]; then
   echo; echo "----------------------------------------------"; echo
   echo -n "Downloading latest firmware: "
   wget -q ${UPDATE_URL} || handle_exit "failed."
   echo "done."
   echo -n "Extracting firmware: "
   tar -xf opencr_update.tar.bz2 || handle_exit "failed."
   echo "done."
   cd opencr_update && ./update.sh ${PORT} ${MODEL}.opencr || exit 1  
fi
