
#!/bin/bash

# select platform

if [ "$1" == "-onlyrc" ]; then
  onlyrc=TRUE
fi



platform=$(uname -i)


if [ -z $onlyrc ]; then

# Update the system
sudo apt-get -y update
sudo apt-get -y upgrade

# Install all tools required to compile Secondo

sudo apt-get -y install flex
sudo apt-get -y install bison
sudo apt-get -y install gcc
sudo apt-get -y install g++
sudo apt-get -y install libdb5.1
sudo apt-get -y install libdb5.1-dev
sudo apt-get -y install libdb5.1++
sudo apt-get -y install libdb5.1++-dev
sudo apt-get -y install db5.1-util
sudo apt-get -y install libjpeg62
sudo apt-get -y install libjpeg62-dev
sudo apt-get -y install libgsl0-dev
sudo apt-get -y install openjdk-6-jdk
sudo apt-get -y install libreadline-dev
sudo apt-get -y install librecode-dev
sudo apt-get -y install libgmp-dev
sudo apt-get -y install libncurses-dev
sudo apt-get -y install libxml2-dev
sudo apt-get -y install libboost-all-dev

#   Install latex and okular to be able to use pdview within Secondo:

sudo apt-get -y install texlive
sudo apt-get -y install okular


#  Deinstall prolog / install java  (not installed in a "fresh" Ubunu installation)
sudo apt-get -y remove swi-prolog
sudo apt-get -y remove swi-prolog-nox
sudo apt-get -y remove swi-prolog-x
sudo apt-get -y remove swi-prolog-java



# Install prolog    

mkdir -p  ~/pl-temp; 
cd ~/pl.temp

fi

PLVER=6.6.5

if [ -z $onlyrc ]; then

wget http://www.swi-prolog.org/download/stable/src/pl-$PLVER.tar.gz

tar -xzf pl-$PLVER.tar.gz

cd pl-$PLVER
./configure --prefix=/usr --without-ssl --without-obdc --without-xpce --without-zlib --enable-shared
make
sudo make install
    
cd packages/jpl

./configure
make
sudo make install

cd $HOME
rm -rf pl-temp

fi


cd $HOME


if [ "$platform" == "i686" ]; then
	echo 'if [ "$1" == "" ]; then' >$HOME/.secondorc
	echo '  SEC_DIR=$HOME/secondo' >>$HOME/.secondorc
	echo 'else' >>$HOME/.secondorc
	echo '  SEC_DIR=$1' >>$HOME/.secondorc
	echo 'fi' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'export SECONDO_PLATFORM=linux' >>$HOME/.secondorc
	echo 'export SECONDO_BUILD_DIR=$SEC_DIR' >>$HOME/.secondorc
	echo 'export BERKELEY_DB_LIB="db_cxx"' >>$HOME/.secondorc
	echo 'export BERKELEY_DB_DIR=/usr' >>$HOME/.secondorc
	echo 'export J2SDK_ROOT=/usr/lib/jvm/java-6-openjdk-i386/' >>$HOME/.secondorc
	echo 'export SWI_HOME_DIR=/usr/lib/swipl-'$PLVER >>$HOME/.secondorc
	echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/i686-linux/' >>$HOME/.secondorc
	echo 'export PL_DLL_DIR=$SWI_HOME_DIR/lib/i686-linux/' >>$HOME/.secondorc
	echo 'export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >>$HOME/.secondorc
	echo 'export PL_VERSION=50647' >>$HOME/.secondorc
	echo 'export JPL_DLL=$PL_LIB_DIR/libjpl.so' >>$HOME/.secondorc
	echo 'export JPL_JAR=$SWI_HOME_DIR/lib/jpl.jar' >>$HOME/.secondorc
	echo 'export SECONDO_JAVA=$J2SDK_ROOT/bin/java' >>$HOME/.secondorc
	echo 'export readline=true' >>$HOME/.secondorc
	echo 'export PATH=$PATH:.:$SECONDO_BUILD_DIR/Tools/pd' >>$HOME/.secondorc
	echo 'export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >>$HOME/.secondorc
	echo 'export JAVAVER="1.6"' >>$HOME/.secondorc
	echo 'export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd.header' >>$HOME/.secondorc
	echo 'export PD_DVI_VIEWER=/usr/bin/okular' >>$HOME/.secondorc
	echo 'export PD_PS_VIEWER=/usr/bin/evince' >>$HOME/.secondorc
	echo 'export PL_LIB=swipl' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'alias secroot='export SECONDO_BUILD_DIR=$PWD'' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PL_LIB_DIR' >>$HOME/.secondorc
else 
	echo 'if [ "$1" == "" ]; then' >$HOME/.secondorc
	echo '  SEC_DIR=$HOME/secondo' >>$HOME/.secondorc
	echo 'else' >>$HOME/.secondorc
	echo '  SEC_DIR=$1' >>$HOME/.secondorc
	echo 'fi' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'export SECONDO_PLATFORM=linux64' >>$HOME/.secondorc
	echo 'export SECONDO_BUILD_DIR=$SEC_DIR' >>$HOME/.secondorc
	echo 'export BERKELEY_DB_LIB="db_cxx"' >>$HOME/.secondorc
	echo 'export BERKELEY_DB_DIR=/usr' >>$HOME/.secondorc
	echo 'export J2SDK_ROOT=/usr/lib/jvm/java-6-openjdk-amd64/' >>$HOME/.secondorc
	echo 'export SWI_HOME_DIR=/usr/lib/swipl-'$PLVER >>$HOME/.secondorc
	echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/x86_64-linux/' >>$HOME/.secondorc
	echo 'export PL_DLL_DIR=$SWI_HOME_DIR/lib/x86_64-linux/' >>$HOME/.secondorc
	echo 'export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >>$HOME/.secondorc
	echo 'export PL_VERSION=50800' >>$HOME/.secondorc
	echo 'export JPL_DLL=$PL_LIB_DIR/libjpl.so' >>$HOME/.secondorc
	echo 'export JPL_JAR=$SWI_HOME_DIR/lib/jpl.jar' >>$HOME/.secondorc
	echo 'export SECONDO_JAVA=$J2SDK_ROOT/bin/java' >>$HOME/.secondorc
	echo 'export readline=true' >>$HOME/.secondorc
	echo 'export PATH=$PATH:.:$SECONDO_BUILD_DIR/Tools/pd' >>$HOME/.secondorc
	echo 'export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >>$HOME/.secondorc
	echo 'export JAVAVER="1.6"' >>$HOME/.secondorc
	echo 'export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd.header' >>$HOME/.secondorc
	echo 'export PD_DVI_VIEWER=/usr/bin/okular' >>$HOME/.secondorc
	echo 'export PD_PS_VIEWER=/usr/bin/evince' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'export LD_LIBRARY_PATH=$BERKELEY_DB_DIR/lib:$SWI_HOME_DIR/lib:$PL_LIB_DIR' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'alias secroot='export SECONDO_BUILD_DIR=$PWD'' >>$HOME/.secondorc
	echo '' >>$HOME/.secondorc
	echo 'export PL_LIB=swipl' >>$HOME/.secondorc
	echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PL_LIB_DIR' >>$HOME/.secondorc
fi




