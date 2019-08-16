#!/bin/sh

# Immediately terminate script on any error
set -e

# Verify that vasmm68k_mot is on the command line, and can assemble a minimal example program
vasmm68k_mot -Fhunk -o test.o test.s

# Verify that vlink is on the command line, and can produce an Amiga executable
vlink -bamigahunk -o test.exe test.o

# Verify that testrunner-68k is on the command line, and can run tests within the executable
testrunner-68k test.exe
