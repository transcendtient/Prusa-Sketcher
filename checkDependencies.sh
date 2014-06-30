#!/bin/bash
# Reset
Off='\e[0m'       # Text Reset

# Regular Colors
Green='\e[0;32m'        # Green
Red='\e[0;31m'          # Red

##Let user know if they have the minmum requirements
#Java 1.7+
if type -p java; then
    echo Found Java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found Java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "no java"
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "Version $version"
    if [[ "$version" > "1.7" ]]; then
        echo -e ${Green}"\tYour Java version is 1.7+."${Off}
    else         
        echo -e ${Red}"\tYour Java version is < 1.7."${Off}
    fi
fi

#OpenSCAD
if type -p openscad; then
    echo Found OpenSCAD executable in PATH
    _openscad=openscad
else
    echo "no OpenSCAD"
fi

if [[ "$_openscad" ]]; then
    version=$("$_openscad" -version 2>&1 | awk -F ' ' '{print $3}')
    echo "Version $version"
    if [[ "$version" > "2013.06" ]]; then
        echo -e ${Green}"\tYour OpenSCAD version is 2013.06+."${Off}
    else         
        echo -e ${Red}"\tYour OpenSCAD version is < 2013.06."${Off}
    fi
fi

#librxtx
_librxtx="dpkg -s librxtx-java | grep Version"

if [[ "$_librxtx" ]]; then
    echo librxtx-java is installed.
    version=$(dpkg -s librxtx-java | grep Version 2>&1 | awk -F ' ' '/Version/ {print $2}')
    echo "Version $version"
    if [[ "$version" > "2.2pre2" ]]; then
        echo -e ${Green}"\tYour librxtx-java version is 2.2pre2+."${Off}
    else         
        echo -e ${Red}"\tYour default librxtx-java version is < 2.2pre2. You\'ll have to manually install it."${Off}
    fi
fi

if type -p gimp; then
    echo -e ${Green}"\tGIMP is installed."${Off}
else
    echo -e ${Red}"\tGIMP is not installed."${Off}
fi

if type -p convert; then
    echo -e ${Green}"\tImageMagick is installed."${Off}
else
    echo -e ${Red}"\tImageMagick is not installed."${Off}
fi

if type -p pstoedit; then
    echo -e ${Green}"\tpstoedit is installed."${Off}
else
    echo -e ${Red}"\tpstoedit is not installed."${Off}
fi
