#!/bin/bash

while [ 1 ]
do	
	echo "Tria una opció"
	read resposta

	if [[ $resposta == "q" ]]; then
        	echo "Sortint de l'aplicació"
        	exit
	elif [[ $resposta == "lp" ]]; then
        	cut -d',' -f7,8 cities.csv | uniq

	elif [[ $resposta == "sc" ]]; then
        	echo "Nom del pais:"
        	read resposta2
        	YY=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $7}' cities.csv | sort | uniq)
        	if [ -n "$YY" ]; then
                	echo "$YY"
        	else
                	YY="XX"
			echo "$YY"
		fi

	elif [[ $resposta == "XX" ]]; then
		echo "$YY"

	elif [[ $resposta == "se" ]]; then
		echo "Nom del estat:"
		read resposta3
		AA=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $4}' cities.csv | sort | uniq)
		if [ -n "$AA" ]; then
			echo "$AA"
		else
			AA="XX"
			echo "$AA"	
		fi
	elif [[ $resposta == "le" ]]; then
		BB=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $4, $5}' cities.csv)
		if [ -n "$BB" ]; then
                        echo "$BB"
                else
                        BB="XX"
                        echo "$BB"
		fi
	elif [[ $resposta == "lcp" ]]; then
                CC=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $2, $11}' cities.csv)
                if [ -n "$CC" ]; then
                        echo "$CC"
                else
                        CC="XX"
                        echo "$CC"
		fi
	elif [[ $resposta == "ecp" ]]; then
		echo "$CC" > "$YY".csv
		cat "$YY".csv

	elif [[ $resposta == "lce" ]]; then
                DD=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $2, $11}' cities.csv)
                if [[ -n "$DD" ]]; then
                        echo $DD
                else
                        DD="XX"
                        echo $DD
        	fi
	elif [[ $resposta == "lcee" ]]; then
                echo "$DD" > "$YY"_"$AA".csv
                cat "$YY"_"$AA".csv
	
	elif [[ $resposta == "gwd" ]]; then
		echo "Selecciona una població"
		read resposta4
                EE=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" -v poblacio="$resposta4" '$8 == pais && $5 == estat && $2 == poblacio {print $11}' cities.csv)
                if [[ -n "$EE" ]]; then
			echo $EE
			curl -L https://www.wikidata.org/wiki/Special:EntityData/"${EE}".json  > "${EE}".json
                else
                        EE="XX"
                        echo $EE
                fi


	elif [[ $resposta == "est" ]]; then

		HN=$(awk -F, '$9 > 0 {c1++} END {print c1}' cities.csv)
		HS=$(awk -F, '$9 < 0 {c2++} END {print c2}' cities.csv)
		HE=$(awk -F, '$10 > 0 {c3++} END {print c3}' cities.csv)
		HO=$(awk -F, '$10 < 0 {c4++} END {print c4}' cities.csv)
		SU=$(awk -F, '$9 == 0 && $10 == 0 {c5++} END {print c5}' cities.csv)
		SW=$(awk -F, '$11 == "" {c6++} END {print c6}' cities.csv)
		echo "Nord $HN Sud $HS Est $HE Oest $HO No ubic $SU No WDId $SW "


	else
		echo "No es una opcio valida"

	fi




done
