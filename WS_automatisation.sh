#!/bin/bash
cd Documents
cd flagser-master
path=Bachelor_project
for p in 0.18301 0.26546 0.40618 0.41235 0.51608 0.65085 0.6922 0.73599 0.84198 0.88725
do
	cd Bachelor_project
	cd simulations
	cd WS
	cd WS_p_$p
	liste_simulations=`ls`
	cd --

	cd Documents
	cd flagser-master
	cd Bachelor_project
	cd results
	cd WS
	mkdir WS_p_$p
	cd --

	cd Documents
	cd flagser-master
	for sim in $liste_simulations
	do
		fullfilename=$(basename $sim)
		filename=${fullfilename%.*}
		path_out=$path/results/WS/WS_p_$p
		path_in=$path/simulations/WS/WS_p_$p
		./flagser --out  $path_out/$filename $path_in/$sim --max-dim 10

	done
done
