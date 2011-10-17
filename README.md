# LogParslet [![Build Status](https://secure.travis-ci.org/semperos/log_parslet.png)](https://secure.travis-ci.org/semperos/log_parslet.png)

A generic log parser written in Ruby using the Parslet PEG gem.

## Initial Goal ##

Be able to parse this:

```
127.0.0.1 - frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326 "http://www.example.com/start.html" "Mozilla/4.08 [en] (Win98; I ;Nav)"
```
