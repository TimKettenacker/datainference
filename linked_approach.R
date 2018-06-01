# define packages
require(SPARQL)
require(stringr)

# define functions
get_wikidata_id <- function(item){
  query <- paste0('SELECT ?item ?itemLabel WHERE { ?item ?itemLabel "', item, '"@en.}' )
  returned_res <- SPARQL(endpoint,query)$results
  item_numbers <- str_extract(returned_res$item,"Q[0-9]+")
  item_id <- item_numbers[!is.na(item_numbers)]
  return(item_id)
}

determine_connected_nodes <- function(item_id, edge_id){
  query <- paste0('SELECT ?parentObj ?parentObjLabel WHERE { wd:', item_id,' wdt:', edge_id, ' ?parentObj .
  SERVICE wikibase:label { bd:serviceParam wikibase:language
                  "[AUTO_LANGUAGE], en". }
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

# get parent objects by looking for relationship triples (i.e. 'instance_of' has Id P31)
# and pass to function which adds the ids and labels of the nodes the item is pointing to
edge_ids <- list(instance_of=c("P31"), subclass_of=c("P279"), part_of=c("P361"))
parentObj_df <- data.frame()
for(i in 1:length(edge_ids)){
  tryCatch({
    resultset <- determine_connected_nodes(item_id = item_id, edge_id = edge_ids[[i]])
    resultset$Relationship <- names(edge_ids[i])
    parentObj_df <- rbind(parentObj_df, resultset)
    print(parentObj_df)},
    error=function(e){cat("ERROR :",conditionMessage(e), "\n")}
  )
}

# ...

# step 3: check how one can traverse the information, maybe build a graph, check suitability 