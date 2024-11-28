#! /bin/bash

aria2c --file-allocation=none -c -j 10 -x 10 --dir ~/Downloads $1