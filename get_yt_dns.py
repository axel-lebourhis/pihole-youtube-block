#!env python
# -*- coding: utf-8 -*-

from dnsdumpster.DNSDumpsterAPI import DNSDumpsterAPI
import base64
domain = 'googlevideo.com'

print('Testing... : {}'.format(domain))

res = DNSDumpsterAPI(True).search(domain)

print("####### Domain #######")
print(res['domain'])

print("\n\n\n####### DNS Servers #######")
for entry in res['dns_records']['dns']:
    print(("{domain} ({ip}) {as} {provider} {country}".format(**entry)))

print("\n\n\n####### MX Records #######")
for entry in res['dns_records']['mx']:
    print(("{domain} ({ip}) {as} {provider} {country}".format(**entry)))

print("\n\n\n####### Host Records (A) #######")
for entry in res['dns_records']['host']:
    if entry['reverse_dns']:
        print(("{domain} ({reverse_dns}) ({ip}) {as} {provider} {country}".format(**entry)))
    else:
        print(("{domain} ({ip}) {as} {provider} {country}".format(**entry)))

print("\n\n\n####### TXT Records #######")
for entry in res['dns_records']['txt']:
        print(entry)
