versionWithRespin_jbt_PREV=4.21.0.Final
versionWithRespin_jbt=4.21.2.Final
versionWithRespin_ds_PREV=12.21.0.GA
versionWithRespin_ds=12.21.2.GA

for i in base build build-sites central discovery forge fuse hibernate javaee jst livereload openshift quarkus server vpe webservices
do
	git clone git@github.com:jbosstools/jbosstools-$i -b jbosstools-${versionWithRespin_jbt_PREV}
	cd jbosstools-$i
	git checkout -b ${versionWithRespin_jbt}
	git push origin ${versionWithRespin_jbt}:${versionWithRespin_jbt}
	cd ..
done
#seems fuse-extras is not tagged so we use master
git clone git@github.com:jbosstools/jbosstools-fuse-extras -b master
cd jbosstools-fuse-extras
git checkout -b ${versionWithRespin_jbt}
git push origin ${versionWithRespin_jbt}:${versionWithRespin_jbt}
cd ..
#integration-tests is not tagged so we use master
git clone git@github.com:jbosstools/jbosstools-integration-tests -b master
cd jbosstools-integration-tests
git checkout -b ${versionWithRespin_jbt}
git push origin ${versionWithRespin_jbt}:${versionWithRespin_jbt}
cd ..
git clone git@github.com:jbdevstudio/jbdevstudio-product -b jbdevstudio-${versionWithRespin_ds_PREV}
cd jbdevstudio-product
git checkout -b ${versionWithRespin_jbt}
git push origin ${versionWithRespin_jbt}:${versionWithRespin_jbt}
cd ..
