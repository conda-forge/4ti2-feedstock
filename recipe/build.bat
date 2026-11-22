@echo on
set PREFIX=%PREFIX:\=/%
set BUILD_PREFIX=%BUILD_PREFIX:\=/%
set SRC_DIR=%SRC_DIR:\=/%
set RECIPE_DIR=%RECIPE_DIR:\=/%
set MSYSTEM=UCRT64
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1
bash -lc "bash \"${RECIPE_DIR}/build.sh\""
if %ERRORLEVEL% neq 0 exit 1
