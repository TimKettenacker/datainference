# define packages
require(SPARQL)
require(stringr)

# define functions
get_wikidata_id <- function(item){
  query <- paste0('SELECT ?item ?itemLabel WHERE { ?item ?itemLabel "', item, '"@en.}' )
  returned_res <- SPARQL(endpoint,query)$results
  item_numbers <- str_extract(returned_res$item,"\\(?[0-9]+\\)?")
  item_id <- item_numbers[!is.na(item_numbers)]
  return(item_id)
}

determine_parent_instances <- function(item_id){
  query <- paste0('SELECT ?parent ?parentLabel WHERE { wd:Q', item_id,' wdt:P31 ?parent .
  SERVICE wikibase:label { bd:serviceParam wikibase:language
                  "[AUTO_LANGUAGE],en". }
                  }')
  returned_res <- SPARQL(endpoint,query)$results
  return(returned_res)
}

# step 1: extract entities from text
# to-do: revise previous code and adjust when applicable
# ...

item <- "MongoDB"

# step 2: get rich metadata from wikidata via the SPARQL services from: https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries
# (also provides an excellent query editor for interactive testing)
# https://www.wikidata.org/wiki/Wikidata:SPARQL_tutorial

endpoint <- "https://query.wikidata.org/sparql"

# retrieve wikidata id for the item value
item_id <- get_wikidata_id(item = item)

# get parent objects by looking for all 'instance of' triplets ('instance_of' has Id P31)
# this will display Ids and labels of the parents the item is pointing to
instance_of_id <- determine_parent_instances(item_id)

# ...

# step 3: check how one can traverse the information, maybe build a graph, check suitability 