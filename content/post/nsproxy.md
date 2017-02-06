+++
description = ""
title = "Nsproxy"
thumbnail = ""
tags = ["golang", "dns"]
categories = []
date = "2016-07-10T01:21:21-06:00"
+++


**Nsproxy** is a low overhead DNS based load balancer and cluster manager.

* I designed this tool to be implemented in back-end systems without having to change any application code.  To solve this problem I’ve made all load balancing algorithms implemented over DNS.  
* To do this, we set the host OS to use nsproxy as its nameserver and when any application needs to be added to the load balancer it makes an API call to nsproxy.  Nsproxy then follows the application through the rest of its lifecycle via ICMP/TCP port based health checking.  When the application is deemed unhealthy it will be removed from the load balancer after a configurable grace-period.  Now that the application is registered with nsproxy, any other application trying to connect can do so natively as the hostname will now resolve to a proper load-balanced IP.
* This also takes into consideration that we can use round-robin as well as weight-based load balancing algorithms.  This is just a very short explanation to what the tool is capable of.
* In addition to a cluster manager and load balancer, nsproxy can be used as a full featured DNS proxy.  You can add custom domains via the [api](https://unixvoid.github.io/nsproxy/api/). Nsproxy currently supports A, AAAA, and CNAME requests with more in the works.
* Please feel free to check out the code, use the code, and submit PR's over at [github](https://github.com/unixvoid/nsproxy).

Documentation
=============
All documentation is in the [github wiki](https://unixvoid.github.io/nsproxy/)

* [Configuration](https://unixvoid.github.io/nsproxy/configuration/)  
* [API](https://unixvoid.github.io/nsproxy/api/)  
* [Basic Usage](https://unixvoid.github.io/nsproxy/basic_usage/)  
* [Building](https://unixvoid.github.io/nsproxy/building/)  
* [Redis Usage](https://unixvoid.github.io/nsproxy/redis_data_structures/)
