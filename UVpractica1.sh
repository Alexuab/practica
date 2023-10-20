#!/bin/bash
#Creem un bucle per poder executar els commandaments sense que s'acabi el programa 
while [ 1 ]
do	
	echo "Tria una opció"
	read resposta
	#Problema 1
	if [[ $resposta == "q" ]]; then
        	echo "Sortint de l'aplicació"
        	exit

	#Problema 2
	elif [[ $resposta == "lp" ]]; then
        	cut -d',' -f7,8 cities.csv | uniq



	#Problema 3
	elif [[ $resposta == "sc" ]]; then
        	echo "Nom del pais:"
        	read resposta2
		YYO=$YY
        	YY=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $7}' cities.csv | sort | uniq)
		#Comprovació del contingut de la variable
        	if [ -n "$YY" ]; then
                	echo "$YY"
		else
			#Comprovació de si s'ha introduit algun caracter
			if [[ -z "$resposta2" ]]; then
        			YY="$YYO"
			#El pais no s'ha trobat al arxiu
			else
				YY="XX"
			fi
			echo "$YY"
			
		fi
	#Problema 4
	elif [[ $resposta == "se" ]]; then
		echo "Nom del estat:"
		read resposta3
		AAO=$AA
		AA=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $4}' cities.csv | sort | uniq)
		#Comprovació del contingut de la variable
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

	#Problema 5	
	elif [[ $resposta == "le" ]]; then
		BB=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $4, $5}' cities.csv | uniq)
		#Comprovació del contingut de la variable
		if [ -n "$BB" ]; then
                        echo "$BB"
		#Comprovació del contingut de la variable "YY"
                else
                        if [[ -z "$YY" || $YY == "XX" ]]; then
				echo "Selecciona un pais amb l'acció sc"

			fi
		fi

	#Problema 6
	elif [[ $resposta == "lcp" ]]; then
                CC=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $2, $11}' cities.csv)
                if [ -n "$CC" ]; then
                        echo "$CC"
                else
                        if [[ -z "$YY" || $YY == "XX" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
			fi
		fi

	#Problema 7
	elif [[ $resposta == "ecp" ]]; then
		CC=$(awk -F',' -v pais="$resposta2" '$8 == pais {print $2, $11}' cities.csv)
                if [ -n "$CC" ]; then
                        echo "$CC" > "$YY".csv
                	cat "$YY".csv
                else
                        if [[ -z "$YY" || $YY == "XX" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
			fi
                fi
	#Problema 8
	elif [[ $resposta == "lce" ]]; then
                DD=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $2, $11}' cities.csv)
                if [[ -n "$DD" ]]; then
                        echo $DD
                else
                	if [[ -z "$YY" || $YY == "XX" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
			else
				if [[ -z "$AA" || $AA == "XX" ]]; then
                                	echo "Selecciona un estat amb l'acció se"
				fi
			fi
                
        	fi

	#Problema 9
	elif [[ $resposta == "lcee" ]]; then
                DD=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" '$8 == pais && $5 == estat {print $2, $11}' cities.csv)
                if [[ -n "$DD" ]]; then
                        echo "$DD" > "$YY"_"$AA".csv
                	cat "$YY"_"$AA".csv
                else
                        if [[ -z "$YY" || $YY == "XX" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
                        else
                                if [[ -z "$AA" || $AA == "XX" ]]; then
                                	echo "Selecciona un estat amb l'acció se"
                                fi
                        fi
                fi
	#Problema 10
	elif [[ $resposta == "gwd" ]]; then
		echo "Selecciona una població"
		read resposta4
                EE=$(awk -F',' -v pais="$resposta2" -v estat="$resposta3" -v poblacio="$resposta4" '$8 == pais && $5 == estat && $2 == poblacio {print $11}' cities.csv)
                if [[ -n "$EE" ]]; then
			echo $EE
			curl -L https://www.wikidata.org/wiki/Special:EntityData/"${EE}".json  > "${EE}".json
                else
                        if [[ -z "$YY" || $YY == "XX" ]]; then
                                echo "Selecciona un pais amb l'acció sc"
                        else
                                if [[ -z "$AA" || $AA == "XX" ]]; then
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

	#Problema 11
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

	#En cas de que s'introdueixi un commandament no establert
	else
		echo "No es una opcio valida"

	fi
#Fi del bucle
done
