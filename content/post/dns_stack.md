+++
description = ""
title = "Production DNS Stack"
thumbnail = "https://s3.amazonaws.com/unixvoid-blog/office-small.jpg"
tags = ["dns"]
categories = []
date = "2017-02-01T14:07:18-06:00"

+++

Over at [unixvoid.com](https://unixvoid.com) I run a suite of DNS applications running a number of different domains.  I manage these multiple domains across multiple DNS apps **from the same box**.

From the start I knew I wanted to keep operating costs as little as possible (who doesn't) so I started out on a plan to run as many nameservers as I needed from the same domain.  Now the obvious (and easy) answer is to just run multiple domains all from one app, but for me this was impossible.  I'm running the service [cryo.network](https://github.com/unixvoid/cryo.network) as one of the domains (which requires another custom app), so instantly the *single app* approach is out the window.  This is when I created a DNS app called [dproxy](https://github.com/unixvoid/dproxy).  Dproxy is a domain based proxy that works on the DNS level.  It routes each DNS request to its perspective client based on how its configured.  
Here is a small example of how I have dproxy configured in production right now.  

`upstream/cryodns.prox`
```
[*.unixvoid.com]
	address		= 172.31.43.212
	port		= 8054

[unixvoid.com]
	address		= 172.31.43.212
	port 		= 8054
```
`upstream/cryo.network.prox`
```
[*.cryo.network]
	address		= 172.31.43.213
	port		= 8053

[cryo.network]
	address		= 172.31.43.213
	port 		= 8053
```

dproxy uses an INI style configuration for configuring upstream proxies.  The configuration
is set up with a pseudo-nginx feel, where every domain has its own section.  With the custom
configuration setup you can have all domains in one configuration file or break them up per-domain.  
Dproxy works only at the dns level, so you run it on port 53 and then run the upstream servers on different ports.
My current stack looks similar to this:

```
└─ dproxy (:53)
   ├─ cryo.network (:8053)
   ├─ cryodns (:8054)
   └─ nsproxy (:8055)
```
In this example dproxy is exposed and running on port 53.  All DNS traffic comes to it and then routes back to its
respective location (based on what is in the configuration files).  In my case all traffic headed for `cryo.network`
is routed back to 172.31.43.213:8053, all traffic headed for `unixvoid.com` is routed to 172.31.43.212:8054 and so on.
