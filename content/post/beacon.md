+++
description = ""
title = "Beacon"
thumbnail = ""
tags = ["golang"]
categories = []
date = "2016-07-10T01:21:21-06:00"
+++

**Beacon** is a global key-value discovery service.  

* I designed this small tool originally for nsproxy to register, on start, and for clients to automatically connect to the instance but can be used in many more applications.
* Like most of my projects, I use Redis as a backend to track (and persist) any data/data-structures needed.  The interesting thing about beacon is the backend Redis model.  No plain text entries are stored in the database, only sha3:512 hashed keys that can be viewed with a generated token (this token is provisioned when requesting a new id).  
* The beacon API is publicly accessible at https://beacon.unixvoid.com, feel free to provision your new ID and keep on building cool tools!
* Without going into any more detail, [beacon](https://github.com/unixvoid/beacon) and its [client](https://github.com/unixvoid/beacon-client) can be found in [github](https://github.com/unixvoid).

Documentation
=============
All documentation is in the [github wiki](https://github.com/unixvoid/beacon/wiki)  

* [Configuration](https://github.com/unixvoid/beacon/wiki/Configuration)
* [API](https://github.com/unixvoid/beacon/wiki/API)
* [Redis](https://github.com/unixvoid/beacon/wiki/Redis)
* [SSL](https://github.com/unixvoid/beacon/wiki/SSL)
