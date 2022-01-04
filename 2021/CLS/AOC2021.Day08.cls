Class AOC2021.Day08 Extends AOC2021.Base
{

Parameter InputFile = "d08.txt";

// d ##class(AOC2021.Day08).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	set Counter=0
	while 'stream.AtEnd {
		set record=stream.ReadLine()
		set Data=$zstrip($piece(record,"|",2),"<>W")
		for PC=1:1:$length(Data," ") {
			set LEN=$length($piece(Data," ",PC))
			if (LEN=2)||(LEN=3)||(LEN=4)||(LEN=7) {
				set Counter=Counter+1
			}
		}
		if verbose write !,Counter
	}
	set Answer=Counter

	quit Answer
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	set Total=0
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		kill Digits,Chars
		set Data=$zstrip($piece(Record,"|",1),"<>W")
		for PC=1:1:$length(Data," ") {
			set Letters=$piece(Data," ",PC)
			set LEN=$length(Letters)
			if (LEN=2)||(LEN=3)||(LEN=4)||(LEN=7) {
				if LEN=2 set Digits(1)=Letters
				if LEN=3 set Digits(7)=Letters
				if LEN=4 set Digits(4)=Letters
				if LEN=7 set Digits(8)=Letters
			}
			for loc=1:1:LEN {
				set Letter=$extract(Letters,loc)
				set Chars(Letter)=$get(Chars(Letter))+1
			}
		}
		//zw Digits,Chars
		set Char=""
		for {
			set Char=$order(Chars(Char)) quit:Char=""
			//if Chars(Char)=9 set bottomRight=Char
			if Chars(Char)=4 set bottomLeft=Char
			if Chars(Char)=6 set topLeft=Char
		}
		//zw bottomRight,bottomLeft,topLeft
		for PC=1:1:$length(Data," ") {
			set Letters=$piece(Data," ",PC)
			set LEN=$length(Letters)
			if LEN=5,Letters[topLeft set Digits(5)=Letters
			if LEN=5,Letters[bottomLeft set Digits(2)=Letters
			if LEN=5,Letters'[topLeft,Letters'[bottomLeft set Digits(3)=Letters
			if LEN=6,Letters'[bottomLeft set Digits(9)=Letters
		}
		set Letters6=Digits(5)_bottomLeft
		for PC=1:1:$length(Data," ") {
			set Letters=$piece(Data," ",PC)
			set LEN=$length(Letters)
			if LEN=6 {
				continue:Digits(9)=Letters
				continue:$get(Digits(0))=Letters
				continue:$get(Digits(6))=Letters
				if '$length($translate(Letters,Letters6)) {
					set Digits(6)=Letters
				}
				else {
					set Digits(0)=Letters
				}
			}
		}
		for i=0:1:9 {
			set Letters=Digits(i)
			set LEN=$length(Letters)
			set arr(LEN,i)=Letters
		}
		if verbose write !!,Data,! zwrite arr
		set Data=$zstrip($piece(Record,"|",2),"<>W"),Number=""
		for PC=1:1:$length(Data," ") {
			set Letters=$piece(Data," ",PC)
			set Len=$length(Letters)
			s Digit=""
			for  {
				set Digit=$order(arr(Len,Digit)) quit:Digit=""
				if '$length($tr(Letters,arr(Len,Digit))) {
					set Number=Number_Digit
					quit
				}
			}
		}
		set Total=Total+Number
		if verbose zwrite Digits write !,Number
	}
	set Answer=Total

	quit Answer
}

}

