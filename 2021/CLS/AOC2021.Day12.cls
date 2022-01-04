Class AOC2021.Day12 Extends AOC2021.Base
{

Parameter InputFile = "d12.txt";

// d ##class(AOC2021.Day12).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	while 'stream.AtEnd {
		set record=stream.ReadLine()
		set loc1=$piece(record,"-",1),loc2=$piece(record,"-",2)
		set FromTo(loc1,loc2)=""
		set FromTo(loc2,loc1)=""
	}
	do ..GetTotalPaths(.FromTo,"start","end",.visited,$listbuild(""),.AllPaths)
	set Total=0,Path=""
	for  {
		set Path=$order(AllPaths(Path)) quit:Path=""
		set Total=Total+1
	}
	if verbose zwrite AllPaths
	set Answer=Total
	quit Answer
}

ClassMethod GetTotalPaths(ByRef FromTo, From, To, Output visited, Path, Output TotalPaths, EnableTwice = 0) [ Private ]
{
	if From=To {
		//zwrite Path
		set TotalPaths(Path)="" 
		quit 0
	}
	set chr=$ascii($extract(From))
	if chr>=97,$data(visited(From)) {
		if 'EnableTwice quit 0
		if From="start" quit 0
		if visited(From)=2 quit 0
		set tmpFrom="",sw=0
		for  {
			set tmpFrom=$order(visited(tmpFrom)) quit:tmpFrom=""
			if visited(tmpFrom)=2 {
				set sw=1
				quit
			}
		}
		quit:sw 0
	}
	set:chr>=97 visited(From)=$get(visited(From))+1
	set Path=Path_$listbuild(From)
	set tmpFrom=""
	for  {
		set tmpFrom=$order(FromTo(From,tmpFrom)) quit:tmpFrom=""
		kill tempVisited merge tempVisited=visited
		do ..GetTotalPaths(.FromTo,tmpFrom,To,.tempVisited,Path,.TotalPaths,EnableTwice)
	}
	quit
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	while 'stream.AtEnd {
		set record=stream.ReadLine()
		set loc1=$piece(record,"-",1),loc2=$piece(record,"-",2)
		set FromTo(loc1,loc2)=""
		set FromTo(loc2,loc1)=""
	}
	do ..GetTotalPaths(.FromTo,"start","end",.visited,"",.AllPaths,1)
	set Total=0,Path=""
	for  {
		set Path=$order(AllPaths(Path)) quit:Path=""
		set Total=Total+1
	}
	if verbose zwrite AllPaths
	set Answer=Total

	quit Answer
}

}

