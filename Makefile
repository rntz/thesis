RNTZTEXDIR := rntztex/
# Path to latexrun.
LATEXRUN := $(RNTZTEXDIR)/latexrun/latexrun
# The TEXINPUTS environment variable tells TeX where to find .sty and .cls
# files. This is necessary if you set RNTZTEXDIR to something other than ".".
export TEXINPUTS := $(RNTZTEXDIR):

# Targets to generate.
TARGETS := thesis.pdf

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
  --pdf-engine=pdflatex

%.pdf: %.tex FORCE
	$(LATEXRUN) $<

# %.tex: %.md Makefile
# 	sed -Ee 's/^\f$$//' $< | $(PANDOC) -o $@

# %.tex: %.md template.tex Makefile
# 	sed -Ee 's/^\f$$//' $< | $(PANDOC) -so --template=template.tex $@

# If you have inotify-tools, `make watch` will automatically recompile your pdfs
# "live". You can also specify a target to recompile, eg. `make watch:foo.pdf`.
# It's a bit overenthusiastic, though; it reruns when ANYTHING changes.
watch: watch\:all
watch\:%:
	make --no-print-directory -j $^
	@while inotifywait -e modify,move,delete -r . >/dev/null 2>&1; do \
		echo; \
		make --no-print-directory -j $^; \
		make --no-print-directory -j $^; \
	done

# debugging: `make print-FOO` will print the value of $(FOO)
.PHONY: print-%
print-%:
	@echo $*=$($*)
