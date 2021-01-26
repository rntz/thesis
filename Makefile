RNTZTEXDIR := rntztex/
# Path to latexrun.
LATEXRUN := $(RNTZTEXDIR)/latexrun/latexrun
# The TEXINPUTS environment variable tells TeX where to find .sty and .cls
# files. This is necessary if you set RNTZTEXDIR to something other than ".".
export TEXINPUTS := $(RNTZTEXDIR):

# Targets to generate.
TARGETS := 2-datafun.pdf 3-seminaive.pdf

.PHONY: all clean sparkling force watch watch\:% FORCE
all: $(TARGETS)
clean:
sparkling: clean
	rm -f $(TARGETS)
	if test -d latex.out; then rm -r latex.out; fi
force: sparkling all

# The sed script here filters out form feed lines. I use these to mark &
# navigate between sections, but they screw up pandoc's parser.
PANDOC := pandoc --from markdown+raw_tex-latex_macros \
  --pdf-engine=pdflatex \
  --template=template.tex

%.pdf: %.tex FORCE
	$(LATEXRUN) $<

%.tex: %.md template.tex Makefile
	sed -Ee 's/^\f$$//' $< | $(PANDOC) -so $@

# %.pdf: %.md notation.sty template.tex Makefile
# 	sed -Ee 's/^\f$$//' $< | $(PANDOC) -so $@

# If you have inotify-tools, `make watch` will automatically recompile your pdfs
# "live". You can also specify a target to recompile, eg. `make watch:foo.pdf`.
# It's a bit overenthusiastic, though; it reruns when ANYTHING changes.
watch: watch\:all
watch\:%: %
	@while inotifywait -e modify -r . >/dev/null 2>&1; do \
		echo; \
		make --no-print-directory -j $^; \
		make --no-print-directory -j $^; \
	done

# debugging: `make print-FOO` will print the value of $(FOO)
.PHONY: print-%
print-%:
	@echo $*=$($*)
