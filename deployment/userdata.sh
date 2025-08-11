#!/bin/bash
# Store env vars in a file for persistence
cat <<EOF > /home/ubuntu/.ratingo_env
export REACT_APP_BACKEND_ENDPOINT="https://imbvdzogfi.execute-api.us-east-1.amazonaws.com"
export REACT_APP_TOP_RATED_PATH="/rating"
export REACT_APP_NOW_PLAYING_PATH="/playing"
EOF

# Make sure ubuntu user owns it
chown ubuntu:ubuntu /home/ubuntu/.ratingo_env

# Run commands as ubuntu user
sudo -u ubuntu bash -c '
    source ~/.ratingo_env
    cd /app/ratingo-frontend
    pm2 start npm --name "ratingo-frontend" -- start
    pm2 save
'
