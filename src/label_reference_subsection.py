#!/usr/bin/env python3

import sys
import re

matched = False
with open(sys.argv[1], 'r') as f:
    for line in f:
        if not matched:
            if re.search("subsection\\[references\\]", line):
                print("\startnegindent\n")
                print(line.strip('\n\r'))
                matched = True
            else:
                print(line.strip('\n\r'))
        elif matched:
            if re.search("subsection", line):
                print("\stopnegindent\n")
                print(line.strip(' \t\n\r'))
                matched = False
            else:
                print(line.strip('\n\r'))
