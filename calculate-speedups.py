#!/bin/env python3
import sys
data = [line.strip().split('\t')
        for line in sys.stdin
        if not line.startswith('#')]
headers = data[0]
data = data[1:]

ncols = len(headers)
assert all(len(row) == ncols for row in data)

print('\t'.join(headers))
for row in data:
    # ignore first column
    nums = list(map(float, row[1:]))
    big = nums[-1]
    nums = [big/x for x in nums]
    print('\t'.join(row[:1] + list(map(str,nums))))

