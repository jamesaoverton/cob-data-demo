# COB Data Demo

## Overview

### Problem

- express quantitative values


These are some notes.

### Use Cases

- qualitative statements
- quantitative statements
  - simple: height, weight
  - rates: heart rate
  - calculated: BMI
  - ratios
  - counts
  - complex: boiling point at specified pressure
  - ranges
  - significant digits
- information/records about measurements

### Setting Aside

- time, change, temporal problems


## Existing Approaches

### General Approaches

- EAV: entity-attribute-value
- BFO determinable/determinate

### EAV: Entity-Attribute-Value

https://en.wikipedia.org/wiki/Entity–attribute–value_model

entity-attribute-value is a pattern (or anti-pattern) from the the database domain.
It has obvious similarities to RDF.
The simplicity is the obvious appeal,
but it doesn't actually make many decisions for us.

In OBO we usually have entities (i.e. named individuals, class intances)
which have a quality, and we want to quantify that quality with the value.


### BFO Determinable/Determinate

Philosphers sometimes make this distinction between the
determinable 'colour of Socrates' skin' (over his whole life)
and the determinate shade that his skin took at a particular moment.

https://plato.stanford.edu/entries/determinate-determinables/

I saw Barry Smith present a version of this approach in the BFO context about ten years ago.
Unfortunately I cannot find a reference to it now.

OBO has a long list of determinable qualities,
but I can't point to a proposal for determinates.

### Specific Approaches

- SIO: Semanticscience Integrated Ontology
- Wikidata
- QUDT
- OM
- IAO/OBI value specifications


## Pieces of a Solution

- datatypes
- predicates
- provenance

