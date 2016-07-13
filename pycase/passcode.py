#!/usr/bin/env python
from collections import defaultdict

def problem1():
    attempts = ['319', '680', '180', '690', '129', '620', '762', '689', '762', '318', 
                '368', '710', '720', '710', '629', '168', '160', '689', '716', '731', 
                '736', '729', '316', '729', '729', '710', '769', '290', '719', '680', 
                '318', '389', '162', '289', '162', '718', '729', '319', '790', '680', 
                '890', '362', '319', '760', '316', '729', '380', '319', '728', '716']
    
    appearances = defaultdict(list)
    for attempt in attempts:
        for i, n in enumerate(attempt):
            appearances[n].append(i)
    
    average_positions = {}
    for k, v in list(appearances.items()):
        print k, v
        average_positions[k] = float(sum(v)) / float(len(v))
    
    print average_positions

    a = [k for k, v in sorted(list(average_positions.items()), key=lambda a: a[1])]
    print a
    print(''.join(str(x) for x in a))

if __name__ == "__main__":
    problem1()
