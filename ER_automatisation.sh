#!/bin/bash
cd Documents
cd flagser-master
path=Bachelor_project
for p in 0.18601
do
	cd Bachelor_project
	cd simulations
	cd ER
	cd ER_p_$p
	liste_simulations=`ls`
	cd --

	cd Documents
	cd flagser-master
	cd Bachelor_project
	cd results
	cd ER
	mkdir ER_p_$p
	cd --

	cd Documents
	cd flagser-master
	for sim in $liste_simulations
	do
		fullfilename=$(basename $sim)
		filename=${fullfilename%.*}
		path_out=$path/results/ER/ER_p_$p
		path_in=$path/simulations/ER/ER_p_$p
		./flagser --out  $path_out/$filename $path_in/$sim --max-dim 10

	done
done
