#!/bin/sh 
while
    echo "vol:$(pamixer --get-volume-human)" \
         "|" \
         "$(date +'%Y-%m-%d %H:%M:%S')" \
	 "|" \
	 "$(acpi | grep -v "rate information unavailable" | awk -F '[,:]+' '{print "Battery:" $3 "," $2}')";
    do sleep 1;
done;
