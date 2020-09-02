# Provenance

How to add more information?

## Problem

- one triple is rarely enough
- usually want to link to
  - measurement process
  - date/time
  - investigator

## V1. Clusters of Triples

Use the same subject, maybe a blank node

```turtle
[ a ont:height ;
  # your quantitative triples
  ont:determined-by ex:some-assay ;
  ont:confidence 0.8 ] .
```

### Pros and Cons

- pros
  - simple
- cons
  - need to keep triples together, avoid mixing
  - need to enforce "shape"
  
## V2. Reification

1. RDF reification
2. OWL annotations (most common on OBO)
3. RDF*: an emerging standard, not 
4. named graphs (RDF datasets): works well for making statements about sets of triples, but not individual triples

### Reification

- when working with OWL, only 2 is an option
- 1,2,3 are (probably) isomorphic

### Pros and Cons

- pros
  - can be very precise
  - can be very clean
- cons
  - harder to query, more blank nodes and nesting
  - maybe harder to think about: statements about statements
  - rival standards
  - OWLAPI bugs for nested cases

