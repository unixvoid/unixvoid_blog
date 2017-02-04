+++
description = ""
title = "Welcome to the void"
thumbnail = ""
tags = []
categories = []
date = "2015-12-23T01:21:21-06:00"
+++
![unixvoid logo](https://bitnuke.io/7X57w)

This webpage is a container for my dotFiles, please feel free to use and modify them to your content

The blog will be bare for a little while, I plan to start a small blog about all things linux and all the small projects that I am working on. Until I have some free time away from work and school I don't plan on filling it.

Here is some test code:

```
package main

import (

	"net/http"
)


func main() {

	http.Handle("/", handlerstatic)
	err := http.ListenAndServe(":80", nil)
	if nil != err {
		panic(err)
	}
}

func handlerstatic(w http.ResponseWriter, r *http.Request) {
	http.FileServer(http.Dir("./tmpnuke/"))
}
```
