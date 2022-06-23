# spf_check
Check the name resolutions for your spf record to make sure it's within the limit of 10

# Usage

Usage: ./spf_check.sh {domain.tld} {debug}    | debug is optional, accepts true/yes/1 for true and false/no/0 for false (or just don't use)

example #1:
```
$ ./spf_check.sh google.com
Total: 31 (Max lookups: 4)
```

example #2:
```
$ ./spf_check.sh google.com true
_spf.google.com 
  _netblocks.google.com 
    35.190.247.0/24 
    64.233.160.0/19 
    66.102.0.0/20 
    66.249.80.0/20 
    72.14.192.0/18 
    74.125.0.0/16 
    108.177.8.0/21 
    173.194.0.0/16 
    209.85.128.0/17 
    216.58.192.0/19 
    216.239.32.0/19 
  _netblocks2.google.com 
    2001:4860:4000::/36 
    2404:6800:4000::/36 
    2607:f8b0:4000::/36 
    2800:3f0:4000::/36 
    2a00:1450:4000::/36 
    2c0f:fb50:4000::/36 
  _netblocks3.google.com 
    172.217.0.0/19 
    172.217.32.0/20 
    172.217.128.0/19 
    172.217.160.0/20 
    172.217.192.0/19 
    172.253.56.0/21 
    172.253.112.0/20 
    108.177.96.0/19 
    35.191.0.0/16 
    130.211.0.0/22 

Total: 31 (Max lookups: 4)
```
