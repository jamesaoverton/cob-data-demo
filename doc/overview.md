# COB Data Demo

## Overview

1. problem
2. existing work
3. range of options
4. working proposal

### The Good

- OBO brings together many scientific ontologies
- good coverage of many domains
- agreement on many terms and relations

### The Bad

- shared terms are not enough for interoperability
  - more shared modelling!
- OBO often ignores or is ignored by the wider web of linked data

### The Ugly

- RDF and OWL are a *blank slate*
  - too many ways to say the same thing
- too many standards / too few standards
- no one good existing standard for quantitative values

### Problem

Agree on shared modelling for quantitative values

### Use Cases 1

- qualitative statements
  - simple: sex
- quantitative statements
  - simple: height, weight
- provenance
  - simple: source of value, links out

### Use Cases 2

- quantitative statements
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

### Desiderata

1. follow OBO principles, e.g. Open
2. as simple as possible, but no simpler
3. conserve existing OBO resources
4. try to interoperate with the wider web of linked data


## Existing Approaches

- some general approaches: too general
- some specific approaches
  - Wikidata
  - SIO
  - QUDT
  - OM
  - OBI/IAO value specifications

### General Approaches

- EAV: entity-attribute-value
- BFO determinable/determinate

### EAV: Entity-Attribute-Value

- a [design pattern](https://plato.stanford.edu/entries/determinate-determinables/) (or anti-pattern) from databases
- obvious similarities to RDF
- still just a *blank slate*

#### EAV 2

In OBO:

- entity is usually a material entity
- attribute is usually a quality
- value is usually just "present"/"true"
  - we're discussing qualitative values here

### BFO Determinable/Determinate

- [philosophical distinction](https://plato.stanford.edu/entries/determinate-determinables/):
  - determinable 'colour of Socrates' skin' (over his whole life)
  - determinate shade that his skin took at a particular moment.
- Barry has done work on this, but I couldn't find it
- I can't point to an OBO proposal for determinables

### Specific Approaches

- Wikidata
- SIO: Semanticscience Integrated Ontology
- QUDT: Quantity, Unit, Dimension and Type Schema 2.1
- OM: Ontology of units of Measure 2.0
- OBI/IAO value specifications


## Pieces of a Solution

- datatypes
- predicates
- provenance

