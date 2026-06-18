#!/bin/bash
# Build the scRNA-seq deck: render the slides from scrna_seq.Rmd, then append
# the two supplementary PDF decks into a single combined scrna_seq.pdf.
#
# Re-run this script (instead of knitting scrna_seq.Rmd directly) whenever the
# slides change, so the supplementary decks stay attached.
set -e
cd "$(dirname "$0")"

# 1. Render the main slides from the Rmd
Rscript -e 'rmarkdown::render("scrna_seq.Rmd", quiet=TRUE)'

# 2. Append the supplementary decks (main -> extra -> 2020) with Ghostscript
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress \
   -sOutputFile=scrna_seq_combined.pdf \
   scrna_seq.pdf \
   single_cell_sequencing_slides_extra.pdf \
   2020_11_singlecell.pdf

mv scrna_seq_combined.pdf scrna_seq.pdf
echo "Combined scrna_seq.pdf built."
