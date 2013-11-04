# -*- coding: utf-8 -*-

import datetime
import functools
import random
import sys

def total_mseconds(td):
    return td.microseconds / 1000.0

def bench(func):
    name = "Jython{} 01 ! Array Sum".format(sys.version[0])

    def _wrapper(*args, **kwargs):
        t = datetime.datetime.now()
        result = func(*args, **kwargs)

        delta = total_mseconds(datetime.datetime.now() - t)
        print("[{0}] Elapsed time: {1} msecs ( Result: {2} )".format(name, delta, result))
    return _wrapper


test_list = [[random.randint(0,100) for x in range(500)] for y in range(100)]

@bench
def bench_fn1():
    rdc = lambda x,y: x+functools.reduce(rdc, y, 0) if isinstance(y, list) else x+y
    return functools.reduce(rdc, test_list, 0)

bench_fn1()
