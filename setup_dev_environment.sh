#!/bin/bash

########################################
#
# This is a script for setting up
# a complete development environment
# of the API Leipzig.
#
# ONLY USE THIS FOR *LOCAL* DEVELOPMENT!
#
# Usage:
#  - Install git, rvm and bundler
#  - Copy the script in the directory
#    where you want to create the api
#    folder
#  - run the script
#
########################################

echo "cloning all repositories..."
git clone git@github.com:benben/frontend.git api/
cd api/
git clone git@github.com:benben/api.git
git clone git@github.com:benben/panel.git
git clone git@github.com:benben/instiki.git wiki/


echo "bundle everything..."
cd api/
bundle --without production
cd ../panel
bundle --without production
cd ../wiki
bundle --without production
cd ..

echo "generating dev files for the api..."
cd api/
echo -e "adapter: sqlite3\ndatabase: db/development.sqlite3\npool: 5\ntimeout: 5000" > database.yml
rake db:migrate
rake db:seed
rake permissions:init
cd ..

echo "generating dev files for the panel..."
cd panel/
echo -e "development:\n  adapter: sqlite3\n  database: ../api/db/development.sqlite3\n  pool: 5\n  timeout: 5000" > config/database.yml
cd ..
cp -R css/ panel/public/css
cp -R js/ panel/public/js
mkdir -p panel/public/images
cp -R images/* panel/public/images/

echo "generating dev files for the wiki..."
cd wiki/
cp config/database_example.yml config/database.yml
rake db:migrate
cd ..
cp -R css/ wiki/public/css
cp -R js/ wiki/public/js
cp -R images/* wiki/public/images/

