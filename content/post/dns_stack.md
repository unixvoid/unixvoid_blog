+++
description = ""
title = "Production DNS Stack"
thumbnail = "https://s3.amazonaws.com/unixvoid-blog/office-small.jpg"
tags = ["dns"]
categories = []
date = "2017-02-01T14:07:18-06:00"

+++

Over at [unixvoid.com](https://unixvoid.com) I run a suite of DNS applications running a number of different domains.  I manage these multiple domains across multiple DNS apps from the same host.

From the start I knew I wanted to keep operating costs as little as possible (who doesn't) so I started out on a plan to run as many nameservers as I needed from the same domain.  Now the obvious (and easy) answer is to just run multiple domains all from one app, but for me this was impossible.  I'm running the service [cryo.network](https://github.com/unixvoid/cryo.network) as one of the domains which requires another custom app, so instantly the *single app* approach is out the window.  This is when I created a DNS app called [dproxy](https://github.com/unixvoid/dproxy).  Dproxy is a domain based proxy that works on the DNS level.  It routes each DNS request to its perspective client based on how its configured.  
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
	address		= 172.31.43.212
	port		= 8053

[cryo.network]
	address		= 172.31.43.212
	port 		= 8053
```

dproxy uses an INI style configuration for configuring upstream proxies.  dproxy
parses these configurations at runtime and effects will not be implemented until
the application is restarted.  These upstream files can be all crammed into one
file, split into different files per domain, or a mix of both.  By default all
domain configs are stored in the directory `upstream/`, and all of the files
must have the file extention `.prox`.  Both of these settings (directory and
extension) can be set in the main server configuration file.
