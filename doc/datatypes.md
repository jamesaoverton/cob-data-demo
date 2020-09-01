# Datatypes

It would be nice to be able to say `"182"^^:cm`.

## Standards

- RDF triples can have an optional datatype
- XSD datatypes are the only ones in widespread use
  - SPARQL provides some numeric functions and comparisons for XSD integers and floats
- OWL provides tools for custom datatypes, not widely used
  - SPARQL support for custom datatypes is limited, scattered

## D1. Just Literals

- literal strings `"182cm"`
- literal numbers `182`

### Pros and Cons

- pros
  - simple
- cons
  - users must do all the work
  - no access to SPARQL numeric functions or comparisons

## D2. UCUM Strings

`"1 m"^^cdt:ucum`

UCUM Unified Code of Units of Measures is a standard for expressing values with units as strings.
This work proposes to adapt that to RDF,
essentially by providing parsing tools for UCUM strings from RDF literal strings:

https://ci.mines-stetienne.fr/lindt/v3/custom_datatypes#ucum

### Pros and Cons

- pros
  - comprehensive, extensible
  - has a prototype
- cons
  - new, not sure about trajectory/momentum
  - requires major new tooling for actually parsing/using UCUM strings
  - not sure about licensing or support from UCUM

## D3. Custom Datatypes

- `"182"^^units:cm`
- `"1.83"^^units:metre`

### Pros and Cons

- pros
  - clear, compact
- cons
  - only indirect access to SPARQL numerics
    - `BIND(xsd:integer(?height) as ?height_cm)`
  - need to settle on a units ontology
    - do we want just SI units? all sorts of units?
    - use numeric IDs for units, or human-readable names?
  - user is still responsible for conversions

## D4. Multiple Triples

- anonymous `[ ont:has-quantity 182 ; ont:has-unit :cm ]`
- named:

```
ex:1
  ont:has-quantity 182 ;
  ont:has-unit :cm .
```

### Pros and Cons

- pros
  - reuse XSD datatypes
  - full use of SPARQL numerics
  - easy to add more triples (see Provenance)
- cons
  - clumsy
  - have to worry about keeping triples "together"
  - harder to query over
  - need to settle on a units ontology (same as D3)
  - need to settle on predicates

## D5. Units in the Predicate

- `ont:has-length-cm 182`
- `ont:has-height-m 1.82`

### Pros and Cons

- pros
  - reuse XSD datatypes
  - full use of SPARQL numerics
- cons
  - requires lots of new predicates
  - harder to query for length in general (without units)
  - (I think this is hideous)

## D6. Instance of Unit

- `[ a ont:centimetre; ont:numeric-value 182 ]`
- or `[ a units:cm; ont:numeric-value 182 ]`

### Pros and Cons

- pros
  - reuse XSD datatypes
  - full use of SPARQL numerics
- cons
  - ontologically weird? maybe not
  - one more blank node
