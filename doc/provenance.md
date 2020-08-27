# Provenance

One triple is rarely enough.
We usually want to say more about a measurement, e.g.
where it came from, how it was done, who did it.

We have two main options: "clusters" of triples or reification

## V1. Clusters of Triples

Use the same subject, maybe a blank node.

- pros
  - simple
- cons
  - need to keep triples together, avoid mixing
  - need to enforce "shape"
  
## V2. Reification

We can "reify" an RDF triple and say more things about it in four different ways:

1. RDF reification
2. OWL annotations (most common on OBO)
3. RDF*: an emerging standard, not 
4. named graphs (RDF datasets): works well for making statements about sets of triples, but not individual triples

When working with OWL, only 2 is an option.
But 1,2,3 are (probably) isomorphic.

- pros
  - can be very precise
  - can be very clean
- cons
  - harder to query, more blank nodes and nesting
  - maybe harder to think about: statements about statements
  - rival standards


