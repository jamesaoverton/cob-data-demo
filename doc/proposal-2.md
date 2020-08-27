# Proposal 2

## Classification

- D3 custom datatypes
- P3 punning classes as predicates
- V2 reification

## Construct

```sparql construct.rq
# IMPORT src/prefixes.rq

CONSTRUCT {
  # On this approach we pun qualities (sex, height, weight) as predicates.
  ?patient a ont:human ;
    ont:sex ?sex ;
    ont:height ?height_cm ;
    ont:weight ?weight_kg .

  # Then we use reification to say more about those triples.
  # This is OWL reification, but there's also RDF reification and RDF*.
  [ a owl:Axiom ;
    owl:annotatedSource ?patient ;
    owl:annotatedProperty ont:height ;
    owl:annotatedTarget ?height_cm ;
    ont:determined-by [
      a ont:height-assay ;
      ont:part-of ?exam
    ] ] .

  [ a owl:Axiom ;
    owl:annotatedSource ?patient ;
    owl:annotatedProperty ont:weight ;
    owl:annotatedTarget ?weight_kg ;
    ont:determined-by [
      a ont:weight-assay ;
      ont:part-of ?exam
    ] ] .

  ?exam a ont:exam ;
    ont:begins-on ?examination_date ;
    ont:ends-on ?examination_date .
}
# IMPORT src/where.rq
```

Result: [actual.ttl](actual.ttl)

## Select

WARN: OWLAPI is not happy with OWL annotations pointing to blank nodes.

```sparql select.rq
# IMPORT src/prefixes.rq

SELECT DISTINCT ?exam ?exam_date ?patient ?sex ?height ?weight
WHERE {
  ?patient a ont:human ;
    ont:sex ?sex ;
    ont:height ?height_cm ;
    ont:weight ?weight_kg .

  # Then we use reification to say more about those triples.
  # This is OWL reification, but there's also RDF reification and RDF*.
  [ a owl:Axiom ;
    owl:annotatedSource ?patient ;
    owl:annotatedProperty ont:height ;
    owl:annotatedTarget ?height_cm ;
    ont:determined-by / ont:part-of ?exam ] .

  ?exam a ont:exam ;
    ont:begins-on ?examination_date .
}
```

Result: [patients.html](patients.html)
