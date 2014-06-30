#!/bin/bash

# Reset
Off='\e[0m'       # Text Reset

# Regular Colors
Green='\e[0;32m'        # Green
Red='\e[0;31m'          # Red

sudo apt-get install gimp imagemagick pstoedit librxtx-java

#Java 1.7+
if type -p java; then
  _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then   
  _java="$JAVA_HOME/bin/java"
fi

if [[ "$_java" ]]; then
  version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
  if [[ "$version" > "1.7" ]]; then
    echo -e ${Green}"\tYour installed Java version is 1.7+. Not installing Java."${Off}
  else         
    echo -e ${Red}"\tYour installed Java version is < 1.7."${Off}

    _DEF_JAVA=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $3}')
    if [[ "$_DEF_JAVA" > "1.7" ]]; then
      echo -e ${Green}"\tYour default Java version is $_DEF_JAVA. Installing default."${Off}
      sudo apt-get install default-jdk
    else         
      echo -e ${Red}"\tYour default Java version is < 1.7. Trying to install manually."${Off}
      sudo apt-get install openjdk-7-jre
    fi
  fi
else
  _DEF_JAVA=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $3}')
  if [[ "$_DEF_JAVA" > "1.7" ]]; then
    echo -e ${Green}"\tYour default Java version is $_DEF_JAVA. Installing default."${Off}
    sudo apt-get install default-jdk
  else         
    echo -e ${Red}"\tYour default Java version is < 1.7. Trying to install manually."${Off}
    sudo apt-get install openjdk-7-jre
  fi
fi

#OpenSCAD
if type -p openscad; then
  _openscad=openscad
fi

if [[ "$_openscad" ]]; then
  version=$("$_openscad" -version 2>&1 | awk -F ' ' '{print $3}')
  if [[ "$version" > "2013.06" ]]; then
      echo -e ${Green}"\tYour OpenSCAD version is 2013.06+."${Off}
  else         
    echo -e ${Red}"\tYour OpenSCAD version is < 2013.06."${Off}
    _DEF_OPENSCAD=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $2}')
    if [[ "$_DEF_OPENSCAD" > "2013.06" ]]; then
      echo -e ${Green}"\tYour default OpenSCAD version is $_DEF_OPENSCAD. Installing..."${Off}
      sudo apt-get install openscad
    else         
      echo -e ${Red}"\tYour default OpenSCAD version is < 2013.06. \n\tPlease take a look at the OpenSCAD downloads section."${Off}
      if which xdg-open > /dev/null; then
        xdg-open http://www.openscad.org/downloads.html 2>/dev/null
      elif which gnome-open > /dev/null; then
        gnome-open http://www.openscad.org/downloads.html 2>/dev/null
      fi
    fi
  fi
else
  _DEF_OPENSCAD=$(apt-cache policy default-jdk 2>&1 | grep Candidate | awk -F ':' '{print $2}')
  if [[ "$_DEF_OPENSCAD" > "2013.06" ]]; then
    echo -e ${Green}"\tYour default OpenSCAD version is $_DEF_OPENSCAD. Installing..."${Off}
    sudo apt-get install openscad
  else         
    echo -e ${Red}"\tYour default OpenSCAD version is < 2013.06. \n\tCompiling from source. This will take a long time.!"${Off}
#    if which xdg-open > /dev/null; then
#      xdg-open http://www.openscad.org/downloads.html 2>/dev/null
#    elif which gnome-open > /dev/null; then
#      gnome-open http://www.openscad.org/downloads.html 2>/dev/null
#    fi
    git clone git://github.com/openscad/openscad.git
    cd openscad
    git submodule update --init
    sudo ./scripts/uni-get-dependencies.sh
    NOTOK=$(./scripts/check-dependencies.sh 2>&1 | awk -F ' ' '{print $4}')
    NOTOK=`expr "$NOTOK" : '\(.*NotOK\)'`
    if [[ "$NOTOK" ]]; then
      echo -e ${Red}"OpenSCAD dependencies not satisfied by script. \nBuilding from source. This will take a long time!"${Off}
      source ./scripts/setenv-unibuild.sh
      ./scripts/uni-build-dependencies.sh
      NOTOK=$(./scripts/check-dependencies.sh 2>&1 | awk -F ' ' '{print $4}')
      NOTOK=`expr "$NOTOK" : '\(.*NotOK\)'`
      if [[ "$NOTOK" ]]; then
        echo -e ${Red}"OpenSCAD dependencies unable to be satisfied. Aborting!!\n Please visit http://www.openscad.org/downloads.html."${Off}
        exit
      else
        qmake
        make
        make install
      fi
    else
      qmake
      make
      make install
    fi
  fi
fi

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

echo "Installing Printrun dependencies."
sudo apt-get install python-serial python-wxgtk2.8 python-pyglet python-tornado python-setuptools python-libxml2 python-gobject avahi-daemon libavahi-compat-libdnssd1 python-dbus python-psutil git
git clone https://github.com/kliment/Printrun.git

sudo apt-get install gimp imagemagick pstoedit librxtx-java

echo "Compiling java programs."
javac -classpath .:/usr/share/java/RXTXcomm.jar ./core/java/*.*
