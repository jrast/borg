@ECHO ON
REM set BUILD_DIR=..\borg-clean
REM set PYTHON=D:\Python37-x64

REM git clone --branch=win10-cibuild https://github.com/jrast/borg.git %BUILD_DIR%

REM pushd %BUILD_DIR%

REM Build Configuration for Borg.
REM The openssl version is defined in the .appveyor file.
REM set BORG_OPENSSL_PREFIX=C:\OpenSSL-v111-Win64
set BORG_USE_BUNDLED_B2=YES
set BORG_USE_BUNDLED_LZ4=YES
set BORG_USE_BUNDLED_ZSTD=YES
set BORG_USE_BUNDLED_XXHASH=YES
set PATH=%PATH%;%BORG_OPENSSL_PREFIX%

REM Create and use a virtual environment for the build
%PYTHON%\python.exe -m venv borg-env
call borg-env\Scripts\activate.bat

REM Install development and build requirements
pip install -r requirements.d/development.txt
pip install wheel pyinstaller

REM If libcrypto is not copied to the project root, the dll is not included
REM in the pyinstaller package. This seems to be a appveyor issue.
copy %BORG_OPENSSL_PREFIX%\bin\libcrypto* .\

REM Build the extensions inplace
python setup.py build_ext --inplace

REM Install package (to ensure install_requires are installed)
pip install -e .

REM Build wheel and single file executable
python setup.py bdist_wheel
pyinstaller -y scripts/borg.exe.spec
