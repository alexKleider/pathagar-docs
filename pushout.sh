#!/bin/bash
rsync -a --delete -e "ssh -p5122" /home/alex/Docbook/PatHowto/*.html indi303.net:/var/www/indi/PatHowto/docs


