Simple client-server - Ruby
============================

This is a simple implementation of a client-server model in Ruby. It also demonstrates multithreading i.e. Multiple clients can connect to the server in parallel.

**Server
The server is responsible for returning dictionary meanings of certain words it already has in its database and also expiry dates of drugs available. It uses flat files as its database.

The dictionary database is located at: `database/definitions.yml`
The drugs database is located at: `database/drugs.yml`

**Client
The client prompts you if you want to look up dictionary definitions or drug expiry dates and loops until stopped.


PS: Nothing serious :-)
