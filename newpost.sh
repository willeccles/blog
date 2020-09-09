#! /bin/bash -e

if [[ $# == 0 ]]; then
    >&2 echo "Supply a title"
    exit 1
fi

# I can be lazy
TITLE="$@"

# find the directory of the script so I can't make posts elsewhere
BLOGDIR="$(cd "$(dirname "$0")" 2>/dev/null; pwd -P)/posts"

DATE="$(date +%F)"
FNAME="$BLOGDIR/$DATE.md"

if [[ -f "$FNAME" ]]; then
    >&2 echo "Post '$DATE.md' already exists"
    exit 1
elif [[ -d "$FNAME" ]]; then
    >&2 echo "$FNAME exists and is a directory"
    exit 1
fi

>"$FNAME" cat - <<EOM
# $TITLE
Created $DATE
EOM

POSTS="$(tail -n +2 $BLOGDIR/README.md)"
>"$BLOGDIR/README.md" cat - <<EOM
# Posts
$DATE - [$TITLE]($DATE.md)
$POSTS
EOM

echo "Post created: $FNAME"