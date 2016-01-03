#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then echo "version is unset"; exit 1; fi

RELEASES="trusty vivid wily xenial"

PKGNAME=githubissueinfo
PKGVER=$1
TMP=$(mktemp -d)
CURRENT=$(pwd)

for release in ${RELEASES}; do
	echo ""
	echo "${PKGNAME} ${PKGVER} ${release}"
	echo ""
	DST=${TMP}/${PKGNAME}-${PKGVER}~${release}/
	mkdir ${DST}
	cp -aR ${CURRENT}/* ${DST}
	cd ${DST}

	#debian: changelog
	sed -e "s/githubissueinfo (.*)/githubissueinfo (${PKGVER}~${release})/g" -e "s/unstable;/${release};/g" -i debian/changelog

	debuild -i -S
done

cp ${TMP}/*.build ${TMP}/*.changes ${TMP}/*.dsc ${TMP}/*.tar.gz ${CURRENT}
rm -rf ${TMP}

