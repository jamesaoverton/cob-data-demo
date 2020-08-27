# QUDT


```sparql construct.rq
# IMPORT patients-prefixes.rq

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
# IMPORT patients-where.rq
```

Discussion

```sparql select.rq
# IMPORT patients-prefixes.rq

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
