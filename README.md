# MONGO DB CLUSTER SETUP FOR TESTING 

Simple cluster setup of mongodb in a single docker container intended for testing with transactions.
It starts and configures a cluster with 3 mongo instances in a single docker container. 
Because it is a cluster transactions are supported.

## Usage

```yml
  mongo:
    build: .
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: admin
    ports:
      - "27017:27017"
      - "27018:27018" # optional
      - "27019:27019" # optional

```
