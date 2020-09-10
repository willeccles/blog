#! /bin/bash -e

# generate the README from the post index
# this is a separate script from newpost.sh because it allows me to remake the
# TOC if I manually remove a post.

BLOGDIR="$(cd "$(dirname "$0")" 2>/dev/null; pwd -P)/posts"
INDEX="$BLOGDIR/index.txt"

# put the index into the README
sed -E 's/([^:]+):(.+)/[\1](posts\/\1.md) - \2/' "$INDEX" | cat README.md.in - >/tmp/newreadme

mv /tmp/newreadme "$BLOGDIR/../README.md"

