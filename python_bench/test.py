# -*- coding: utf-8 -*-

import datetime
import functools
import random
import sys


def bench(func):
    name = ""

    if "pypy" in sys.version.lower():
        name = "PyPy 01 ! Array Sum"
    else:
        name = "Python{} 01 ! Array Sum".format(sys.version[0])

    def _wrapper(*args, **kwargs):
        t = datetime.datetime.now()
        result = func(*args, **kwargs)

        delta = (datetime.datetime.now() - t).total_seconds() * 1000.0
        print("[{0}] Elapsed time: {1} msecs ( Result: {2} )".format(name, delta, result))
    return _wrapper

def generate_list(list_size, numbers_size):
    return [[random.randint(0,100) for x in range(numbers_size)] for y in range(list_size)]

@bench
def bench_fn1(list_size, numbers_size):
    rdc = lambda x,y: x+functools.reduce(rdc, y, 0) if isinstance(y, list) else x+y
    return functools.reduce(rdc, generate_list(list_size, numbers_size), 0)

if __name__ == "__main__":
    bench_fn1(int(sys.argv[1]), int(sys.argv[2]))
