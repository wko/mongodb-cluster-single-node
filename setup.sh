#!/usr/bin/env bash

# _js_escape 'some "string" value'
_js_escape() {
	jq --null-input --arg 'str' "$1" '$str'
}


# We need to wait for the mongo instances to be ready
until (mongosh --port 27017 --eval "console.log('Connected');" admin); do sleep 1; done; \


# We need to create the replica set

mongosh --port 27017 admin <<EOF
var config = {
    "_id": "dbrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "127.0.0.1:27017",
            "priority": 3
        },
        {
            "_id": 2,
            "host": "127.0.0.1:27018",
            "priority": 2
        },
        {
            "_id": 3,
            "host": "127.0.0.1:27019",
            "priority": 1
        }
    ]
};
rs.initiate(config, { force: true });
EOF

until (mongosh --port 27017 --eval "rs.status().ok" admin); do sleep 1; done;

# We need to create a user and a password
# https://docs.mongodb.com/manual/tutorial/enable-authentication/
if [ "$MONGO_INITDB_ROOT_USERNAME" ] && [ "$MONGO_INITDB_ROOT_PASSWORD" ]; then
			rootAuthDatabase='admin'

			 CREATE_USER=$( cat <<-EOJS
			 if (db.getUser("$MONGO_INITDB_ROOT_USERNAME") == null) {
				db.createUser({
					user: $(_js_escape "$MONGO_INITDB_ROOT_USERNAME"),
					pwd: $(_js_escape "$MONGO_INITDB_ROOT_PASSWORD"),
					roles: [ 'root' ]
				})
      }
			EOJS)
      until (mongosh admin --port $MONGO_REPLICA_PORT --eval "$CREATE_USER"); do sleep 1; done;
      echo "User Setup Done"
		fi


