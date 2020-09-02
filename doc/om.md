# OM

Ontology of units of Measure

https://github.com/HajoRijgersberg/OM

## About

> The Ontology of units of Measure (OM) 2.0 models concepts and relations important to scientific research. It has a strong focus on units, quantities, measurements, and dimensions.

## Classification

- D4 multiple triples
- P2 few predicates
- V2 reification

## Pros and Cons

- pros
  - straightforward
  - public GitHub repo
- cons
  - not widely used?
  - unsure about license
  - nothing qualitative?
  - extensive overlap with OBO qualities/characteristics
  - focused on SI, not sure about other coverage

## Construct

```sparql construct.rq
# IMPORT src/prefixes.rq

CONSTRUCT {
  ?patient a ont:human .
  # I'm not sure how to handle qualitative values
  # I'm not sure how this connects to the the exam
  [ a om:Height ;
    om:hasPhenomenon ?patient ;
    om:hasValue [
      a om:Measure ;
      om:hasNumericValue ?height ;
      om:hasUnit om:centimetre
    ]
  ] .
  [ a om:Weight ;
    om:hasPhenomenon ?patient ;
    om:hasValue [
      a om:Measure ;
      om:hasNumericValue ?weight ;
      om:hasUnit om:kilogram
    ]
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
  VALUES ?sex { ont:female ont:male }
  ?patient a ont:human .
  [ a om:Height ;
    om:hasPhenomenon ?patient ;
    om:hasValue [
      a om:Measure ;
      om:hasNumericValue ?height ;
      om:hasUnit om:centimetre
    ]
  ] .
  [ a om:Weight ;
    om:hasPhenomenon ?patient ;
    om:hasValue [
      a om:Measure ;
      om:hasNumericValue ?weight ;
      om:hasUnit om:kilogram
    ]
  ] .
  ?exam a ont:exam ;
    ont:begins-on ?exam_date ;
}
ORDER BY ?exam
```

Result: [patients.html](patients.html)
