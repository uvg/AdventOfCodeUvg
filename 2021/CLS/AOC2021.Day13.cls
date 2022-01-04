Class AOC2021.Day13 Extends AOC2021.Base
{

Parameter InputFile = "d13.txt";

// d ##class(AOC2021.Day13).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set Answer="",maxX=-1
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		if Record["," {
			set x=$piece(Record,",",1)
			set grid($piece(Record,",",2),x)="#"
			set:maxX<x maxX=x
		}
		else {
			set:Record["y=" folds($increment(folds))=$listbuild(1,+$piece(Record,"=",2))
			set:Record["x=" folds($increment(folds))=$listbuild(2,+$piece(Record,"=",2))
		}
	}
	for y=0:1:$order(grid(""),-1) {
		for x=0:1:maxX {
			set grid(y,x)=$select($length($get(grid(y,x))):"#",1:" ")
		}
	}
	if verbose zwrite folds,maxX do ..PrintGrid(.grid)
	for foldi=1:1:1 {
		set fold=folds(foldi)
		set xy=$list(fold,1),pos=$list(fold,2)
		if xy=1 do ..foldY(.grid,pos)
		if xy=2 do ..foldX(.grid,pos)
		if verbose write !,..Count(.grid)
	}
	set Answer=..Count(.grid)
	quit Answer
}

ClassMethod Count(ByRef grid) As %Integer [ Private ]
{
	set y="",total=0
	for  {
		set y=$order(grid(y)) quit:y=""
		set x=""
		for  {
			set x=$order(grid(y,x)) quit:x=""
			if grid(y,x)="#" set total=total+1
		}
	}
	quit total
}

ClassMethod foldY(Output grid, pos) [ Private ]
{
	for y=1:1:pos {
		set x=""
		for  {
			set x=$order(grid(pos+y,x)) quit:x=""
			continue:grid(pos+y,x)'="#"
			set grid(pos-y,x)="#"
		}
	}
	for y=pos:1:$order(grid(""),-1) {
		kill grid(y)
	}
}

ClassMethod foldX(Output grid, pos) [ Private ]
{
	set y=""
	for  {
		set y=$order(grid(y)) quit:y=""
		for x=1:1:pos {
			continue:grid(y,x+pos)'="#"
			set grid(y,pos-x)="#"
		}
	}
	set y="",lastX=$order(grid(0,""),-1)
	for  {
		set y=$order(grid(y)) quit:y=""
		for x=pos:1:lastX {
			kill grid(y,x)
		}
	}
}

ClassMethod PrintGrid(ByRef grid) [ Private ]
{
	set lastY=$order(grid(""),-1)
	set lastX=$order(grid(0,""),-1)
	for y=0:1:lastY {
		write !
		for x=0:1:lastX {
			write grid(y,x)
		}
	}
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set maxX=-1
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		if Record["," {
			set x=$piece(Record,",",1)
			set grid($piece(Record,",",2),x)="#"
			set:maxX<x maxX=x
		}
		else {
			set:Record["y=" folds($increment(folds))=$listbuild(1,+$piece(Record,"=",2))
			set:Record["x=" folds($increment(folds))=$listbuild(2,+$piece(Record,"=",2))
		}
	}
	for y=0:1:$order(grid(""),-1) {
		for x=0:1:maxX {
			set grid(y,x)=$select($length($get(grid(y,x))):"#",1:" ")
		}
	}
	if verbose zwrite folds,maxX do ..PrintGrid(.grid)
	for foldi=1:1:folds {
		set fold=folds(foldi)
		set xy=$list(fold,1),pos=$list(fold,2)
		if xy=1 do ..foldY(.grid,pos)
		if xy=2 do ..foldX(.grid,pos)
		i verbose write !,..Count(.grid)
	}
	do ..PrintGrid(.grid)
	set Answer="^^^^^^^^^^^^^^^^^^^^^^^"
	quit Answer
}

}

