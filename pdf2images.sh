#!/bin/bash
# (C) Joel Schneider, 27th April 2018
# License: GPL 3
# A script to convert a multipage PDF file into images
# gif, jpeg, and png supported

function usage {
	echo "Usage: $0 [-g|-o] [-p prefix] PDFFILE output-type"
	echo "-g		greyscale"
	echo "-o		optimise for small file size"
	echo "-p		prefix for output file"
	echo "output-type	gif/jp[e]g/png"
	exit
}

if [ "x$1" == "x" ]; then
	usage
fi

OUTTYPE=""

if [ "x$1" == "x-g" ]; then
	GREY="-greyscale"
	PNGGREY="-downscale"
	shift
fi

if [ "x$1" == "x-o" ]; then
	OPTIMISE="-optimize"
	PNGOPTIMISE="-compression 9"
	shift
fi

if [ "x$1" == "x-g" ]; then
	GREY="-greyscale"
	PNGGREY="-downscale"
	shift
fi

if [ "x$1" == "x-p" ]; then
	if [ "x$2" == "x" ]; then
		usage
	else
		PREFIX=$2
	fi
	shift
	shift
fi

if [ "x$1" == "x-g" ]; then
	GREY="-greyscale"
	PNGGREY="-downscale"
	shift
fi

if [ "x$1" == "x-o" ]; then
	OPTIMISE="-optimize"
	PNGOPTIMISE="-compression 9"
	shift
fi

if [ "x$1" == "x-g" ]; then
	GREY="-greyscale"
	PNGGREY="-downscale"
	shift
fi

if [ "x$1" == "x" ]; then
	usage
fi

if [ "x$PREFIX" == "x" ]; then
	PREFIX=`echo $1 | sed 's/\.pdf$//'`
fi

INFILE="$1"
shift

if [ "x$1" == "x" ]; then
	usage
fi
TYPE="$1"

TEMPDIR=`mktemp -d`
pdftoppm "$INFILE" "$TEMPDIR/a"

PAGECOUNT=`ls $TEMPDIR | wc -l`
 
case ${TYPE,,} in
	gif)
		for file in $(seq -w $PAGECOUNT); do
			ppmtogif "$TEMPDIR/a-$file.ppm" > "$PREFIX-$file.$TYPE" 2> /dev/null;
		done
		;;
	jpg)
		for file in $(seq -w $PAGECOUNT); do
			ppmtojpeg $OPTIMISE $GREY "$TEMPDIR/a-$file.ppm" > "$PREFIX-$file.$TYPE";
		done
		;;
	jpeg)
		for file in $(seq -w $PAGECOUNT); do
			ppmtojpeg $OPTIMISE $GREY "$TEMPDIR/a-$file.ppm" > "$PREFIX-$file.$TYPE";
		done
		;;
	png)
		for file in $(seq -w $PAGECOUNT); do
			pnmtopng $PNGGREY $PNGOPTIMISE "$TEMPDIR/a-$file.ppm" > "$PREFIX-$file.$TYPE";
		done
		;;
	*)
		usage
		exit
esac

rm -R $TEMPDIR
