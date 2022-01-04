Class AOC2021.Day15 Extends AOC2021.Base
{

Parameter InputFile = "d15.txt";

// d ##class(AOC2021.Day15).Run()

ClassMethod Part1(verbose = 0) As %String [ Private, PublicList = verbose ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set LastY=$order(recordsArr(""),-1)
	set LastX=$length(recordsArr(1))
	if verbose write !,LastX,"x",LastY,! zwrite recordsArr
	set Answer=..GetPath(.recordsArr,1,1,LastX,LastY)
	quit Answer
}

ClassMethod GetPath(ByRef Grid, FromX, FromY, ToX, ToY) As %Integer [ Private, PublicList = (MinPath, verbose) ]
{
	set PQ(0,$listbuild(FromX, FromY))=""
	while $data(PQ)>1 {
		set Total=$order(PQ("")) quit:Total=""
		set pos=$order(PQ(Total,""))
		if pos="" {
			kill PQ(Total)
			continue
		}
		kill PQ(Total,pos)
		set FromX=$list(pos,1),FromY=$list(pos,2)
		if FromX=ToX,FromY=ToY quit
		continue:$data(Visited(FromX,FromY))
		set val=$extract($get(Grid(FromY)),FromX) continue:'$length(val)
		if verbose write !,FromX,",",FromY,"=",Total,"+",val
		set Visited(FromX, FromY)=Total
		set PQ(Total+$extract($get(Grid(FromY)),FromX+1),$listbuild(FromX+1,FromY))=""
		set PQ(Total+$extract($get(Grid(FromY)),FromX-1),$listbuild(FromX-1,FromY))=""
		set PQ(Total+$extract($get(Grid(FromY+1)),FromX),$listbuild(FromX,FromY+1))=""
		set PQ(Total+$extract($get(Grid(FromY-1)),FromX),$listbuild(FromX,FromY-1))=""
	}
	if verbose write !,FromX,",",FromY,"=",Total
	quit Total
}

ClassMethod GetSimpleMinPath(ByRef Grid) [ Private ]
{
	set LastY=$order(Grid(""),-1),LastX=$length(Grid(1))
	set (TotalBottomLeft,TotalTopRight)=0
	for y=2:1:LastY {
		set TotalBottomLeft=TotalBottomLeft+$extract(Grid(y),1)
		set TotalTopRight=TotalTopRight+$extract(Grid(y),LastX)
	}
	for x=2:1:LastX {
		set TotalBottomLeft=TotalBottomLeft+$extract(Grid(LastY),x)
		set TotalTopRight=TotalTopRight+$extract(Grid(1),x)
	}
	if TotalBottomLeft<TotalTopRight quit TotalBottomLeft
	quit TotalTopRight
}

ClassMethod Part2(verbose = 0) As %String [ Private, PublicList = (MinPath, verbose) ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	merge OrigGrid=recordsArr,Grid=recordsArr
	set MaxSize=$length(OrigGrid(1))*5
	for i=1:1:8 {
		kill NewGrid
		do ..SetNewGrid(.OrigGrid,.NewGrid,i)
		//if verbose write !!!,i do ..DisplayGrid(.NewGrid)
		do ..MergeGrid(.Grid,.NewGrid,MaxSize)
		//if verbose do ..DisplayGrid(.Grid)
	}
	set LastY=$order(Grid(""),-1)
	set LastX=$length(Grid(1))
	if verbose write ! do ..DisplayGrid(.Grid)
	set Answer=..GetPath(.Grid,1,1,LastX,LastY)
	quit Answer
}

ClassMethod DisplayGrid(ByRef Grid) [ Private ]
{
	set LastY=$order(Grid(""),-1)
	for y=1:1:LastY {
		write !,Grid(y)
	}
}

ClassMethod MergeGrid(Output Grid, Output NewGrid, MaxSize) [ Private ]
{
	set LastY=$order(Grid(""),-1)
	set LastNewY=$order(NewGrid(""),-1),LastNewX=$length(NewGrid(1))
	for y=1:1:LastY {
		set NewY=y#LastNewY set:'NewY NewY=LastNewY
		continue:$length(Grid(y))=MaxSize
		set Grid(y)=Grid(y)_NewGrid(NewY)
	}
	quit:LastY=MaxSize
	for y=LastY+1:1:LastY+LastNewX {
		set NewY=y#LastNewY set:'NewY NewY=LastNewY
		set Grid(y)=NewGrid(NewY)
	}
}

ClassMethod SetNewGrid(ByRef FromGrid, Output ToGrid, Offset) [ Private ]
{
	set LastY=$order(FromGrid(""),-1),LastX=$length(FromGrid(1))
	for y=1:1:LastY {
		set FromLine=FromGrid(y),ToLine=""
		for x=1:1:LastX {
			set val=$extract(FromLine,x)+Offset set:val>9 val=val-9
			set ToLine=ToLine_val
		}
		set ToGrid(y)=ToLine
	}
}

}

