#!/usr/bin/bash
PWD=$(pwd)
echo -e "Generating file list"
# ack -f --python --ignore-dir ${PWD}/ > cscope.files
find ${PWD}/ -name "*.py" > cscope.files
echo -e "Generating file cross-reference"
cscope -q -b -i cscope.files -f cscope.out
echo -e "Generating file cross-reference done"
echo -e "Generating file tags"
ctags -L cscope.files
echo -e "Generating file tags done"
