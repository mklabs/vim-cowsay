
#
# Just to see them all (not loaded by vim)
#
# >> sh lscowfiles.sh
#
# There are some funny cowfiles in there...
#

files=$(ls /usr/local/share/cows)
for cowfile in $files; do
  echo "Cowfile $cowfile"
  echo """
  """
  cowsay -f $cowfile Test cowfile $cowfile
done
