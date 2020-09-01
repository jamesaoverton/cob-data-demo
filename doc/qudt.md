# QUDT

Big changes recently:

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
  - good breadth
  - patterns for unit conversion and user-defined units
- cons
  - nothing qualitative?
  - seems very different from OBO

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
