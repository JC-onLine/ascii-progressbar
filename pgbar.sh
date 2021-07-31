#!/usr/bin/zsh
LCD=/dev/ttyUSB0

function init() {
	echo "\xA0" > $LCD
}

function gotoxy() {
	echo "\xA1\x$1\x$2" > $LCD
}

function progressbar() {
	X_POS=$1 # param1: X display position.
	Y_POS=$2 # param2: Y display position.
	B_LEN=$3 # param3: bar length in caracters.
	VALUE=$4 # param4: Value.
	MINI=$5  # param5: Mini value.
	MAXI=$6  # param6: Maxi value.
	BAR_ON="="
	BAR_OFF="\e-"
	
	echo "init"
	# Init and position display
	init
	gotoxy $X_POS $Y_POS
	
	# Scale calcul
	RANGE=$(($MAXI - $MINI))
	SCALE=$(( B_LEN - (($B_LEN * ($MAXI - $VALUE)) / $RANGE) ))
	echo "Range:" $RANGE " Result: " $SCALE
	
	# Progressbar trace
	for (( i=1; i<=$B_LEN; i++ )); do
		# Active trace
		if [ $i -le $SCALE ]; then
			echo "$BAR_ON" > $LCD
		# Inactive trace
		else
			echo "$BAR_OFF" > $LCD
		fi
	done	
}

# Main
#	parameters order details:
#	X Y Length Value MinVal MaxVal
progressbar $1 $2 $3 $4 $5 $6
