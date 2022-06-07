#!/bin/env python3
import sys
data = [line.strip().split('\t')
        for line in sys.stdin
        if not line.startswith('#')]

headers = data[0]
ncols = len(headers)
assert all(len(row) == ncols for row in data)

def fmt(x):
    # round to 3 digits past decimal point
    return format(round(float(x), 3), '.3f')

# transpose
for i, row in enumerate(zip(*data)):
    row = list(row)
    if i > 0:
        # round to 3 digits past decimal point
        for j in range(1, len(row)):
            row[j] = fmt(row[j])
    content = " & ".join(row)
    print(f'{content}')
