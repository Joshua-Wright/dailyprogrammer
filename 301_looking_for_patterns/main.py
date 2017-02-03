#!/usr/bin/env python3
import os, sys
def match(pattern, word):
    matches = {}
    if len(word) < len(pattern):
        # no string left to match
        return False
    for (x,p) in zip(word, pattern):
        if not p in matches:
            matches[p] = x
        elif matches[p] != x:
            return match(pattern, word[1:])
    return True
if __name__ == "__main__":
    database = set()
    with open(sys.argv[1], 'r') as f:
        database = set(f.read().split('\n'))
    # pattern = raw_input()
    pattern = sys.argv[2]
    for word in database:
        if match(pattern, word):
            print(word)
