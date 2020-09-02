# QUDT

[Quantity, Unit, Dimension and Type Schema](http://www.qudt.org/pages/HomePage.html)

## About

> QUDT.org is a 501(c)(3) not-for-profit organization founded to provide semantic specifications for units of measure, quantity kind, dimensions and data types.

## History

> Originally, QUDT models were developed for the NASA Exploration Initiatives Ontology Models (NExIOM) project, a Constellation Program initiative at the AMES Research Center (ARC).

Now a member of the World Wide Web Consortium 

## Recent Changes

- version 2.1
- public GitHub repo
- CC-BY 4 license

## Classification

- D6 instance of unit
- P2 few predicates
- V2 reification

## Pros and Cons

- pros
  - W3C member
  - CC-BY 4 license, public GitHub project
  - good coverage of units for physical sciences
  - patterns for unit conversion and user-defined units
- cons
  - nothing qualitative?
  - extensive overlap with OBO qualities/characteristics
  - not sure how to connect entities to quantities

## Construct

```sparql construct.rq
# IMPORT src/prefixes.rq

CONSTRUCT {
  ?patient a ont:human ;
    # I'm not sure how to handle qualitative values
    # I'm not sure how this connects to the patient or the exam
    ont:phenomenon [
      a qudt:quantity ;
      qudt:unit qudt_unit:CentiM ;
      qudt:value ?height ;
      qudt:quantitykind qudt_kind:Height
    ] ;
    ont:phenomenon [
      a qudt:quantity ;
      qudt:unit qudt_unit:KiloGM ;
      qudt:value ?weight ;
      qudt:quantitykind qudt_kind:Weight
    ] .
  ?exam a ont:exam ;
    ont:begins-on ?exam_date ;
    ont:ends-on ?exam_date .
}
# IMPORT src/where.rq
```

Result: [actual.ttl](actual.ttl)

## Select

```sparql select.rq
# IMPORT src/prefixes.rq

SELECT DISTINCT ?exam ?exam_date ?patient ?sex ?height ?weight
WHERE {
  ?patient a ont:human ;
    ont:phenomenon [
      a qudt:quantity ;
      qudt:unit qudt_unit:CentiM ;
      qudt:value ?height ;
      qudt:quantitykind qudt_kind:Height
    ] ;
    ont:phenomenon [
      a qudt:quantity ;
      qudt:unit qudt_unit:KiloGM ;
      qudt:value ?weight ;
      qudt:quantitykind qudt_kind:Weight
    ] .
  ?exam a ont:exam ;
    ont:begins-on ?exam_date ;
}
ORDER BY ?exam
```

Result: [patients.html](patients.html)
