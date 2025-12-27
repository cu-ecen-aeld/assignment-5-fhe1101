#!/bin/bash

# run make distclean from the buildroot directory
BUILDROOT=$(dirname "$0")/buildroot
cd "$BUILDROOT" || exit 1
make distclean
echo "Buildroot cleaned."
