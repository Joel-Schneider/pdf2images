# pdf2images
Convert multipage PDF files to image files

Command line tool for linux, written in bash script.

## Requires:
 poppler - to convert pdf to images
 
 netpbm - to save gif, jpeg, or pngs

## Usage:
pdf2images.sh [-g|-o] [-p prefix] PDFFILE output-type

  -g		greyscale
  
  -o		optimise for small file size
  
  -p		prefix for output file
  
  output-type	gif/jp[e]g/png
