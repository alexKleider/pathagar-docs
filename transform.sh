#!/bin/bash

# Usage: transform.sh file [outfile] [format]
# transform.sh validates docbook xml
#           and if successful, its output is preprocessed xml.
#           If outfile is provided, output goes to outfile and 
#           is transformed into html by default unless some other format
#           is specified as 'format'. 
#           It can handle xIncludes.  (~/bin/convert.sh can not.)
#     If outfile is not provided, output defaults to stdout and no
#     transformation occurs.
# I think jing is redundant but have yet to test this.

set -e

if [ -n "$3" ]
then
    format=$3
else
    format="html"
fi

if [ -n "$2" ]
then
    outfile=$2
else
    outfile="/dev/stdout"
fi
infile=$1

xsl=/usr/share/xml/docbook/stylesheet/docbook5/db4-upgrade.xsl
rng=/usr/share/xml/docbook/schema/rng/5.0/docbook.rng 

xmllint  --relaxng $rng --xinclude $infile > $outfile

if [ -n "$2" ]
then 
    jing /usr/share/xml/docbook/schema/rng/5.0/docbook.rng $outfile
    xmlto --skip-validation $format $outfile 
fi

