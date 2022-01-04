Class AOC2021.Day06 Extends AOC2021.Base
{

Parameter InputFile = "d06.txt";

// d ##class(AOC2021.Day06).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	for LanterFish=-1:1:8 set LanterFishes(LanterFish)=0
	for pc=1:1:$length(recordsArr(1),",") set LanterFishes($piece(recordsArr(1),",",pc))=LanterFishes($piece(recordsArr(1),",",pc))+1
	for Day=1:1:80 {
		if verbose write !!,Day,!
		if verbose zwrite LanterFishes
		for LanterFish=-1:1:7 {
			set LanterFishes(LanterFish)=LanterFishes(LanterFish+1)
		}
		set LanterFishes(8)=0
		if LanterFishes(-1) {
			set LanterFishes(8)=LanterFishes(8)+LanterFishes(-1)
			set LanterFishes(6)=LanterFishes(6)+LanterFishes(-1)
			set LanterFishes(-1)=0
		}
	}
	set Sum=0
	for LanterFish=0:1:8 {
		set Sum=Sum+LanterFishes(LanterFish)
	}
	set Answer=Sum
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
	for LanterFish=-1:1:8 set LanterFishes(LanterFish)=0
	for pc=1:1:$length(recordsArr(1),",") set LanterFishes($piece(recordsArr(1),",",pc))=LanterFishes($piece(recordsArr(1),",",pc))+1
	for Day=1:1:256 {
		if verbose write !!,Day,!
		if verbose zwrite LanterFishes
		for LanterFish=-1:1:7 {
			set LanterFishes(LanterFish)=LanterFishes(LanterFish+1)
		}
		set LanterFishes(8)=0
		if LanterFishes(-1) {
			set LanterFishes(8)=LanterFishes(8)+LanterFishes(-1)
			set LanterFishes(6)=LanterFishes(6)+LanterFishes(-1)
			set LanterFishes(-1)=0
		}
	}
	set Sum=0
	for LanterFish=0:1:8 {
		set Sum=Sum+LanterFishes(LanterFish)
	}
	set Answer=Sum
	quit Answer
}

}

