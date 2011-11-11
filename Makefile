ROOT_TEX_FILE   = root
ROOT_TEX_EXT    = .tex
PDF_OUTPUT_FILE = paper.pdf

PDFLATEX        ?= pdflatex
BIBTEX          ?= bibtex
PDF_VIEWER      ?= open
MV              ?= mv
MAKEINDEX       ?= makeindex

# --- intermediate variables -----------

TEMP_PDF_FILE     := $(ROOT_TEX_FILE).pdf
ROOT_TEX_WITH_EXT := $(ROOT_TEX_FILE)$(ROOT_TEX_EXT)

TEXFILES          := $(wildcard *.tex)
BIBFILES          := $(wildcard *.bib)

# --- Commands -------------------------

.PHONY: view clean all
all: view

$(PDF_OUTPUT_FILE): $(TEXFILES) $(BIBFILES)
	$(PDFLATEX) $(ROOT_TEX_WITH_EXT)
	$(BIBTEX) $(ROOT_TEX_FILE)
	$(PDFLATEX) $(ROOT_TEX_WITH_EXT)
	$(PDFLATEX) $(ROOT_TEX_WITH_EXT)
	$(MV) $(TEMP_PDF_FILE) $(PDF_OUTPUT_FILE)

view: $(PDF_OUTPUT_FILE)
	$(PDF_VIEWER) $(PDF_OUTPUT_FILE) &

clean:
	rm -rf *.aux *.log *.bbl *.blg *.tod *.ilg *.tnd *~ \
		$(TEMP_PDF_FILE) $(PDF_OUTPUT_FILE)

