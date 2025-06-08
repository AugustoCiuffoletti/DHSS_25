#!/bin/bash

OPT=""

[ $1 ] && OPT="_"$1

title=`grep == slides.wiki | head -n 1 | tr -d '='`

(sed s/TITLE/"$title"/ ../header$OPT.wiki; cat slides.wiki ) | wiki2beamer > slides.tex || exit 1
pdflatex slides.tex || exit 1
rm slides.out slides.log slides.snm slides.toc

