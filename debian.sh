#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=silead
SOURCEDOC=README.md
DEBFOLDER=gslx68x
DEBVERSION=$(date +%Y%m%d)
CONTROL_FILE="Source: gslx68x
Section: admin
Priority: optional
Maintainer: Hans De Goede <jwrdegoede@fedoraproject.org>
Build-Depends: debhelper (>= 9)
Standards-Version: 3.9.5
Homepage: https://github.com/jwrdegoede/gslX68X
Vcs-Git: git@github.com:jwrdegoede/gslX68X
Vcs-Browser: https://github.com/jwrdegoede/gslX68X

Package: gslx68x
Architecture: all
Depends: \${misc:Depends}
Description: A kernel-space driver for the silead touch screen
 controllers. Requires a firmware file.
 .
 "
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir

# Copy your script to the source dir
cp $SOURCEBINPATH/ $DEBFOLDERNAME -r
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make --kmod --createorig
echo "$CONTROL_FILE" > debian/control

# Remove make calls
#grep -v makefile debian/rules > debian/rules.new
#mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
#echo $DEBFOLDER usr/bin > debian/install
#echo $SOURCEDOC usr/share/doc/apt-git >> debian/install

# Remove the example files
rm debian/*.ex

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log
