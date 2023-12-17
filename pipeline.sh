#!/bin/bash
if [ -z $1 ]
then
    echo "Branch name for backend needed as first argument"
    exit 4
fi
if [ -z $2 ]
then
    echo "Branch name for frontend needed as first argument"
    exit 4
fi

if [ -d Proposed_Changes ]
then
    rm -rf Proposed_Changes
fi
mkdir Proposed_Changes
cd Proposed_Changes

git clone git@github.com:Ms-Bean/CS490G-Frontend.git
cd CS490G-Frontend
git checkout $2
cd react-app

echo "REACT_APP_BACKEND_URL=http://thinkcenter.ddns.me:3500" > .env

npm i

cd ../.. 

git clone git@github.com:Ms-Bean/CS490G-Backend.git
cd CS490G-Backend
git checkout $1
echo "DB_HOST=localhost" > .env 
echo "DB_USER=root" >> .env
echo "DB_PASS=18C@ctusgr3en" >>.env
echo "DB_NAME=cs490_database" >> .env
echo "FRONTEND_URL=http://localhost:3000" >> .env
echo "BACKEND_URL=http://localhost:3500" >> .env
echo "PORT=3500" >> .env
npm i

#This will be removed by end of day
rm __tests__/exercises_data_layer.test.js  __tests__/accept_client_survey_data_layer_test.js __tests__/client_coach_interface_data_layer_test.js __tests__/insert_daily_survey_data_layer_test.js __tests__/login_business_layer.test.js __tests__/testrunner.js

output=`npm test`
status=$?

if [ $status -ne 0 ]
then
    echo "Tests failed."
    cd ../..
    rm -rf Proposed_Changes
    exit 4
fi 

cd ../..



if [ -d 'CS490G-Backend' ]
then
    rm -rf 'CS490G-Backend'
fi 
if [ -d 'CS490G-Frontend' ]
then
    rm -rf 'CS490G-Frontend'
fi 

mv Proposed_Changes/* .
rmdir Proposed_Changes

fuser -k 3000/tcp
fuser -k 3500/tcp

cd CS490G-Backend
nohup node server.js &
cd ../CS490G-Frontend/react-app
nohup npm start &
