#!/usr/bin/bash

function bar() {
	# param1: X display position.
	# param2: Y display position.
	# param3: bar lengt in caracters.
	# param4: Value in %.
	BAR_ON="="
	BAR_OFF="-"
	SCALE=$((($3 * $4) / 100))
	echo "Result: " $SCALE
	for (( i=1; i<=$3; i++ )); do
		if [ $i -le $SCALE ]; then
			echo -ne "$BAR_ON"
		else
			echo -ne "$BAR_OFF"
		fi
	done	
	echo ""
}

#main
bar $1 $2 $3 $4

