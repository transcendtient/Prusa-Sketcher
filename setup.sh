#!/bin/bash

# Reset
Off='\e[0m'       # Text Reset

# Regular Colors
Green='\e[0;32m'        # Green
Red='\e[0;31m'          # Red

#Java 1.7+
#if we have java in path
if type -p java; then
  _java=java
#if we have java in java_home
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then   
  _java="$JAVA_HOME/bin/java"
fi
#if we found java check the version
if [[ "$_java" ]]; then
  version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
#if we found 1.7+ we're done
  if [[ "$version" > "1.7" ]]; then
    echo -e ${Green}"\tYour installed Java version is 1.7+. Not installing Java."${Off}
#else check the distro repo default version
  else         
    echo -e ${Red}"\tYour installed Java version is < 1.7."${Off}
    _DEF_JAVA=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $3}')
#repo sufficient then install it
    if [[ "$_DEF_JAVA" > "1.7" ]]; then
      echo -e ${Green}"\tYour default Java version is $_DEF_JAVA. Installing default."${Off}
      sudo apt-get install default-jdk
#else try to install manually
    else         
      echo -e ${Red}"\tYour default Java version is < 1.7. Trying to install manually."${Off}
      sudo apt-get install openjdk-7-jre
    fi
  fi
#else if we don't find java
else
  _DEF_JAVA=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $3}')
#repo sufficient then install it
  if [[ "$_DEF_JAVA" > "1.7" ]]; then
    echo -e ${Green}"\tYour default Java version is $_DEF_JAVA. Installing default."${Off}
    sudo apt-get install default-jdk
#else try to install manually
  else         
    echo -e ${Red}"\tYour default Java version is < 1.7. Trying to install manually."${Off}
    sudo apt-get install openjdk-7-jre
  fi
fi

#OpenSCAD
#if we have OpenSCAD in path
if type -p openscad; then
  _openscad=openscad
fi
#check in path
if [[ "$_openscad" ]]; then
  version=$("$_openscad" -version 2>&1 | awk -F ' ' '{print $3}')
#if sufficient we're done
  if [[ "$version" > "2013.06" ]]; then
    echo -e ${Green}"\tYour OpenSCAD version is 2013.06+."${Off}
#else check the distro repo default
  else         
    echo -e ${Red}"\tYour OpenSCAD version is < 2013.06."${Off}
    _DEF_OPENSCAD=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $2}')
#if sufficient install it
    if [[ "$_DEF_OPENSCAD" > "2013.06" ]]; then
      echo -e ${Green}"\tYour default OpenSCAD version is $_DEF_OPENSCAD. Installing..."${Off}
      sudo apt-get install openscad
    fi
  fi
#else OpenSCAD is not in PATH
else
  _DEF_OPENSCAD=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $2}')
#if the distro repo default is sufficient, install it
  if [[ "$_DEF_OPENSCAD" > "2013.06" ]]; then
    echo -e ${Green}"\tYour default OpenSCAD version is $_DEF_OPENSCAD. Installing..."${Off}
    sudo apt-get install openscad
#else we're BUILDING from source
  else         
    echo -e ${Red}"\tYour default OpenSCAD version is < 2013.06. \n\tCompiling from source. This will take a long time!"${Off}
#if we already have it...    
    if [ -d "./openscad/" ]; then
	  echo -e ${Green}"\tOpenSCAD directory present. Will not git."${Off}
	else
      sudo apt-get install git
      git clone git://github.com/openscad/openscad.git
    fi
    cd openscad
    git submodule update --init
    echo -e ${Green}"Getting dependencies."${Off}
    sudo ./scripts/uni-get-dependencies.sh
#parse fields from the check dependencies script
    ./scripts/check-dependencies.sh
    OKNESS=$(./scripts/check-dependencies.sh 2>&1 |sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | awk -F ' ' '{print $4}')
    isOK=(${OKNESS// [40 32m/ })
    DEPNAME=$(./scripts/check-dependencies.sh 2>&1 |sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | awk -F ' ' '{print $1}')
    nameDep=(${DEPNAME// [40 32m/ })
#if NotOK, build one at a time
    for (( i=1; i <= ${#isOK[@]}; i++ )); do
      if [[ ${isOK[i]}  == "NotOK" ]]; then
        echo -e ${Red}"OpenSCAD dependencies not satisfied by script. \nBuilding ${nameDep[$i]} from source. This will take a long time!"${Off}
        source ./scripts/setenv-unibuild.sh
        ./scripts/uni-build-dependencies.sh {nameDep[$i]}
        sleep 10
      fi
    done
#parse fields again
    ./scripts/check-dependencies.shY
    OKNESS=$(./scripts/check-dependencies.sh 2>&1 |sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | awk -F ' ' '{print $4}')
    isOK=(${OKNESS// [40 32m/ })
    DEPNAME=$(./scripts/check-dependencies.sh 2>&1 |sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | awk -F ' ' '{print $1}')
    nameDep=(${DEPNAME// [40 32m/ })
    for (( i=1; i <= ${#isOK[@]}; i++ )); do
#if the script fails, quit
      if [[ ${isOK[i]}  == "NotOK" ]]; then
        echo -e ${Red}"OpenSCAD dependencies unable to be satisfied by script. \nABORTING!!"${Off}
        exit
      fi
      echo -e ${Red}"Making! This will take a long time!"${Off}
      qmake
      make
      make install
      rm -rf $HOME/openscad_deps
    done
  fi
  cd ..
fi

#KISSlicer get kernel type
_DEF_KERNEL=$(uname -m)
if [[ "$_DEF_KERNEL" == "x86_64" ]]; then
    echo -e ${Green}"\tUnzipping x64 KISSlicer."${Off}
    unzip ./Dependencies/KISSlicer_Linux64_1_1_0.zip -d ./kiss/
elif [[ "$_DEF_KERNEL" == "i686" ]]; then
    echo -e ${Green}"\tUnzipping i686 KISSlicer."${Off}
    unzip ./Dependencies/KISSlicer_Linux32_1_1_0.zip -d ./kiss/
else         
    echo -e ${Red}"\tYour kernel is unidentified. \n\tPlease take a look at the KISSlicer downloads section."${Off}
    if which xdg-open > /dev/null; then
      xdg-open http://www.kisslicer.com/download.html 2>/dev/null
    elif which gnome-open > /dev/null; then
      gnome-open http://www.kisslicer.com/download.html 2>/dev/null
    fi
fi

echo -e ${Green}"\tInstalling Printrun dependencies."${Off}
sudo apt-get install python-serial python-wxgtk2.8 python-pyglet python-tornado python-setuptools python-libxml2 python-gobject avahi-daemon libavahi-compat-libdnssd1 python-dbus python-psutil git
if [ -d "./Printrun/" ]; then
	  echo -e ${Green}"\tPrintrun directory present. Will not git."${Off}
else
git clone https://github.com/kliment/Printrun.git
fi

echo -e ${Green}"\tInstalling core dependencies."${Off}
sudo apt-get install gimp imagemagick pstoedit librxtx-java potrace

echo -e ${Green}"\tCompiling java programs."${Off}
javac -classpath .:/usr/share/java/RXTXcomm.jar ./core/java/*.java

#copy GIMP sccript
if [ -d "/usr/share/gimp/2.0/scripts/" ]; then
  echo -e ${Green}"\tCopying GIMP script! It's over!"${Off}
  sudo cp ./Dependencies/do-pencil-drawing.scm /usr/share/gimp/2.0/scripts/
  sudo chmod +x /usr/share/gimp/2.0/scripts/do-pencil-drawing.scm
else echo ${Red}"\tThe GIMP plugin directory was not found! Copy ./Dependencies/do-pencil-drawing.scm to your plugin directory to finish installation!"${Off}
fi
