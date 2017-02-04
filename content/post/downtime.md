+++
description = ""
title = "Downtime"
thumbnail = ""
tags = ["updates"]
categories = []
date = "2016-09-26T01:21:21-06:00"
+++

Currently I have a DNS service [cryo.network](https://github.com/unixvoid/cryo.network) deployed on my main server.  If you have not yet heard of this service, it is a custom self resolving domain aimed at local testing.  Take for instance that I have two webapps that I am currently working on (we'll call them siteA and siteB). In order to test properly (locally) I would traditionally have to run a reverse proxy locally and add some `/etc/hosts` entries to resolve both domains properly on the same system.  Instead of making these changes to my `/etc/hosts` file and having to change them back after testing I can use cryo.network to do the heavy lifting.  If I have my site listen on `siteA.10.0.0.8.cryo.network` and `siteB.10.0.0.8.cryo.network`, [cryo.network](https://github.com/unixvoid/cryo.network) will resolve these domains to `10.0.0.8`.  This works with any IP you want and will also handle CNAME requests if you need it. 

This being said, I need to not only run [cryo.network](https://github.com/unixvoid/cryo.network), but also [cryodns](https://github.com/unixvoid/cryodns) (which is a drop-in replacement for autodns services like dyn.com).  I designed this because I wanted an *open* solution like dyn.com and to handle numerous subdomains at the same time.  To handle running both servers on the same box with the same external IP and port I have made a DNS reverse proxy (think nginx for DNS) [dproxy](https://github.com/unixvoid/dproxy/).  This means that I can run however many DNS servers I want on the same box.  This comes in very handy as DNS servers take little resources (besides network bandwidth) to operate.  Hosting many DNS servers/services on the same box will save money for anyone looking to host multiple DNS services with little overhead.  If you want to learn more about dproxy check out its [github](https://github.com/unixvoid/dproxy) (with extensive documentation in the works).

I plan to take cryo.network down for these changes.  Now I usually use a 0 downtime approach to these kinds of deployments, but since I am moving all my linux containers over to rkt, I am sure I will stumble a bit with the new networking approach before getting the services back online.  I plan to have a downtime of **2 hours** on ~~Monday September 26th~~ Tuesday September 27th *(updated on the 27th)* starting between the hours of 9-11pm CST.

If you want to check out my rkt builds check out [my binder page for rkt](https://cryo.unixvoid.com/bin/rkt/).  There is also metadata in every page that unixvoid.com serves pointing all `rkt fetch`'s to binder.  To pull any of these images just issue the following!

```
rkt fetch unixvoid.com/cryodns
rkt fetch unixvoid.com/cryon
rkt fetch unixvoid.com/dproxy
rkt fetch unixvoid.com/nsproxy
```

As always emails and comments are openly accepted and encouraged!  Also feel free to shoot me a PR on any of my [github projects](https://github.com/unixvoid), I am eager for code review and suggestions.
