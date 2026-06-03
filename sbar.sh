#!/bin/sh 
while
    echo "vol:$(pamixer --get-volume-human)" \
         "|" \
         "$(date +'%Y-%m-%d %H:%M:%S')" \
	 "|" \
	 "$(acpi | head -1 | awk -F '[,:]+' '{print "Battery:" $3 "," $2}')";
    do sleep 1;
done;
