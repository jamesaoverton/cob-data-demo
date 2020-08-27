# Wikidata

Example:
- nickel Q744
  - HTML https://www.wikidata.org/wiki/Q744
  - Turtle https://www.wikidata.org/wiki/Special:EntityData/Q744.ttl
- boiling point P2102
  - HTML https://www.wikidata.org/wiki/Property:P2102
- boiling point of nickel 5,139±1 degree Fahrenheit at 760±1 torr

```
wd:Q744
  wdt:P2102 "+5139"^^xsd:decimal ;
  p:P2102 s:Q744-1A250375-1B0D-40FA-92A4-85ABF6176F5E .
s:Q744-1A250375-1B0D-40FA-92A4-85ABF6176F5E a wikibase:Statement,
		wikibase:BestRank ;
	wikibase:rank wikibase:NormalRank ;
	ps:P2102 "+5139"^^xsd:decimal ;
	psv:P2102 v:9a5dd00f2ea19c651b6c65ea6bcce120 ;
	pq:P2077 "+760"^^xsd:decimal ;
	pqv:P2077 v:763d95c3e4cd1ae04f4a0c259f28325e ;
	pqn:P2077 v:1425db8f59b827e5971879fedcc789cc ;
	prov:wasDerivedFrom ref:83eb0461a028911c8b251ad1d4502b8af2ea24cf .
v:9a5dd00f2ea19c651b6c65ea6bcce120 a wikibase:QuantityValue ;
	wikibase:quantityAmount "+5139"^^xsd:decimal ;
	wikibase:quantityUpperBound "+5140"^^xsd:decimal ;
	wikibase:quantityLowerBound "+5138"^^xsd:decimal ;
	wikibase:quantityUnit <http://www.wikidata.org/entity/Q42289> .
```

Classification:

- D4 multiple triples
- P1 many predicates
- custom provenance

- pros
  - very complete
  - very careful about provenance
  - supports many units
- cons
  - very complex
  - seems more focused on the provenance than the data
  - specific to the Wiki
  - supports too many units?


