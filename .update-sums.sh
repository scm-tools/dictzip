#!/bin/sh
# vim: ts=4:et:sts=4
# $Id: .update-sums.sh 78 2008-12-31 10:38:05Z robert $

set -e

PACKAGE=dictd
VERSION=`dpkg-parsechangelog -l../../changelog |  sed -ne 's/^Version: //p'`
TEMPLATEFILE="default.template"
MD5SUMSFILE="default.md5sums"

for mode in daemon inetd disabled; do
    sum=`sed -e "s/^[[:space:]]*RUN_MODE[[:space:]]*=.*/RUN_MODE=\"${mode}\"/" < "$TEMPLATEFILE" | md5sum | cut -d\  -f1`
    echo "$sum  v$VERSION/$mode" >> "$MD5SUMSFILE"
done
