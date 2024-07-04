#!/bin/env bash

set -x
set -e

ROOT_DIR=`pwd`
WORK_DIR=tmp/testCAPBookshop

if [ -d ${WORK_DIR} ]; then

  npm pack --pack-destination=${WORK_DIR}

  cd ${WORK_DIR}
  cd service

else

  mkdir -p ${WORK_DIR}

  npm pack --pack-destination=${WORK_DIR}

  cd ${WORK_DIR}

  npm init -y

  npm init -w dk -y
  npm add -w dk @sap/cds-dk

  npm init -w service -y

  cd service
  rm package.json

  npx cds init
  npx cds add sample

  npm add ${ROOT_DIR} || true

  npm init wdi5@latest
  npm add @wdio/cucumber-framework
  npm add ui5-community/wdi5-fe-selectors#add-pressTile-searchFor

fi

npm i ../wdi5-cucumber-1.0.0.tgz

rm webapp/test/e2e/*.js
cp ${ROOT_DIR}/test/testCAPBookshop/*.js webapp/test/e2e

rm -r -f test/features
mkdir -p test/features
cp -r ${ROOT_DIR}/test/features test

PORT=8080 ../node_modules/.bin/cds run &
CDSPID=$!
echo "Started process with PID ${CDSPID}"

export wdi5_username="alice"
export wdi5_password=""

set +e

ls -altr test/features
npm run wdi5
#../node_modules/.bin/wdio run ./webapp/test/e2e/wdio.conf.js --headless
RC=$?

# clean up
echo Terminate process with PID $CDSPID
kill -s SIGUSR2 $CDSPID

if [ $RC -ne 0 ]; then
  echo "Test failed, rc:${RC}"
  exit $RC
else
  echo "Test succeeded, rc:${RC}"
fi
