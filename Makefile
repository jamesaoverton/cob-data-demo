### Workflow
#
# - [Update](update)
# - [Docs](build/)

### Configuration
#
# These are standard options to make Make sane:
# <http://clarkgrubb.com/makefile-style-guide#toc2>

MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
.SECONDARY:

ROBOT := java -jar build/robot.jar

DOCS := overview datatypes predicates provenance wikidata
PROFILES := sio qudt om value-specifications proposal-1 proposal-2
PAGES := $(DOCS) $(PROFILES)

.PHONY: all
all: build/index.html
all: $(foreach p,$(PROFILES),build/$(p)/patients.html)
all: $(foreach p,$(PAGES),build/$(p)/index.html)
all: $(foreach p,$(PAGES),build/$(p)/slides.md)
all: $(foreach p,$(PAGES),build/$(p)/slides.html)

.PHONY: clean
clean: | build
	rm -rf build/*.{ttl,tsv,md,html}
	cd build && rm -rf $(PAGES)

.PHONY: update
update:
	make clean all


build:
	mkdir -p $@

build/%/:
	mkdir -p $@

build/robot.jar: | build
	curl -L -o $@ "https://github.com/ontodev/robot/releases/download/v1.8.3/robot.jar"

build/reveal.js-master: | build
	curl -L -o $@.zip https://github.com/hakimel/reveal.js/archive/master.zip
	unzip $@.zip
	rm $@.zip
	mv reveal.js-master build

build/index.md: doc/ | build
	echo "# COB Data Demo" > $@
	echo "" >> $@
	echo "topic | slides | docs" >> $@
	echo "---|---|---" >> $@
	$(foreach p,$(PAGES),echo "$(p) | [slides]($(p)/slides.html) | [docs]($(p)/index.html)" >> $@;)

build/index.html: build/index.md | build
	grip --export $< $@

build/%/index.html: doc/%.md | build/%/
	grip --export $< $@

build/%/slides.md: doc/%.md | build/%/
	cp $< $@

build/%/slides.html: src/slides.html | build/%/ build/reveal.js-master
	cp $< $@

build/patients.rq: src/prefixes.rq src/where.rq
	cat $< > $@
	echo "SELECT DISTINCT ?exam ?exam_date ?patient ?sex ?height ?weight" >> $@
	cat $(word 2,$^) >> $@
	echo "ORDER BY ?exam" >> $@

build/patients.tsv: src/patients.ttl build/patients.rq | build/robot.jar
	$(ROBOT) query --input $< --query $(word 2,$^) $@

build/%/construct.rq build/%/expected.ttl build/%/select.rq: src/convert.py doc/%.md | build/%/
	$^ $(dir $@)

build/%/actual.ttl: src/patients.ttl build/%/construct.rq | build/robot.jar
	$(ROBOT) query --tdb true --input $< --query $(word 2,$^) $@

build/%/actual.ttl.diff: build/%/expected.ttl build/%/actual.ttl | build/robot.jar
	$(ROBOT) diff --left $< --right $(word 2,$^) --output $@

build/%/patients.tsv: build/%/actual.ttl build/%/select.rq | build/robot.jar
	$(ROBOT) query --tdb true --input $< --query $(word 2,$^) $@

build/%/patients.tsv.diff: build/patients.tsv build/%/patients.tsv
	-diff $^ > $@

build/%/patients.html: build/patients.tsv build/%/patients.tsv
	daff --all --output $@ $^


build/cob-data.docx:
	curl -L -o $@ "https://docs.google.com/document/d/1Cds-u9icTkS4kN7Mcn8P5D01WgIyMIqFz4YzhCYzg0k/export?format=docx"

build/cob-data.md: build/cob-data.docx
	pandoc -t commonmark $< | pandoc -f commonmark -t gfm -o $@


# New Stuff

TABLES := src/prefix.tsv src/external.tsv src/class.tsv src/predicate.tsv src/example.tsv
GS := "https://docs.google.com/spreadsheets/d/19aPuYxwN5qbfGkDc1hRGv9iTU0F_Gdo4G43-QJqk7B8"

src/prefix.tsv:
	curl -L -o $@ "$(GS)/export?format=tsv&gid=2003840789"

src/external.tsv:
	curl -L -o $@ "$(GS)/export?format=tsv&gid=106460502"

src/class.tsv:
	curl -L -o $@ "$(GS)/export?format=tsv&gid=0"

src/predicate.tsv:
	curl -L -o $@ "$(GS)/export?format=tsv&gid=365304799"

src/example.tsv:
	curl -L -o $@ "$(GS)/export?format=tsv&gid=719163805"

src/demo.owl: $(TABLES) | build/robot.jar
	$(ROBOT) template \
	--add-prefix "value: http://example.com/value/" \
	--add-prefix "time: http://www.w3.org/2006/time#" \
	--template src/external.tsv \
	--template src/class.tsv \
	--template src/predicate.tsv \
	--template src/example.tsv \
	annotate \
	--ontology-iri "http://example.com/demo.owl" \
	--output $@

src/example.ttl: src/example.py $(TABLES) example.txt src/demo.owl
	python $< > $@

build/%.rq: test/test.py test/%.rq.txt | build
	python $^ > $@

build/%.csv: build/%.rq src/example.ttl | build/robot.jar
	$(ROBOT) query \
	--use-graphs true \
	--input src/example.ttl \
	--query $< $@
# java -jar build/robot.jar -vvv query --use-graphs true --input src/example.ttl --query build/all-values.rq build/all-values.csv

.PHONY: rebuild
rebuild:
	rm -rf $(TABLES) src/demo.owl src/example.ttl
	make src/example.ttl
	make build/all-values.rq
