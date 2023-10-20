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
		YYO=$YY
        	YY=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $7}' cities.csv | sort | uniq)
        	if [ -n "$YY" ]; then
                	echo "$YY"
		else
			if [[ -z "$resposta2" ]]; then
        			YY="$YYO"
			else
				YY="XX"
			fi
			echo "$YY"
			
		fi

	elif [[ $resposta == "se" ]]; then
		echo "Nom del estat:"
		read resposta3
		AAO=$AA
		AA=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $4}' cities.csv | sort | uniq)
		if [ -n "$AA" ]; then
			echo "$AA"
		else
                	if [[ -z "$resposta3" ]]; then
                        	AA="$AAO"
			else
				AA="XX"
                        fi
                        echo "$AA"	
		fi


	elif [[ $resposta == "le" ]]; then
		BB=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $4, $5}' cities.csv | uniq)
		if [ -n "$BB" ]; then
                        echo "$BB"
                else
                        if [[ -z "$resposta2" ]]; then
				echo "Selecciona un pais amb l'acció sc"

			fi
		fi


	elif [[ $resposta == "lcp" ]]; then
                CC=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $2, $11}' cities.csv)
                if [ -n "$CC" ]; then
                        echo "$CC"
                else
                        if [[ -z "$resposta2" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
			fi
		fi


	elif [[ $resposta == "ecp" ]]; then
		CC=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $2, $11}' cities.csv)
                if [ -n "$CC" ]; then
                        echo "$CC" > "$YY".csv
                	cat "$YY".csv
                else
                        if [[ -z "$resposta2" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
			fi
                fi

	elif [[ $resposta == "lce" ]]; then
                DD=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $2, $11}' cities.csv)
                if [[ -n "$DD" ]]; then
                        echo $DD
                else
                	if [[ -z "$resposta2" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
			else
				if [[ -z "$resposta3" ]]; then
                                	echo "Selecciona un estat amb l'acció se"
				fi
			fi
                
        	fi


	elif [[ $resposta == "lcee" ]]; then
                DD=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $2, $11}' cities.csv)
                if [[ -n "$DD" ]]; then
                        echo "$DD" > "$YY"_"$AA".csv
                	cat "$YY"_"$AA".csv
                else
                        if [[ -z "$resposta2" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
                        else
                                if [[ -z "$resposta3" ]]; then
                                	echo "Selecciona un estat amb l'acció se"
                                fi
                        fi
                fi
	
	elif [[ $resposta == "gwd" ]]; then
		echo "Selecciona una població"
		read resposta4
                EE=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" -v poblacio="$resposta4" '$8 == pais && $5 == estat && $2 == poblacio {print $11}' cities.csv)
                if [[ -n "$EE" ]]; then
			echo $EE
			curl -L https://www.wikidata.org/wiki/Special:EntityData/"${EE}".json  > "${EE}".json
                else
                        if [[ -z "$resposta2" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
                        else
                                if [[ -z "$resposta3" ]]; then
                                	echo "Selecciona un estat amb l'acció se"
				else
					if [[ -z "$resposta4" ]]; then
                                		echo "Introdueix un estat amb gwd"
					else
						echo "L'estat introduit no s'ha trobat al document" 
                        		fi
                                fi
                        fi
                fi


	elif [[ $resposta == "est" ]]; then
		c1=0
		c2=0
		c3=0
		c4=0
		c5=0
		c6=0
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
