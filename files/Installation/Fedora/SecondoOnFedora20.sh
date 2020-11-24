

# install required packages

sudo yum -y install make 
sudo yum -y install flex-devel 
sudo yum -y install bison-devel 
sudo yum -y install gsl-devel 
sudo yum -y install readline-devel 
sudo yum -y install gmp-devel 
sudo yum -y install gcc 
sudo yum -y install gcc-c++ 
sudo yum -y install recode-devel 
sudo yum -y install libxml2-devel 
sudo yum -y install pl-devel
sudo yum -y install wget 
sudo yum -y install libdb-cxx-devel 
sudo yum -y install java-1.7.0-openjdk-devel 
sudo yum -y install flex 
sudo yum -y install bison 
sudo yum -y install pl
sudo yum -y install graphviz-devel
sudo yum -y install awk


# install libjpeg62 manually (not longer supported by Fedora as a package)

mkdir temp
cd temp
wget dna.fernuni-hagen.de/secondo/files/libs/jpegsrc.v6b.tar.gz
tar -xzf jpegsrc.v6b.tar.gz
cd jpeg-6b
./configure
make all
sudo make install
sudo make install-lib

platform=$(uname -i)

PLVER=$(swipl --version| awk {'print $3'})

IS64=FALSE
if [ $platform == "x86_64" ]; then
IS64=TRUE
fi

if [ $platform == "ppc64" ]; then
IS64=TRUE
fi



echo "Create file $HOME/.secondorc"
if [ $IS64 == "TRUE" ]; then
  echo '   if [ -n "$1" ]; then' > $HOME/.secondorc
  echo '      export SECONDO_BUILD_DIR=$1' >> $HOME/.secondorc
  echo '   else' >> $HOME/.secondorc
  echo '     export SECONDO_BUILD_DIR=$PWD' >> $HOME/.secondorc
  echo '    fi' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export SECONDO_PLATFORM=linux64' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    export BERKELEY_DB_LIB=db_cxx' >> $HOME/.secondorc
  echo '    # java' >> $HOME/.secondorc
  echo '    export J2SDK_ROOT=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0*/' >> $HOME/.secondorc
  echo '    export JAVAVER="1.7"' >> $HOME/.secondorc
  echo '' >> $HOME/.secondorc
  echo '    # prolog related' >> $HOME/.secondorc
  echo "    export SWI_HOME_DIR=/usr/lib64/swipl-$PLVER" >> $HOME/.secondorc
  echo '    export PL_LIB_DIR=$SWI_HOME_DIR/lib/x86_64-linux/' >> $HOME/.secondorc
  echo '    export PL_DLL_DIR=$PL_LIB_DIR' >> $HOME/.secondorc
  echo '    export PL_LIB=swipl' >> $HOME/.secondorc
  echo '    export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >> $HOME/.secondorc
  echo '    export PL_VERSION=51000' >> $HOME/.secondorc
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
  echo '' >> $HOME/.secondorc
  echo '    export LD_LIBRARY_PATH=$BDB_LIB_DIR:$PL_LIB_DIR' >> $HOME/.secondorc
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
    echo 'export BERKELEY_DB_LIB=db_cxx' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export J2SDK_ROOT=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0*/' >>$HOME/.secondorc
  echo "export SWI_HOME_DIR=/usr/lib/swipl-$PLVER/" >>$HOME/.secondorc
  echo 'export PL_LIB_DIR=$SWI_HOME_DIR/lib/i686-linux' >>$HOME/.secondorc
  echo 'export PL_LIB=swipl' >>$HOME/.secondorc
  echo 'export PL_INCLUDE_DIR=$SWI_HOME_DIR/include' >>$HOME/.secondorc
  echo 'export PL_VERSION=50647' >>$HOME/.secondorc
  echo 'export readline=true' >>$HOME/.secondorc
  echo 'export PATH=$PATH:.' >>$HOME/.secondorc
  echo 'export SECONDO_CONFIG=$SECONDO_BUILD_DIR/bin/SecondoConfig.ini' >>$HOME/.secondorc
  echo 'export JAVAVER="1.7"' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo 'export LD_LIBRARY_PATH=$BDB_LIB_DIR:$PL_LIB_DIR' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
  echo '# enable the pd system' >>$HOME/.secondorc
  echo 'export PATH=$PATH:$SECONDO_BUILD_DIR/Tools/pd' >>$HOME/.secondorc
  echo 'export PD_HEADER=$SECONDO_BUILD_DIR/Tools/pd/pd_header_listing' >>$HOME/.secondorc
  echo '' >>$HOME/.secondorc
fi
