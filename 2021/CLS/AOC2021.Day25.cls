Class AOC2021.Day25 Extends AOC2021.Base
{

Parameter InputFile = "d25.txt";

// d ##class(AOC2021.Day25).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	merge Grid=recordsArr
	set Answer=""
	for i=1:1 {
		if verbose write !!,"After ",i," steps:" do ..GridDisplay(.Grid)
		merge CurrGrid=Grid
		do ..ComputeNextGrid(.Grid)
		quit:..CompareGrids(.CurrGrid,.Grid)
	}
	set Answer=i

	quit Answer
}

ClassMethod ComputeNextGrid(Output Grid) [ Private ]
{
	set Width=$length(Grid(1)),Height=$order(Grid(""),-1)
	//
	//Move east
	set y=""
	for  {
		set y=$order(Grid(y)) quit:y=""
		set data=Grid(y)
		set NewData=data
		for x=1:1:Width {
			set ltr1=$extract(data,x)
			continue:ltr1'=">"
			set nextPos=x+1 set:nextPos>Width nextPos=1
			set ltr2=$extract(data,nextPos)
			continue:ltr2'="."
			set $extract(NewData,x)="."
			set $extract(NewData,nextPos)=ltr1
		}
		set NewGrid(y)=NewData
	}
	kill Grid merge Grid=NewGrid
	//
	//Move south
	for  {
		set y=$order(Grid(y)) quit:y=""
		set data=Grid(y)
		for x=1:1:Width {
			set ltr1=$extract(data,x)
			continue:ltr1'="v"
			set nextPos=y+1 set:nextPos>Height nextPos=1
			set ltr2=$extract(Grid(nextPos),x)
			continue:ltr2'="."
			set $extract(NewGrid(y),x)="."
			set $extract(NewGrid(nextPos),x)=ltr1
		}
	}
	kill Grid merge Grid=NewGrid
}

ClassMethod CompareGrids(ByRef Grid1, ByRef Grid2) As %Boolean [ Private ]
{
	set y=""
	for  {
		set y=$order(Grid1(y)) quit:y=""
		if Grid2(y)'=Grid1(y) return 0
	}
	quit 1
}

ClassMethod GridDisplay(ByRef Grid) [ Private ]
{
	//Grid(y)=data
	set y=""
	for  {
		set y=$order(Grid(y)) quit:y=""
		write !,Grid(y)
	}
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
	if verbose write !,"You made it to the last day"
	set Answer="Finito la comedy"
	quit Answer
}

}

