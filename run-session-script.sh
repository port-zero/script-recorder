if [ -z $1 ]; then
  echo "Usage: $0 session-script"
  exit 1
fi

rm -f screenlog.0
env BASH_ENV=bashrc screen -L bash "$1"
./gen_html.sh
