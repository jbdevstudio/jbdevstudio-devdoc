#!/bin/bash

eclipse=~/eclipse/34clean/eclipse-platform-3.4.2-linux-gtk.tar.gz

# uncomment this to install JBoss Tools from zip instead of via update site, or any other reqs
#extras=~/eclipse/34clean/JBossTools-ALL-linux-gtk-3.0.1.GA-R200905070146-H18.zip

workspace=/tmp/eclipse/workspace-clean-jbt
target=/tmp/eclipse/34clean
mkdir -p $target/logs

datetime="$(date +%Y%m%d-%H%M)"
log="$target/logs/eclipse.log.${datetime}.txt"

echo "================================================================================" >> $log
echo "Test script: " >> $log
echo "" >> $log
cat $0 | egrep -v ">> \$log" >> $log
echo "================================================================================" >> $log

cd $target

if [[ $1 ]]; then
  echo "$1" | tee -a $log # label this run (ie., purpose of test)
  echo "Wipe $target/eclipse and $workspace ..." | tee -a $log
  rm -fr $target/eclipse $workspace
  if [[ ! -f $eclipse ]]; then
  	echo "$eclipse not found in $target. Download it first or set absolute path to file." | tee -a $log
  	exit 1;
  fi 
  echo "Unpack $eclipse ..." | tee -a $log
  tar xzf $eclipse
  if [[ $extras ]]; then
    for f in $extras; do
      if [[ ! -f $f ]]; then
      	echo "$f not found in $target. Skip." | tee -a $log
      fi 
      echo "Unpack $f ..." | tee -a $log
      unzip -qq $f -d $target/eclipse/dropins/
    done
  fi
fi

./eclipse/eclipse -clean -showLocation -data $workspace -consolelog -console \
  -vmargs -Xms128M -Xmx256M -XX:PermSize=128M -XX:MaxPermSize=256M 2>&1 | tee -a $log
