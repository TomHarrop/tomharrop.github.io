#!/usr/bin/env python3

import sys
import re


def is_subsection(line):
    return(re.search("subsection\\[", line))


def is_references_subsection(line):
    return(bool(re.search("subsection\\[references\\]", line)))

matched = False
with open(sys.argv[1], 'r') as f:
    for line in f:
        if not matched and re.search("subsection\\[references\\]", line):
            print("\startnegindent\n")
            print(line.strip('\n\r'))
            matched = True
        elif matched and re.search("subsection\\[references\\]", line):
            print(line.strip('\n\r'))
        elif (matched and re.search("subsection\\[", line) and not
              re.search("subsection\\[references\\]", line)):
            print("\stopnegindent\n")
            print(line.strip(' \t\n\r'))
            matched = False
        else:
            print(line.strip('\n\r'))

