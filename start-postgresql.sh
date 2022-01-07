if ! pgrep -x 'postgres' >/dev/null; then
  sudo service postgresql start
fi
