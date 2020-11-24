
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
sudo apt-get -y install flex bison gcc g++ libdb5.3 libdb5.3-dev libdb5.3++ libdb5.3++-dev db5.3-util libjpeg62 libjpeg62-dev libgsl0-dev openjdk-8-jdk libreadline-dev librecode-dev libgmp-dev libncurses-dev libxml2-dev original-awk libquadmath0 libgmp-dev libgmp10 original-awk libboost-all-dev libbison-dev

#   Install latex and okular to be able to use pdview within Secondo:
sudo apt-get -y install texlive okular

#  Deinstall prolog / install java  (not installed in a "fresh" Ubunu installation)
sudo apt-get -y install swi-prolog swi-prolog-nox swi-prolog-x swi-prolog-java

fi


cd $HOME


PLVER=$(swipl --version | awk {'print $3'})

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
	echo 'export J2SDK_ROOT=/usr/lib/jvm/java-8-openjdk-i386/' >>$HOME/.secondorc
	echo 'export SWI_HOME_DIR=/usr/lib/swi-prolog' >>$HOME/.secondorc
	echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/i386/' >>$HOME/.secondorc
	echo 'export PL_DLL_DIR=$PL_LIB_DIR' >> $HOME/.secondorc
	echo 'export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >>$HOME/.secondorc
	echo 'export PL_VERSION=70203' >>$HOME/.secondorc
	echo 'export JPL_DLL=$PL_LIB_DIR/libjpl.so' >>$HOME/.secondorc
	echo 'export JPL_JAR=$SWI_HOME_DIR/lib/jpl.jar' >>$HOME/.secondorc
	echo 'export readline=true' >>$HOME/.secondorc
	echo 'export PATH=$PATH:.:$SECONDO_BUILD_DIR/Tools/pd' >>$HOME/.secondorc
	echo 'export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >>$HOME/.secondorc
	echo 'export JAVAVER="1.8"' >>$HOME/.secondorc
	echo 'export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd_header_listing' >>$HOME/.secondorc
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
	echo 'export J2SDK_ROOT=/usr/lib/jvm/java-8-openjdk-amd64/' >>$HOME/.secondorc
	echo 'export SWI_HOME_DIR=/usr/lib/swi-prolog' >>$HOME/.secondorc
       if [ -f "/usr/lib/swi-prolog/lib/x86_64/libjpl.so" ]; then
	echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/x86_64/' >>$HOME/.secondorc
       else
	echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/amd64/' >>$HOME/.secondorc
       fi
	echo 'export PL_DLL_DIR=$PL_LIB_DIR' >> $HOME/.secondorc
	echo 'export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >>$HOME/.secondorc
	echo 'export PL_VERSION=70203' >>$HOME/.secondorc
	echo 'export JPL_DLL=$PL_LIB_DIR/libjpl.so' >>$HOME/.secondorc
	echo 'export JPL_JAR=$SWI_HOME_DIR/lib/jpl.jar' >>$HOME/.secondorc
	echo 'export readline=true' >>$HOME/.secondorc
	echo 'export PATH=$PATH:.:$SECONDO_BUILD_DIR/Tools/pd' >>$HOME/.secondorc
	echo 'export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >>$HOME/.secondorc
	echo 'export JAVAVER="1.8"' >>$HOME/.secondorc
	echo 'export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd_header_listing' >>$HOME/.secondorc
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




