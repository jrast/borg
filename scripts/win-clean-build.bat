@ECHO ON
REM set BUILD_DIR=..\borg-clean
REM set PYTHON=D:\Python37-x64

REM git clone --branch=win10-cibuild https://github.com/jrast/borg.git %BUILD_DIR%

REM pushd %BUILD_DIR%

%PYTHON%\python.exe -m venv borg-env

call borg-env\Scripts\activate.bat

pip install -r requirements.d/development.txt
pip install wheel pyinstaller

set BORG_OPENSSL_PREFIX=C:\OpenSSL-v111-Win64
set BORG_USE_BUNDLED_B2=YES
set BORG_USE_BUNDLED_LZ4=YES
set BORG_USE_BUNDLED_ZSTD=YES
set BORG_USE_BUNDLED_XXHASH=YES
set PATH=%PATH%;%BORG_OPENSSL_PREFIX%

python setup.py build_ext --inplace
pip install -e .
pyinstaller -y scripts/borg.exe.spec

popd
deactivate

