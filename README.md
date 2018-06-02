# datainference

I came across this idea during my consulting work for a client. The client project was dedicated to make all meta(data) within the enterprise findable, accessible and interoperable, and soon dedicated resources were provided, equipped with a bag of approaches to make this vision work. Among them was the use of ontologies to link representative findings discovered by data scientists.  

One particular underrated category within the cause of data management is the representation of knowledge, or at least linkages between entities. Classical data modelling always seems to focus on technical necessities to fuel application engines rather than providing means of interoperability and inference. Graphs and ontologies promise to structure knowledge, that's why my natural interest turned to them over the last couple of months. Furthermore, structuring knowledge lies at the heart of artifical intelligence. 

Setting up ontologies is quite cumbersome, so I turned to an existing one in my private project, and decided to leverage on Wikidata (http://www.wikidata.org/wiki/Wikidata:Main_Page). Wikidata is a project sponsored by the wikimedia foundation with the goal to structure the content of Wikipedia to make it accessible and editable by both humans and machines. Hence, it can support a broad range of use cases. I decided to go with a classical one, like staffing consultants to an upcoming project or finding a suitable applicant to a job offer. People from the business side frequently struggle to concretize from a notion or - the other way around - generalize from a detailed term to the overall picture, i.e. an HR person tasked with finding someone with the skillset "MongoDB" will most likely ignore a person with "Neo4j" skills although the skillset is likely to be similar. This is because connecting information is missing or too difficult to collect in a timely manner. The project aims at exploring this phenomenon, thereby touching on a variety of modern data-driven topics:

First, retrieving profiles from the internet, with some of it being structured information, others text. Entity recognition might come in handy to correctly model the information. This is also where the application enriches clearly defined objects extracted from the profiles with related information by connecting to wikidata. This is all done relative to the skillset required by a project, a job offer... Wikidata thus serves as the middlepiece. Information objects are then being compared in a graph to each other in order to find the perfect match.

A bunch of machine learning algorithms will be evaluated:

The main point behind graph-based machine learning becomes to learn features of nodes in networks, considering the actual network structure. Any node can therefore be described as a vector.

The goal is to map each node into a low-dimensional space. The number of nodes and their connections are arbitrary, complicating feeding it to neural networks, in turn. Graph embedding is a solution for it.

node2vec tries to find embedding of nodes in a dimension that preserve similarity. Hence, nearby nodes need to be close together. Neighborhoods of a node need to be identified. One solution is to randomly walk from a node and at every step take the decision on whether to go back to the last visited node or keep going. Afterwards, one can run a stochastic gradient descent to find the best path.
-> this could work on my problem, since it is a task-independent feature learning approach that gets more complicated with the size of the network, which is not necessarily the case in my scenario.

https://towardsdatascience.com/graph-representation-learning-dd64106c9763
https://towardsdatascience.com/node2vec-embeddings-for-graph-data-32a866340fef


A neural network model is first applied to a text corpus to learn word embeddings, i.e. a mathematical vector representation of the meaning of each word. The dense embedding vectors are then used to build a sparse graph where nodes correspond to words and edges represent semantic relationship between them.
-> this is helpful, since the description of the edges matches exactly my problem

https://ai.googleblog.com/2016/10/graph-powered-machine-learning-at-google.html

