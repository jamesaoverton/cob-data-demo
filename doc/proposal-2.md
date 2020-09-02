# Proposal 2

An alternative to Proposal 1 using punning.

## Classification

- D3 custom datatypes
- P3 punning classes as predicates
- V2 reification

## Pros and Cons

Same as Proposal 1 except:

- pros
  - more elegant?
- cons
  - punning might be a bad idea
  - poor OWLAPI support

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
    ont:begins-on ?exam_date ;
    ont:ends-on ?exam_date .

  # OWLAPI requires predicates used in annotation axioms
  # to be specified as AnnotationProperties.
  ont:determined-by a owl:AnnotationProperty .
  ont:part-of a owl:AnnotationProperty .
}
# IMPORT src/where.rq
```

Result: [actual.ttl](actual.ttl)

## Select

WARN: This did not work for me when `actual.ttl` was passed through OWLAPI.
It did work when using Jena to directly load `actual.ttl`
with `robot --tdb true`.

```sparql select.rq
# IMPORT src/prefixes.rq

SELECT DISTINCT ?exam ?exam_date ?patient ?sex ?height ?weight
WHERE {
  ?patient a ont:human ;
    ont:sex ?sex ;
    ont:height ?height_cm ;
    ont:weight ?weight_kg .

  [ a owl:Axiom ;
    owl:annotatedSource ?patient ;
    owl:annotatedProperty ont:height ;
    owl:annotatedTarget ?height_cm ;
    ont:determined-by / ont:part-of ?exam ] .
  
  [ a owl:Axiom ;
    owl:annotatedSource ?patient ;
    owl:annotatedProperty ont:weight ;
    owl:annotatedTarget ?weight_kg ;
    ont:determined-by / ont:part-of ?exam ] .

  ?exam a ont:exam ;
    ont:begins-on ?exam_date .

  BIND(xsd:integer(?height_cm) as ?height)
  BIND(xsd:integer(?weight_kg) as ?weight)
}
```

Result: [patients.html](patients.html)
