# COB Quantities

---

James A. Overton

<james@overton.ca>

## Overview

1. problem
2. units of measurement
3. quantitative values

### The Good

- OBO brings together many scientific ontologies
- good coverage of many domains
- agreement on many terms and relations

### The Bad

- missing some important terms
  - many units of measurement
- shared terms are not enough for interoperability
  - more shared modelling
  - more focus on data, not just terminology
- OBO often ignores or is ignored by the wider Semantic Web

### The Ugly

- RDF and OWL are a *blank slate*
  - too many ways to say the same thing
- too many standards AND too few standards
- no one good existing standard for quantitative values

### Problem

Agree on shared modelling for quantitative values in OBO

### Immediate Use Cases

- qualitative statements
  - simple: sex
- quantitative statements
  - simple: height, weight
  - units: metric, imperial, biological
- provenance
  - simple: where value came from

### Advanced Use Cases

- quantitative statements
  - rates: heart rate
  - calculated: BMI
  - ratios
  - counts
  - complex: boiling point at specified pressure
  - ranges
  - significant digits
  - confidence intervals, uncertainty
- information/records about measurements, settings, simulations

### Setting Aside

- time, change, temporal problems

### Desiderata

1. follow OBO principles, e.g. Open
2. as simple as possible, but no simpler
3. conserve existing OBO resources
4. try to interoperate with the wider Semantic Web
5. forward compatibility if a better standard emerges

### Roadmap

1. units of measurement: metric, non-metric, special
2. basic predicates: has quantity, has unit
3. shared modelling and mappings
4. advanced predicates, step by step


## Units of Measurement Proposal

### Background

- OBO's Units Ontology (UO)
  - missing units: ohm, atmosphere, bar
  - few links to other standards
  - not widely used outside OBO
  - little recent development
- other unit ontologies: QUDT, OM, OBOE
  - each has strengths and weaknesses
- need metric, non-metric, special units

### Unified Code for Units of Measure

[ucum.org](https://ucum.org)

- wide coverage, widely used
- metric, non-metric, and special units
- grammar for constructing unlimited combinations
- no IRIs, no pages for specific units
- but QUDT, OM, etc. include UCUM codes

### URLs for UCUM

Some of us built <https://w3id.org/uom>

- UCUM as Rosetta Stone
  - map to/from QUDT, OM, OBOE, UO, more!
- provide URLs and RDF for every unit
- provide "canonical" codes (sorted)
- provide conversion scripts

### Current Mappings

- [NERC_P06: Natural Environment Research Council BODC-approved data storage units](http://vocab.nerc.ac.uk/collection/P06/current/)
- [OBOE: Extensible Observation Ontology](https://bioportal.bioontology.org/ontologies/OBOE)
- [OM: Ontology of Units of Measure](http://www.ontology-of-units-of-measure.org/)
- [QUDT: Quantities, Units, Dimensions and dataTypes](http://qudt.org/)
- [UO: Units Ontology](http://purl.obolibrary.org/obo/UO_)

### In Action

Kai's slides

<https://w3id.org/uom/>

### Principles

- relentlessly simple
- unlimited number of units, on-the-fly
- general scope
  - meant for wider Semantic Web community
  - minimal ontological commitment
- coverage
  - metric units
  - non-metric units
  - special units (in progress)

### Special Units

- UCUM "annotations" in `{}` treated as `1`
- `{RBC}/uL`
  - RBC = red blood cell
  - OBO wants a link to Cell Ontology
- we can bridge with OBO terms through UO

### Future Work

- mappings to more systems
- use SSSOM
- bridge with UO


## COB Quantities Proposal

### General Principles

- Across OBO: tight integration
- Outside OBO: thorough mappings

### A Bit More Specific

- adopt UOM for units <https://w3id.org/uom>
  - update Units Ontology (UO) to connect
- define basic predicates in COB
  - 'has quantity'
  - 'has unit'
- map basic predicates to existing systems
  - QUDT, OM, etc.
- conversion scripts
- **documentation!**

### Example Table

patient | sex | height | exam
---|---|---|---
James A. Overton | male | 182 | 2021-09-14

### Example RDF with Labels

Statements about James

```ttl
ex:JamesOverton
  a 'Homo sapiens' ;
  'has characteristic' [ a 'male' ] ;
  'has characteristic' [
    a 'height' ;
    'has quantity' "182"^^xsd:float ;
    'has unit' UOM:cm ;
    'determined by' [
      a 'height assay' ;
      'part of' 'exam 2021-09-14'
    ] 
  ] .
```

### Example RDF with CURIEs

Statements about James

```ttl
ex:JamesOverton
  a NCBITaxon:9606 ;
  COB:0000512 [ a PATO:0000384 ];
  COB:0000512 [
    a PATO:0000119 ;
    COB:XXXXXX "182"^^xsd:float ;
    COB:XXXXX2 UOM:cm ;
    COB:XXXXX3 [
      a OBI:0000070 ;
      BFO:0000050 ex:exam-2021-09-14
    ] 
  ] .
```

### Example RDF with Labels

Statements about a **measurement** about James should have a similar **shape**

```ttl
ex:JamesOverton
  a 'Homo sapiens' ;
  'has characteristic' [ a 'male' ] .
[
  a 'measurement datum' ;
  'has quantity' "182"^^xsd:float ;
  'has unit' UOM:cm ;
  'is about' [
    a 'height' ;
    'characteristic of' ex:JamesOverton
  ] ;
  'specified output of' [
    a 'height assay' ;
    'part of' 'exam 2021-09-14'
  ]
] .
```

### Some Mappings

source | quantity, unit
---|---
QUDT | `qudt:value`, `qudt:unit`
OM | `om:hasNumericValue`, `om:hasUnit`
OBOE | `oboe:hasValue`, `oboe:hasUnit`

### Some More Mappings

source | quantity, unit
---|---
Wikidata | `wb:quantityAmount`, `wb:quantityUnit`
SIO | `SIO:000300`, `SIO:000221`
schema.org | `schema:value`, `schema:unitCode`

## Wrapping Up

### Problem

Agree on shared modelling for quantitative values in OBO

### Immediate Use Cases

- qualitative statements
  - simple: sex
- quantitative statements
  - simple: height, weight
  - units: metric, imperial, biological
- provenance
  - simple: where value came from

### Desiderata

1. follow OBO principles, e.g. Open
2. as simple as possible, but no simpler
3. conserve existing OBO resources
4. try to interoperate with the wider Semantic Web
5. forward compatibility if a better standard emerges

### Roadmap

1. units of measurement: **beta phase**
2. basic predicates: **design phase**
3. shared modelling and mappings
4. advanced predicates, step by step

### Discussion

[OBOFoundry/COB issue #35](https://github.com/OBOFoundry/COB/issues/35)
