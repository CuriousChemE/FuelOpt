export CFLAGS="${CFLAGS} -I${PREFIX}/include -L${PREFIX}/lib"

if [ "$(uname)" == "Darwin" ];
then
    export LDFLAGS="${LDFLAGS} -Wl,-rpath,${PREFIX}/lib"
elif [ "$(uname)" == "Linux" ];
then
    export LDFLAGS="${LDFLAGS} -Wl,-rpath=${PREFIX}/lib"
fi

eval "${CC} ${CFLAGS} ${LDFLAGS} test.c -lglpk -o test.out"

./test.out


set -ex



glpsol --mps plan.mps
python setup.py develop test
python test_ctypes.py
test -f ${PREFIX}/lib/libglpk.dylib
exit 0
