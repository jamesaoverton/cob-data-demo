import csv
import re

label2id = {}

paths = [
  "src/external.tsv",
  "src/class.tsv",
  "src/predicate.tsv",
  "src/example.tsv",
]
for path in paths:
    with open(path) as f:
        rows = csv.DictReader(f, delimiter="\t")
        for row in rows:
            label2id[row["Label"]] = row["Ontology ID"]

with open("src/prefix.tsv") as f:
    rows = csv.DictReader(f, delimiter="\t")
    for row in rows:
        print(f"""@prefix {row["prefix"]}: <{row["base"]}> .""")

print()

print("""<http://example.com/example.ttl>
  a owl:Ontology ;
  owl:imports <http://example.com/demo.owl> .
""")

missing = set()

def replace(match):
    label = match.group(1)
    if label in label2id:
        return label2id[match.group(1)]
    else:
        raise Exception(f"Label not found for '{label}'")
        missing.add(label)
    #return f"'{label}'"
    id = re.sub(r"\W+", "-", label)
    return f"value:example-{id}"

with open("example.txt") as f:
    for line in f.readlines():
        line = line.rstrip()
        content = line
        comment = ""
        if "#" in line:
            content, comment = line.split("#", maxsplit=1)
        content = re.sub(r"'(.*?)'", replace, content)

        if comment:
            print(f"{content}#{comment}")
        else:
            print(content)

print()
print("# MISSING", missing)
