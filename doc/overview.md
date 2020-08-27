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

### Overview

- EAV: entity-attribute-value
- SIO: Semanticscience Integrated Ontology
- Wikidata
- BFO determinable/determinate
- IAO/OBI value specifications

### EAV: Entity-Attribute-Value

https://en.wikipedia.org/wiki/Entity–attribute–value_model

entity-attribute-value is a pattern (or anti-pattern) from the the database domain.
It has obvious similarities to RDF.
The simplicity is the obvious appeal,
but it doesn't actually make many decisions for us.

In OBO we usually have entities (i.e. named individuals, class intances)
which have a quality, and we want to quantify that quality with the value.

### SIO: Semanticscience Integrated Ontology

Documentation: https://github.com/MaastrichtU-IDS/semanticscience/wiki/DP-Measurements

```
'measurement of x' 
subClassOf 
 'quantity' 
 and 'has value' some Literal 
 and 'has unit' some 'measurement unit' 
 and 'is attribute of' some ( 'object' and 'is part of' some 'object' )`
```

Classification:

- D4 multiple triples
- P2 few predicates
- V1 cluster of triples

(I don't understand how a quantity is an attribute of an object, but I guess it's a link to the attribute being measured.)

They discuss provenance separately:

https://github.com/MaastrichtU-IDS/semanticscience/wiki/DP-Provenance

### Wikidata

Example:
- nickel Q744
  - HTML https://www.wikidata.org/wiki/Q744
  - Turtle https://www.wikidata.org/wiki/Special:EntityData/Q744.ttl
- boiling point P2102
  - HTML https://www.wikidata.org/wiki/Property:P2102
- boiling point of nickel 5,139±1 degree Fahrenheit at 760±1 torr

```
wd:Q744
  wdt:P2102 "+5139"^^xsd:decimal ;
  p:P2102 s:Q744-1A250375-1B0D-40FA-92A4-85ABF6176F5E .
s:Q744-1A250375-1B0D-40FA-92A4-85ABF6176F5E a wikibase:Statement,
		wikibase:BestRank ;
	wikibase:rank wikibase:NormalRank ;
	ps:P2102 "+5139"^^xsd:decimal ;
	psv:P2102 v:9a5dd00f2ea19c651b6c65ea6bcce120 ;
	pq:P2077 "+760"^^xsd:decimal ;
	pqv:P2077 v:763d95c3e4cd1ae04f4a0c259f28325e ;
	pqn:P2077 v:1425db8f59b827e5971879fedcc789cc ;
	prov:wasDerivedFrom ref:83eb0461a028911c8b251ad1d4502b8af2ea24cf .
v:9a5dd00f2ea19c651b6c65ea6bcce120 a wikibase:QuantityValue ;
	wikibase:quantityAmount "+5139"^^xsd:decimal ;
	wikibase:quantityUpperBound "+5140"^^xsd:decimal ;
	wikibase:quantityLowerBound "+5138"^^xsd:decimal ;
	wikibase:quantityUnit <http://www.wikidata.org/entity/Q42289> .
```

Classification:

- D4 multiple triples
- P1 many predicates
- custom provenance

- pros
  - very complete
  - very careful about provenance
  - supports many units
- cons
  - very complex
  - seems more focused on the provenance than the data
  - specific to the Wiki
  - supports too many units?


### BFO Determinable/Determinate

Philosphers sometimes make this distinction between the
determinable 'colour of Socrates' skin' (over his whole life)
and the determinate shade that his skin took at a particular moment.

https://plato.stanford.edu/entries/determinate-determinables/

I saw Barry Smith present a version of this approach in the BFO context about ten years ago.
Unfortunately I cannot find a reference to it now.

OBO has a long list of determinable qualities,
but I can't point to a proposal for determinates.


### IAO/OBI Value Specifications






## Pieces of a Solution

- datatypes
  1. just strings
  2. UCUM strings
  3. custom datatypes
  4. multiple triples
  5. units in the predicate
- predicates
- provenance


## Datatypes

It would be nice to be able to say `"182"^^:cm`.

### Standards

- RDF triples can have an optional datatype
- XSD datatypes are the only ones in widespread use
  - SPARQL provides some numeric functions and comparisons for XSD integers and floats
- OWL provides tools for custom datatypes, not widely used
  - SPARQL support for custom datatypes is limited, scattered

### D1. Just Strings

`"182cm"`

- pros: simple
- cons:
  - users must do all the work
  - no access to SPARQL numeric functions or comparisons

### D2. UCUM Strings

`"1 m"^^cdt:ucum`

UCUM Unified Code of Units of Measures is a standard for expressing values with units as strings.
This work proposes to adapt that to RDF,
essentially by providing parsing tools for UCUM strings from RDF literal strings:

https://ci.mines-stetienne.fr/lindt/v3/custom_datatypes#ucum

- pros:
  - comprehensive, extensible
  - has a prototype
- cons:
  - new, not sure about trajectory/momentum
  - requires major new tooling for actually parsing/using UCUM strings
  - not sure about licensing or support from UCUM

### D3. Custom Datatypes

`"182"^^units:cm`

- pros:
  - clear, compact
- cons:
  - only indirect access to SPARQL numerics
    - `BIND(xsd:integer(?height) as ?height_cm)`
  - need to settle on a units ontology
    - do we want just SI units? all sorts of units?
    - use numeric IDs for units, or human-readable names?
  - user is still responsible for conversions

### D4. Multiple Triples

`[ ont:has-quantity 182 ; ont:has-unit :cm ]`

- pros
  - reuse XSD datatypes
  - full use of SPARQL numerics
  - easy to add more triples (see Provenance)
- cons
  - clumsy
  - have to worry about keeping triples "together"
  - harder to query over
  - need to settle on a units ontology (same as D3)
  - need to settle on predicates

### D5. Units in the Predicate

`ont:has-length-cm 182`

- pros
  - reuse XSD datatypes
  - full use of SPARQL numerics
- cons
  - requires lots of new predicates
  - harder to query for length in general (without units)
  - (I think this is hideous)


## Predicates

### P1. Many Predicates

ont:has-height, ont:has-weight, ont:has-height-cm

- pros
  - solve the datatype problem
- cons
  - OBO has many classes by minimal predicates
  - would require a lot of new predicates
    - one for each quality, or group/branch of qualities

### P2. Few Predicates

`ont:has-quantity`

- pros
  - simple
  - no major change to OBO classes
- cons
  - pushes information to other parts of the triple


### P3. Punning Quality Classes as Predicates

`ont:height`, `ont:sex` both a class and a predicate

- pros
  - reuse existing quality terms
  - kind of elegant
- cons
  - makes OWLAPI cry
  - invites confusion
  - probably hard to do hierarchical queries


## Provenance

One triple is rarely enough.
We usually want to say more about a measurement, e.g.
where it came from, how it was done, who did it.

We have two main options: "clusters" of triples or reification

### V1. Clusters of Triples

Use the same subject, maybe a blank node.

- pros
  - simple
- cons
  - need to keep triples together, avoid mixing
  - need to enforce "shape"
  
### V2. Reification

We can "reify" an RDF triple and say more things about it in four different ways:

1. RDF reification
2. OWL annotations (most common on OBO)
3. RDF*: an emerging standard, not 
4. named graphs (RDF datasets): works well for making statements about sets of triples, but not individual triples

When working with OWL, only 2 is an option.
But 1,2,3 are (probably) isomorphic.

- pros
  - can be very precise
  - can be very clean
- cons
  - harder to query, more blank nodes and nesting
  - maybe harder to think about: statements about statements
  - rival standards



