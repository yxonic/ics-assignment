#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
from subprocess import call

def print_usage():
    print("Usage: python pack.py assignment_number")

prefix = 'PB13011038_阴钰_'

if len(sys.argv) > 1:
    try:
        n = int(sys.argv[1])
    except ValueError:
        print("Please input correct number!")
        print_usage()
        exit()
    os.chdir('dist')
    upload_dir = 'HW' + '%02d' % n
    upload_name = prefix + upload_dir + '.tar.gz'
    call(['tar', '-cvzf', '../archive/' + upload_name, upload_dir])
else:
    print("Please input the assignment number!")
    print_usage()
    exit()
