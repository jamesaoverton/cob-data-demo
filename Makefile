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
	curl -L -o $@ https://build.obolibrary.io/job/ontodev/job/robot/job/error-tables/4/artifact/bin/robot.jar

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

build/%/construct.rq build/%/expected.ttl build/%/select.rq: doc/%.md
	src/convert.py $< $(dir $@)

build/%/actual.ttl: src/patients.ttl build/%/construct.rq | build/robot.jar
	$(ROBOT) query --input $< --query $(word 2,$^) $@

build/%/actual.ttl.diff: build/%/expected.ttl build/%/actual.ttl | build/robot.jar
	$(ROBOT) diff --left $< --right $(word 2,$^) --output $@

build/%/patients.tsv: build/%/actual.ttl build/%/select.rq | build/robot.jar
	$(ROBOT) query --input $< --query $(word 2,$^) $@

build/%/patients.tsv.diff: build/patients.tsv build/%/patients.tsv
	-diff $^ > $@

build/%/patients.html: build/patients.tsv build/%/patients.tsv
	daff --all --output $@ $^

