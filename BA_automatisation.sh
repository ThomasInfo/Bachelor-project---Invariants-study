#!/bin/bash
cd Documents
cd flagser-master
path=Bachelor_project
for p in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1
do
	cd Bachelor_project
	cd simulations
	cd BA
	cd BA_p_$p
	liste_simulations=`ls`
	cd --

	cd Documents
	cd flagser-master
	cd Bachelor_project
	cd results
	cd BA
	mkdir BA_p_$p
	cd --

	cd Documents
	cd flagser-master
	for sim in $liste_simulations
	do
		fullfilename=$(basename $sim)
		filename=${fullfilename%.*}
		path_out=$path/results/BA/BA_p_$p
		path_in=$path/simulations/BA/BA_p_$p
		./flagser --out  $path_out/$filename $path_in/$sim --max-dim 10

	done
done
