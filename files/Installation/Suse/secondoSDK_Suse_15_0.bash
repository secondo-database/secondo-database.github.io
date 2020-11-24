#!/bin/bash

# first step: add repositories

if [ "$1" == "-onlyrc" ]; then
 onlyrc=TRUE
fi

if [ -z $onlyrc ]; then


VERSION=$(cat /etc/os-release  | grep "VERSION=" | sed 's/VERSION=//g' | sed 's/"//g' | sed 's/ //g')

# add oss if not present
REP=$(zypper lr -d | grep "http://download.opensuse.org/distribution/leap/$VERSION/repo/oss/" | wc -l)

if [ $REP -eq 0 ]; then
	echo "Add repository http://download.opensuse.org/distribution/leap/$VERSION/repo/oss/"
	sudo zypper ar -f http://download.opensuse.org/distribution/$VERSION/repo/oss/ Secondo_OSS
else
	echo "repository http://download.opensuse.org/distribution/leap/$VERSION/repo/oss/ is present"
fi


#add non-oss if not present

REP=$(zypper lr -d | grep "http://download.opensuse.org/distribution/leap/$VERSION/repo/non-oss/" | wc -l)

if [ $REP -eq 0 ]; then
	echo "Add repository http://download.opensuse.org/distribution/leap/$VERSION/repo/non-oss/"
	sudo zypper ar -f http://download.opensuse.org/distribution/leap/$VERSION/repo/non-oss/ Secondo_NON_OSS
else
	echo "Repository http://download.opensuse.org/distribution/leap/$VERSION/repo/non-oss/ is present"
fi

# add update if not present


REP=$(zypper lr -d | grep "http://download.opensuse.org/update/leap/$VERSION/" | wc -l)

if [ $REP -eq 0 ]; then
	echo "Add repository http://download.opensuse.org/update/leap/$VERSION/ "
	sudo zypper ar -f http://download.opensuse.org/update/$VERSION/  Secondo_UPDATE
else
	echo "Repository http://download.opensuse.org/update/leap/$VERSION/ is present"
fi


# second step: install required packages

PACKAGES="make flex bison libjpeg62-devel swipl gsl-devel readline-devel gmp-devel gcc gcc-c++ graphviz-devel recode-devel libxml2-devel"

PACKAGES+=" java-1_8_0-openjdk-devel"



echo "Install the following packages:"
echo "$PACKAGES"

for p in $PACKAGES; do sudo zypper -q -n  in $p ; done

echo "Secondo SDK almost installed." 

fi


platform=$(uname -i)
PLVER=$(swipl --version| awk {'print $3'})


echo "Create file $HOME/.secondorc"
if [ $platform == "x86_64" ]; then
  echo '   if [ -n "$1" ]; then' > $HOME/.secondorc
  echo '      export SECONDO_BUILD_DIR=$1' >> $HOME/.secondorc
  echo '   else' >> $HOME/.secondorc
  echo '     export SECONDO_BUILD_DIR=$PWD' >> $HOME/.secondorc
  echo '    fi' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export SECONDO_PLATFORM=linux64' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    # berkeley db' >> $HOME/.secondorc
  echo '    export BDB_DIR=$HOME/BDB' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export BERKELEY_DB_DIR=$BDB_DIR' >> $HOME/.secondorc
  echo '    export BERKELEY_DB_LIB=db_cxx' >> $HOME/.secondorc
  echo '    export BDB_INCLUDE_DIR=$BDB_DIR/include' >> $HOME/.secondorc
  echo '    export BDB_LIB_DIR=$BDB_DIR/lib64' >> $HOME/.secondorc
	echo '    if [ ! -d "$BDB_LIB_DIR" ]; then' >> $HOME/.secondorc
  echo '       ln -s $BDB_DIR/lib $BDB_LIB_DIR' >> $HOME/.secondorc
  echo '    fi' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    # java' >> $HOME/.secondorc
  echo '    export J2SDK_ROOT=/usr/lib64/jvm/java' >> $HOME/.secondorc
  echo '    export JAVAVER="1.6"' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    # prolog related' >> $HOME/.secondorc
  echo "    export SWI_HOME_DIR=/usr/lib64/swipl-$PLVER" >> $HOME/.secondorc
  SWI_HOME_DIR=/usr/lib64/swipl-$PLVER
  echo '    export PL_LIB_DIR=$SWI_HOME_DIR/lib/x86_64-linux/' >> $HOME/.secondorc
  PL_LIB_DIR=$SWI_HOME_DIR/lib/x86_64-linux/
  echo '    export PL_DLL_DIR=$PL_LIB_DIR' >> $HOME/.secondorc
  echo '    export PL_LIB=swipl' >> $HOME/.secondorc
  echo '    export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >> $HOME/.secondorc
  echo '    export PL_VERSION=70000' >> $HOME/.secondorc
  echo '    export JPL_DLL=$PL_LIB_DIR/libjpl.so' >> $HOME/.secondorc
  echo '    export JPL_JAR=$SWI_HOME_DIR/lib/jpl.jar' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    # other' >> $HOME/.secondorc
  echo '    export readline=true' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export PATH=$PATH:.' >> $HOME/.secondorc
  echo '    export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export PATH=.:$BDB_DIR/bin:$PATH' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export LD_LIBRARY_PATH=$BDB_LIB_DIR:$PL_LIB_DIR' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    # enable the pd system' >> $HOME/.secondorc
  echo '    export PATH=$PATH:$SECONDO_BUILD_DIR/Tools/pd' >> $HOME/.secondorc
  echo '    export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd_header_listing' >> $HOME/.secondorc
else
  echo 'if [ -n "$1" ]; then' >$HOME/.secondorc
  echo '  export SECONDO_BUILD_DIR=$1' >>$HOME/.secondorc
  echo 'else' >>$HOME/.secondorc
  echo '    export SECONDO_BUILD_DIR=$PWD' >>$HOME/.secondorc
  echo 'fi ' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export SECONDO_PLATFORM=linux' >>$HOME/.secondorc
  echo 'export BDB_DIR=$HOME/BDB' >>$HOME/.secondorc
  echo 'export BDB_LIB_DIR=$BDB_DIR/lib' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export BERKELEY_DB_DIR=$BDB_DIR' >>$HOME/.secondorc
  echo 'export BERKELEY_DB_LIB=db_cxx' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export J2SDK_ROOT=/usr/lib/jvm/java' >>$HOME/.secondorc
  echo "export SWI_HOME_DIR=/usr/lib/swipl-$PLVER/" >>$HOME/.secondorc
  SWI_HOME_DIR=/usr/lib/swipl-$PLVER/
  echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/i686-linux' >>$HOME/.secondorc
  PL_LIB_DIR=$SWI_HOME_DIR/lib/i686-linux
  echo 'export PL_LIB=swipl' >>$HOME/.secondorc
  echo 'export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >>$HOME/.secondorc
  echo 'export PL_VERSION=70000' >>$HOME/.secondorc
  echo 'export readline=true' >>$HOME/.secondorc
  echo 'export PATH=$PATH:.' >>$HOME/.secondorc
  echo 'export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >>$HOME/.secondorc
  echo 'export JAVAVER="1.6"' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export PATH=.:$BDB_DIR/bin:$PATH' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export LD_LIBRARY_PATH=$BDB_LIB_DIR:$PL_LIB_DIR' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo '# enable the pd system' >>$HOME/.secondorc
  echo 'export PATH=$PATH:$SECONDO_BUILD_DIR/Tools/pd' >>$HOME/.secondorc
  echo 'export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd_header_listing' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
fi

N=$(find $SWI_HOME_DIR -iname jpl.jar | wc -l)
if [ $N -eq 0 ]; then
  echo "JPL is not installed, download the sources and build jpl"
  cd $HOME
  mkdir secondo_swiinstall
  cd secondo_swiinstall
  wget http://www.swi-prolog.org/download/stable/src/swipl-$PLVER.tar.gz
  tar -xzf swipl*.tar.gz >/dev/null 2>&1
  cd swipl-$PLVER
  export PKG=jpl
  ./configure >/dev/null 2>&1
  make >/dev/null 2>&1
  cd packages/jpl
  ./configure >/dev/null 2>&1
  make >/dev/null 2>&1
  echo "   Copy created jpl files to their target positions " 
  sudo cp jpl.jar $SWI_HOME_DIR/lib/
  sudo cp jpl.pl $SWI_HOME_DIR/library/
  sudo cp libjpl.so $PL_LIB_DIR 
  cd $HOME
  unset PKG
  rm -rf secondo_swiinstall
fi	






echo "Please insert the following line into $HOME/.bashrc"
echo "source $HOME/.secondorc $HOME/secondo"
echo 
echo "Please download the latest berkeley db version without encryption (e.g. db-5.1.19.NC.tar.gz)  or with aes encryption (e.g. db-18.1.25.tar.gz"
echo "e.g. from http://www.oracle.com/technetwork/database/berkeleydb/downloads/index.html"
echo "this requires an account (free)"
echo 
echo "After that, install the berkeley db into $HOME/BDB by"
echo "Open a terminal and switch to the directory containing the file db-5.1.19.NC.tar.gz"
echo "Unpack the file by saying: tar -xzf db-5.1.19.NC.tar.gz"
echo "Go into the build directory: cd db-5.1.19.NC/build_unix"
echo 'Configure the berkeley db by typing:  ../dist/configure --prefix=$HOME/BDB --enable-cxx'
echo "Compile the berkeley db: make "
echo 'Create the target directory:  mkdir $HOME/BDB'
echo "Install berkeley db: make install"
echo
echo "Now, you can download the latest secondo version from"
echo "http://dna.fernuni-hagen.de/secondo"
echo "Unpack and compile secondo according to its user manual"
echo "Have fun"














