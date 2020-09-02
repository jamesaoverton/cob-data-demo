# Predicates

How to link our data?

## P1. Many Predicates

```turtle
ont:has-height
ont:has-weight
ont:has-height-cm
```

### Pros and Cons

- pros
  - maybe solves the datatype problem (D5 unit in predicate)
- cons
  - OBO has many classes but minimal predicates
  - would require a lot of new predicates
    - one for each quality, or group/branch of qualities

## P2. Few Predicates

```turtle
ont:has-quantity
ont:has-value
ont:has-numeric-value
```

### Pros and Cons

- pros
  - simple
  - no major change to OBO classes
- cons
  - pushes information to other parts of the triple, such as the datatype

## P3. Punning Quality Classes as Predicates

both a class and a predicate

```turtle
ont:height
ont:sex
```

### Pros and Cons

- pros
  - reuse existing quality terms
  - kind of elegant
  - maybe better for the Knowledge Graph use case
- cons
  - makes OWLAPI cry
  - invites confusion
  - probably hard to do hierarchical queries
