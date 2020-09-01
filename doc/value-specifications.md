# Proposal 1

## Classification

- D4 multiple triples
- P2 few predicates
- V2 reification

## Construct

```sparql construct.rq
# IMPORT src/prefixes.rq

CONSTRUCT {
  ?patient a ont:human ;
    ont:has-quality [ a ?sex ] .
  [ a ont:measurement-datum ;
    ont:specified-output-of [
      a ont:height-assay ;
      ont:part-of ?exam
    ] ;
    ont:specifies-value-of [
      a ont:height ;
      ont:inheres-in ?patient 
    ] ;
    ont:has-value-specification [
      a ont:value-specification ;
      ont:has-specified-value ?height ;
      ont:has-unit-label units:cm
    ] ].
  [ a ont:measurement-datum ;
    ont:specified-output-of [
      a ont:weight-assay ;
      ont:part-of ?exam
    ] ;
    ont:specifies-value-of [
      a ont:weight ;
      ont:inheres-in ?patient 
    ] ;
    ont:has-value-specification [
      a ont:value-specification ;
      ont:has-specified-value ?weight ;
      ont:has-unit-label units:kg
    ] ].
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
  ?patient a ont:human ;
    ont:has-quality [ a ?sex ] .
  [ a ont:measurement-datum ;
    ont:specified-output-of [
      a ont:height-assay ;
      ont:part-of ?exam
    ] ;
    ont:specifies-value-of [
      a ont:height ;
      ont:inheres-in ?patient 
    ] ;
    ont:has-value-specification [
      a ont:value-specification ;
      ont:has-specified-value ?height ;
      ont:has-unit-label units:cm
    ] ] .
  [ a ont:measurement-datum ;
    ont:specified-output-of [
      a ont:weight-assay ;
      ont:part-of ?exam
    ] ;
    ont:specifies-value-of [
      a ont:weight ;
      ont:inheres-in ?patient 
    ] ;
    ont:has-value-specification [
      a ont:value-specification ;
      ont:has-specified-value ?weight ;
      ont:has-unit-label units:kg
    ] ].
  ?exam a ont:exam ;
    ont:begins-on ?exam_date ;
}
ORDER BY ?exam
```

Result: [patients.html](patients.html)
