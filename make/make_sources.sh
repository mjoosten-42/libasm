#!/bin/bash

echo "SOURCES := \\" > make/sources.mk;
find src -type f -name '*.s' | awk '{print "\t" $0 " \\"}' >> make/sources.mk ;

