# SIO: Semanticscience Integrated Ontology

## Measurements

https://github.com/MaastrichtU-IDS/semanticscience/wiki/DP-Measurements

```
'measurement of x' 
subClassOf 
 'quantity' 
 and 'has value' some Literal 
 and 'has unit' some 'measurement unit' 
 and 'is attribute of' some ( 'object' and 'is part of' some 'object' )`
```

### Notes

I don't understand how a quantity is an attribute of an object, but I guess it's a link to the attribute being measured.

## Classification

- D4 multiple triples
- P2 few predicates
- V1 cluster of triples

## Provenance

https://github.com/MaastrichtU-IDS/semanticscience/wiki/DP-Provenance

## Construct

WARN: I'm not sure how to handle the qualitative case.

```sparql construct.rq
# IMPORT src/prefixes.rq

CONSTRUCT {
  [ a ont:quantity ;
    ont:has-value ?height ;
    ont:has-unit units:cm ;
    ont:is-output-of ?exam ;
    ont:measured-at ?exam_date ;
    ont:is-attribute-of [
      a ont:height ;
      ont:part-of ?patient
    ] ] .

  [ a ont:quantity ;
    ont:has-value ?weight ;
    ont:has-unit units:kg ;
    ont:is-output-of ?exam ;
    ont:measured-at ?exam_date ;
    ont:is-attribute-of [
      a ont:weight ;
      ont:part-of ?patient
    ] ] .

  ?exam a ont:exam .
}
# IMPORT src/where.rq
```

Result: [actual.ttl](actual.ttl)

## Select

```sparql select.rq
# IMPORT src/prefixes.rq

SELECT DISTINCT ?exam ?exam_date ?patient ?sex ?height ?weight
WHERE {
  ?height_quality
    a ont:quantity ;
    ont:has-value ?height ;
    ont:has-unit units:cm ;
    ont:is-output-of ?exam ;
    ont:measured-at ?exam_date ;
    ont:is-attribute-of [
      a ont:height ;
      ont:part-of ?patient
    ] .

  ?weight_quality
    a ont:quantity ;
    ont:has-value ?weight ;
    ont:has-unit units:kg ;
    ont:is-output-of ?exam ;
    ont:measured-at ?exam_date ;
    ont:is-attribute-of [
      a ont:weight ;
      ont:part-of ?patient
    ] .
}
ORDER BY ?exam
```

Result: [patients.html](patients.html)
