rm -rf libffmpeg.wasm libffmpeg.js
export TOTAL_MEMORY=67108864
export EXPORTED_FUNCTIONS="[ \
    '_initDecoder', \
    '_uninitDecoder', \
    '_openDecoder', \
    '_closeDecoder', \
    '_sendData', \
    '_decodeOnePacket', \
    '_seekTo', \
    '_main',	\
    '_malloc',	\
    '_free'	\
]"

echo "Running Emscripten..."
emcc decoder.c dist/lib/libavformat.a dist/lib/libavcodec.a dist/lib/libavutil.a dist/lib/libswscale.a \
    -O3 \
    -I "dist/include" \
    -s WASM=1 \
    -s TOTAL_MEMORY=${TOTAL_MEMORY} \
    -s EXPORTED_FUNCTIONS="${EXPORTED_FUNCTIONS}" \
    -s EXTRA_EXPORTED_RUNTIME_METHODS="['addFunction']" \
    -s RESERVED_FUNCTION_POINTERS=14 \
    -s FORCE_FILESYSTEM=1 \
    -o libffmpeg.js

echo "Finished Build"


#固定内存
emcc decoder.c dist/lib/libavformat.a dist/lib/libavcodec.a dist/lib/libavutil.a dist/lib/libswscale.a   dist/lib/libswresample.a dist/lib/libdavs3.a -O3 -I "dist/include"   -s ASSERTIONS=1  -g   -s WASM=1  -s TOTAL_MEMORY=67108864  -s EXPORTED_FUNCTIONS="['_initDecoder', '_uninitDecoder', '_openDecoder', '_closeDecoder', '_sendData', '_decodeOnePacket', '_seekTo', '_main',	'_malloc',	'_free'	]"  -s EXTRA_EXPORTED_RUNTIME_METHODS="['addFunction']" -s RESERVED_FUNCTION_POINTERS=14 -s FORCE_FILESYSTEM=1 -o libffmpeg.js


#内存动态增加
emcc decoder.c dist/lib/libavformat.a dist/lib/libavcodec.a dist/lib/libavutil.a dist/lib/libswscale.a   dist/lib/libswresample.a  dist/lib/libdavs3.a -O3 -I "dist/include"  -s WASM=1 -s ASSERTIONS=1  -g  -s ALLOW_MEMORY_GROWTH=1  -s EXPORTED_FUNCTIONS="['_initDecoder', '_uninitDecoder', '_openDecoder', '_closeDecoder', '_sendData', '_decodeOnePacket', '_seekTo', '_main',	'_malloc',	'_free'	]"  -s EXTRA_EXPORTED_RUNTIME_METHODS="['addFunction']" -s RESERVED_FUNCTION_POINTERS=14 -s FORCE_FILESYSTEM=1 -o libffmpeg.js


#WASM = 0  无法运行
emcc decoder.c dist/lib/libavformat.a dist/lib/libavcodec.a dist/lib/libavutil.a dist/lib/libswscale.a   dist/lib/libswresample.a  -O3 -I "dist/include"  -s WASM=0  -s TOTAL_MEMORY=67108864  -s EXPORTED_FUNCTIONS="['_initDecoder', '_uninitDecoder', '_openDecoder', '_closeDecoder', '_sendData', '_decodeOnePacket', '_seekTo', '_main',	'_malloc',	'_free'	]"  -s EXTRA_EXPORTED_RUNTIME_METHODS="['addFunction']" -s RESERVED_FUNCTION_POINTERS=14 -s FORCE_FILESYSTEM=1 -o libffmpeg.js


emcc decoder.c dist/lib/libavformat.a dist/lib/libavcodec.a dist/lib/libavutil.a dist/lib/libswscale.a   dist/lib/libswresample.a  dist/lib/libdavs3.a -O2 -I "dist/include"  -s WASM=1 -s ASSERTIONS=1  -g  -s ALLOW_MEMORY_GROWTH=1   -s INITIAL_MEMORY=33554432  -s EXPORTED_FUNCTIONS="['_initDecoder', '_uninitDecoder', '_openDecoder', '_closeDecoder', '_sendData', '_decodeOnePacket', '_seekTo', '_main',	'_malloc',	'_free'	]"  -s EXPORTED_RUNTIME_METHODS="['addFunction']" -s RESERVED_FUNCTION_POINTERS=14 -s FORCE_FILESYSTEM=1 -s USE_PTHREADS=1 -o libffmpeg.js


#用这个
emcc decoder.c dist/lib/libavformat.a dist/lib/libavcodec.a dist/lib/libavutil.a dist/lib/libswscale.a   dist/lib/libswresample.a  dist/lib/libdavs3.a -O1 -I "dist/include"  -s WASM=1 -s ASSERTIONS=1  -g  -s ALLOW_MEMORY_GROWTH=1   -s INITIAL_MEMORY=33554432  -s EXPORTED_FUNCTIONS="['_initDecoder', '_uninitDecoder', '_openDecoder', '_closeDecoder', '_sendData', '_decodeOnePacket', '_seekTo', '_main',	'_malloc',	'_free'	]"  -s EXPORTED_RUNTIME_METHODS="['addFunction']" -s RESERVED_FUNCTION_POINTERS=14 -s FORCE_FILESYSTEM=1 -s PTHREAD_POOL_SIZE=32 -s USE_PTHREADS  -sALLOW_TABLE_GROWTH -sLLD_REPORT_UNDEFINED   -o libffmpeg.js



