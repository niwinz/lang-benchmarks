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


def generate_list(list_size, numbers_size):
    return [[random.randint(0,100) for x in range(numbers_size)] for y in range(list_size)]

@bench
def bench_fn1(list_size, numbers_size):
    rdc = lambda x,y: x+functools.reduce(rdc, y, 0) if isinstance(y, list) else x+y
    return functools.reduce(rdc, generate_list(list_size, numbers_size), 0)

bench_fn1(int(sys.argv[1]), int(sys.argv[2]))
