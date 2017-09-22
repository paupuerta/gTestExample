 ## primer test
 ## test git



```
find ../ -name *.gcda -execdir gcov {} +;

pyshd example_coverage; python -m SimpleHTTPServer; popd

valgrind --tool=memcheck --dsymutil=yes --leak-check=yes --show-reachable=yes --num-callers=20 --track-fds=yes 2>valgrind.out $1


cppcheck --enable=style --template gcc $dir 1>/dev/null




FormatCode

#!/bin/sh
ASTYLE_ARGS="--indent=spaces=4 --brackets=break --indent-switches --indent-labels --pad-header --unpad-paren --convert-tabs --align-pointer=middle --suffix=none --lineend=linux"

for File in $* ; do
    astyle $ASTYLE_ARGS $File
done
```
