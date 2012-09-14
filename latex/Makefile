MAIN = sskm
latex = pdflatex

$(MAIN).pdf: $(MAIN).tex graphics/* references.bib
	$(latex) $(MAIN); bibtex $(MAIN); 
	$(latex) $(MAIN); $(latex) $(MAIN);

simple:
	$(latex) $(MAIN)

# $(MAIN).pdf: $(MAIN).dvi
# 	dvipdf $(MAIN)


clean:
	rm -fv $(MAIN).pdf 
	rm -fv *.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof
	rm -fv  *.nav *.snm *.out *.pyc \#*\# _region_* _tmp.* *.vrb
	rm -fv Rplots.pdf *.RData

cleaner:
	make clean
	rm -fvr auto/