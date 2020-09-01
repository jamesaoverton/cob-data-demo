# cob-data-demo

COB Data Demo

You can browse the documentation here:

- [overview](doc/overview.md)
- elements
    - [datatypes](doc/datatypes.md)
    - [predicates](doc/predicates.md)
    - [provenance](doc/provenance.md)
- approaches
    - [sio](doc/sio.md)
    - [wikidata](doc/wikidata.md)
    - [qudt](doc/qudt.md)
    - [om](doc/om.md)
    - [proposal-1](doc/proposal-1.md)
    - [proposal-2](doc/proposal-2.md)

You can also run tests and build slides using `make clean all`.
This requires ROBOT and Python (see `requirements.txt`).

## Technical Overview

The files in this repository have been carefully designed
to work as both documentation and a suite of integration tests.
See the `Makefile` and `src/` directory for details.

Most of the Markdown files in `docs/` contain fenced code blocks,
with an annotation specifying the syntax and a filename.
The `src/convert.py` script creates a new file for each of these blocks
in the `build/` directory.
If the code block has an `# IMPORT` statement, the target file is read and inserted.
This allows us to write "executable documentation",
i.e. to check that the code in our documentation runs as expected.

Most of these Markdown files contain two main code blocks:
a SPARQL CONSTRUCT block and a SPARQL SELECT block.
We run the CONSTRUCT block on `src/patients.ttl` to generate an `actual.ttl` file.
We run the SELECT block on the `actual.ttl` file to generate a `patients.tsv` file.
Then we compare a generic `patients.tsv` file to this generated file.
If the two TSV files are the same,
then we have shown that the SELECT block is the inverse of the CONSTRUCT block,
and that all the information in `src/patients.ttl` has been retained without loss.
