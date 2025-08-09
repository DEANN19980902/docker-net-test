#!/bin/bash
BANDWIDTH=${1:-100M}
DURATION=${2:-10}
LOG="docker_net_test.log"
SERVER_NAME=iperf3-server
CLIENT_NAME=iperf3-client

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

echo "===== $(timestamp) Testing: bandwidth=${BANDWIDTH}, duration=${DURATION}s =====" | tee -a "$LOG"

docker compose up -d
sleep 2

echo "--- Ping RTT (client -> server) ---" | tee -a "$LOG"
docker exec "$CLIENT_NAME" ping -c 5 server | tee -a "$LOG"

echo "--- iperf3 UDP Stream ---" | tee -a "$LOG"
IPERF_OUT=$(docker exec "$CLIENT_NAME" iperf3 -c server -u -b "$BANDWIDTH" -t "$DURATION" --json 2>&1)
echo "$IPERF_OUT" | tee -a "$LOG"

if command -v jq >/dev/null 2>&1; then
  JITTER=$(echo "$IPERF_OUT" | jq '.end.sum.jitter_ms')
  LOSS_PCT=$(echo "$IPERF_OUT" | jq '.end.sum.lost_percent')
  echo "Parsed jitter: ${JITTER} ms" | tee -a "$LOG"
  echo "Parsed loss: ${LOSS_PCT} %" | tee -a "$LOG"
else
  echo "jq not installed; raw JSON above." | tee -a "$LOG"
fi

echo "===== $(timestamp) Test over =====" | tee -a "$LOG"
