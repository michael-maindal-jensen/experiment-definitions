#!/bin/bash

expfolder=$1
runframeworkfolder=$2
runcommand=$3 ; shift ; shift ; shift
prefixes=("$@")


echo expfolder = $expfolder
echo runframeworkfolder = $runframeworkfolder
echo runcommand = $runcommand

i=0
for prefix in "${prefixes[@]}"
do
	let i++
	echo $i : Dataset from phase 1 experiment prefix = $prefix

	cd $expfolder

	# replace prefix in experiments.json
	sed_string="sed -i.bak 's/PASTASAUCE/${prefix}/g' experiments-phase2.json"
	eval $sed_string

	# replace prefix in data.json
	sed_string="sed -i.bak 's/PASTASAUCE/${prefix}/g' ./input/data-phase2.json"
	eval $sed_string

	cd $runframeworkfolder

	# execute command
	cmd=`eval echo $runcommand`			# expand prefix variable before executing
	eval $cmd

	status=$?

	cd $expfolder

	# restore the modified files
	cp experiments-phase2.json.bak experiments-phase2.json
	cp ./input/data-phase2.json.bak ./input/data-phase2.json

	if [ $status -ne 0 ]; then
		echo "ERROR: run-framework exited with error status: $status"
		exit $status
	fi

done
