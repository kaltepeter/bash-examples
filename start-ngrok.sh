# start ngrok
readonly ngrok_pid="${__dir}/ngrok-pid.txt"
ps -p "$(cat "${ngrok_pid}")" && kill -9 "$(cat "${ngrok_pid}")"
nohup ngrok start jenkins &
echo $! > "${ngrok_pid}"
