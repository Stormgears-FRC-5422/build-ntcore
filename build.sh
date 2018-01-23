#!/bin/bash

PKG=ntcore
PKGVER=3.1.7
PKGVERSUB=1
PKGREL=1
GITURL=https://github.com/wpilibsuite/ntcore

WD=$(dirname $0)
[ "$WD" == "." ] && WD=$PWD

. /etc/os-release
dist=$ID$VERSION_ID
codename=$VERSION_CODENAME
[ -z "$codename" ] && codename=$(echo $VERSION | sed 's/.*(\(.*\)).*/\1/')

gitname=$(git config --get user.name)
gitemail=$(git config --get user.email)
gitdate=$(date -R)

rm -rf $WD/work
mkdir $WD/work
cd $WD/work
git clone $GITURL
cd $PKG
git checkout v$PKGVER
cp -r $WD/deb debian
cat > debian/changelog <<EOF
$PKG (${PKGVER}.${PKGVERSUB}-${PKGREL}.$dist) $codename; urgency=low

  * Automatically generated

 -- ${gitname} <${gitemail}>  ${gitdate}
EOF
cd $WD/work
mv $PKG ${PKG}-${PKGVER}.${PKGVERSUB}
tar czf ${PKG}_${PKGVER}.${PKGVERSUB}.orig.tar.gz ${PKG}-${PKGVER}.${PKGVERSUB}

cat <<EOF
Source files are prepared. You have two options:
(1) Build deb package:
  cd $WD/work/${PKG}-${PKGVER}.${PKGVERSUB} && dpkg-buildpackage -us -uc -b
(2) Prepare upload for PPA:
  cd $WD/work/${PKG}-${PKGVER}.${PKGVERSUB} && dpkg-buildpackage -S
EOF

cd $WD
 
