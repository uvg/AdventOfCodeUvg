Class AOC2021.Day07 Extends AOC2021.Base
{

Parameter InputFile = "d07.txt";

// d ##class(AOC2021.Day07).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Record=recordsArr(1)
	for PC=1:1:$length(Record,",") if $increment(CrabsPos($piece(Record,",",PC)))
	set POS1="",MinMove=99999999999999
	for  {
		set POS1=$order(CrabsPos(POS1)) quit:POS1=""
		set Total=0
		set POS2=""
		for  {
			set POS2=$order(CrabsPos(POS2)) quit:POS2=""
			continue:POS2=POS1
			set Total=$zabs(POS2-POS1)*CrabsPos(POS2)+Total
		}
		if Total<MinMove set MinMove=Total
		if verbose zwrite Total,MinMove
	}
	set Answer=MinMove

	quit Answer
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Record=recordsArr(1)
	for PC=1:1:$length(Record,",") if $increment(CrabsPos($piece(Record,",",PC)))
	set MinCrab=$order(CrabsPos("")),MaxCrab=$order(CrabsPos(""),-1)
	set MinMove=99999999999999
	for POS1=MinCrab:1:MaxCrab {
		set Total=0
		set POS2=""
		for  {
			set POS2=$order(CrabsPos(POS2)) quit:POS2=""
			continue:POS2=POS1
			set Total=$zabs(POS2-POS1)*($zabs(POS2-POS1)+1)/2*CrabsPos(POS2)+Total
		}
		if Total<MinMove set MinMove=Total
		if verbose zwrite Total,MinMove
	}
	set Answer=MinMove

	quit Answer
}

}

