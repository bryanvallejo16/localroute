#!/bin/sh
BASE=${1%.*}
BASE=${BASE%-main}

python ../bin/closurebuilder.py -i ../src/$BASE-main.js ../src/$BASE-main.js --root=../src/gis --root=../src/reach --root=../shim |
sed -e "s/^/--js /" |
xargs java -jar ../bin/compiler.jar \
--jscomp_warning checkTypes \
--jscomp_warning reportUnknownTypes \
--jscomp_warning undefinedVars \
--jscomp_warning uselessCode \
--summary_detail_level 3 \
--compilation_level ADVANCED_OPTIMIZATIONS \
--closure_entry_point main \
--js_output_file ../dist/$BASE.js \
--externs ../src/extern.js \
--manage_closure_dependencies true \
2>report.txt
#--formatting PRETTY_PRINT --debug \

cat report.txt