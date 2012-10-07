#
# Just to see them all (not loaded by vim)
#
# >> sh lscowfiles.sh
#
# There are some funny cowfiles in there...
#

if [ -d /usr/local/share/cows ]; then
  files=$(ls /usr/local/share/cows)
elif [ -d /usr/share/cowsay/cows/ ]; then
  files=$(/usr/share/cowsay/cows/)
fi


for cowfile in $files; do
  echo "Cowfile $cowfile"
  echo """
  """
  cowsay -f $cowfile Test cowfile $cowfile
done
