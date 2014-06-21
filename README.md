Simple client-server - Ruby
============================

This is a simple implementation of a client-server model in Ruby. It also demonstrates multithreading i.e. Multiple clients can connect to the server in parallel.

###Server

---

The server is responsible for returning dictionary meanings of certain words it already has in its database and also expiry dates of drugs available. It uses flat files as its database.

The dictionary database is located at: `database/definitions.yml`

The drugs database is located at: `database/drugs.yml`

###Client

---
The client prompts you if you want to look up dictionary definitions or drug expiry dates and loops until stopped.

###Running

---
On one terminal, boot up the server

```
ruby server.rb
```

This should give you

```
=> Booting server
=> Server successfully listening on 0.0.0.0:3000
=> CTRL-C to shutdown server
[2014-06-21 05:08:10] INFO WXserver 1.2
```

On another terminal, start the client

```
ruby client.rb
```

And this should also give you something similar

```
Welcome to smart server
      Choose an option below
        a) Dictionary Lookup
        b) Drugs Lookup
        c) Exit
 Choice:
```


PS: Nothing serious :-)
