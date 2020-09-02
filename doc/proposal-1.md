# Proposal 1

An OBO-specific solution

Based on [this draft](https://docs.google.com/document/d/14qqp0M2dgefDFMvB4mmwpxrhoo4UGwd1KLZcoWCcqss/edit)

## Classification

- D3 custom datatypes
- P2 few predicates
- V2 reification

## Units Ontology

- OBO includes [Units of measurement ontology](https://github.com/bio-ontology-research-group/unit-ontology)
  - focused on SI
  - not widely used, not much recent development
- we could use UO or consider an alternative

## Pros and Cons

- pros
  - handles qualitative values
  - minimal changes to OBO
  - I like D3 `"182"^^:cm`
  - OBO control
- cons
  - strikes out on our own, again
  - need to decide about units ontology
  - limitations of custom datatypes (D3)

## Construct

```sparql construct.rq
# IMPORT src/prefixes.rq

CONSTRUCT {
  ?patient a ont:human ;
    ont:has-quality [ a ?sex ] ;
    ont:has-quality [
      a ont:height ;
      ont:has-quantity ?height_cm ;
      ont:determined-by [
        a ont:height-assay ;
        ont:part-of ?exam
      ] 
    ] ;
    ont:has-quality [
      a ont:weight ;
      ont:has-quantity ?weight_kg ;
      ont:determined-by [
        a ont:weight-assay ;
        ont:part-of ?exam
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
  ?patient a ont:human ;
    ont:has-quality [ a ?sex ] ;
    ont:has-quality [
      a ont:height ;
      ont:has-quantity ?height_cm ;
      ont:determined-by [
        a ont:height-assay ;
        ont:part-of ?exam
      ] 
    ] ;
    ont:has-quality [
      a ont:weight ;
      ont:has-quantity ?weight_kg ;
      ont:determined-by [
        a ont:weight-assay ;
        ont:part-of ?exam
      ] 
    ] .
  ?exam a ont:exam ;
    ont:begins-on ?exam_date ;
  BIND(xsd:integer(?height_cm) as ?height)
  BIND(xsd:integer(?weight_kg) as ?weight)
}
ORDER BY ?exam
```

Result: [patients.html](patients.html)
