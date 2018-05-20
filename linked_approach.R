# step 1: extract entities from text
# to-do: revise previous code and adjust when applicable
# ...

# step 2: get rich metadata from wikidata
# on SPARQL: https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries
# also provides an excellent query editor for interactive testing

# take the least 'spoiled' R package to SPARQL wikidata without a fancy wrapper
library(SPARQL)

endpoint <- "https://query.wikidata.org/sparql"

# get parent objects by looking for all 'instance of' triplets ('instance_of' has Id P31)
# to-do: this will display only the Ids of the parents, review how to combine/traverse information

query <- 'SELECT ?s ?label ?parent_obj WHERE {
  ?s ?label "MongoDB"@en .
  ?s wdt:P31 ?parent_obj .
}'

qd <- SPARQL(endpoint,query)
df <- qd$results

# ...

# step 3: build graph, check suitability 