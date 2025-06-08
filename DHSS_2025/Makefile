# Lecture slides are organized into packets
# The source for lecture packets are in directories with the name
# of the lecture packet. A lecture packet contains a file named
# slides.wiki, that is the source of the lecture slides.
# It is appropriate that packet names are lexicographically ordered
# to have the slides ordered in the "printable.pdf" collection

pkts=$(shell find -maxdepth 2 -name slides.wiki -exec dirname \{\} \;)

.PHONY=all deliver printable.pdf
DELIVERYDIR= ../../repo
GOOGLE_DRIVE=$(HOME)/GoogleDrive
PC_PRESENTAZIONE=augusto-Lenovo-V145-15AST

all:
	for f in $(pkts); do make $$f.pdf; make $$f.printable.pdf; make $$f.compact.pdf; done
#	cd ../instructions; pdflatex Instructions.tex
#	cp ../instructions/Instructions.pdf ..
#	cd ../repo; make
	@echo "\n\n*****\nOra 'make deliver' per aggiornare il repository\n"
	
fast:
	for f in $(pkts); do make $$f.printable.pdf; done
	
deliver:
# Copia nella directory del repository (DELIVERYDIR) tutto il necessario
# 1 - Copia il materiale del corso
#	cp -a ../../Docs/ $(DELIVERYDIR)/DHSS_2025
	cp -a ../../GPX $(DELIVERYDIR)/DHSS_2025
	cp -a ../../Maps/*.jpg $(DELIVERYDIR)/DHSS_2025/Maps/
	cp -a ../../Maps/*.jpeg $(DELIVERYDIR)/DHSS_2025/Maps/
	cp -a ../../Maps/*.png $(DELIVERYDIR)/DHSS_2025/Maps/
#	mkdir -p $(DELIVERYDIR)/DHSS_2025/QGIS_projects
#	cp -a ../../qGis_projects/*.qgz $(DELIVERYDIR)/DHSS_2025/QGIS_projects
# 2 - Aggiorna le slide localmente
	make all
#	cp -a ?-*.compact.pdf ../Instructions.pdf $(DELIVERYDIR)/DHSS_2025
# 3 - Copia i pdf delle slide
	for f in $(pkts); do rsync -av $$f*.pdf $(DELIVERYDIR)/DHSS_2025; done
# 4 - Copia il sorgente delle slide
	for f in $(pkts); do rsync -av $$f*/slides.wiki $(DELIVERYDIR)/DHSS_2025/$$f/; done
# 5 - Copia i tool per la generazione delle slide
	rsync -av Makefile compile.sh header* images $(DELIVERYDIR)/DHSS_2025/
# Copia sul PC della presentazione
	rsync -av $(DELIVERYDIR)/DHSS_2025/ $(PC_PRESENTAZIONE):Scrivania/dt4h-gis/
# Sincronizza il repository github (DHSS:25)
	cd $(DELIVERYDIR); make deliver 


%.pdf: %/slides.wiki header.wiki header_printable.wiki header_compact.wiki header_common.wiki
	cd $* && ../compile.sh
	mv $*/slides.pdf $@
	make $*_printable.pdf
	make $*_compact.pdf

%.printable.pdf: %/slides.wiki header_printable.wiki  header_common.wiki
	cd $* && ../compile.sh printable
	mv $*/slides.pdf $@
	cp $@ ../slides.pdf

%.compact.pdf: %/slides.wiki header_compact.wiki  header_common.wiki
	cd $* && ../compile.sh compact
	mv $*/slides.pdf $@

