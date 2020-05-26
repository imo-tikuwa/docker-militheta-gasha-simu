#!/bin/sh

cd /usr/local/militheta-gasha-simu/cake_app

# composer install.
if [ ! -d "/usr/local/militheta-gasha-simu/cake_app/vendor" ]; then
    composer install --no-dev --no-interaction
else
    echo "/usr/local/militheta-gasha-simu/cake_app/vendor dir is already exists."
fi

# npm install(and build).
if [ ! -d "/usr/local/militheta-gasha-simu/cake_app/node_modules" ]; then
    npm run build
else
    echo "/usr/local/militheta-gasha-simu/cake_app/node_modules dir is already exists."
fi

# CakePHP3 setup.
bin/cake plugin unload Cake3AdminBaker
bin/cake init_operation_logs
