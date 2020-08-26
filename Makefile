### Workflow
#
# Docs:
# - [slides](slides/)
# - [full](slides/slides.html)

slides/slides.html: slides/slides.md
	cd slides && grip --export $(notdir $<)

slides/reveal.js-master: | slides
	curl -L -o $@.zip https://github.com/hakimel/reveal.js/archive/master.zip
	unzip $@.zip
	rm $@.zip
	mv reveal.js-master slides

slides/index.html: slides/reveal.js-master
