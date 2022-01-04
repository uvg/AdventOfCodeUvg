Class AOC2021.Day05 Extends AOC2021.Base
{

Parameter InputFile = "d05.txt";

// d ##class(AOC2021.Day05).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set Overlap=0
	while 'stream.AtEnd {
		set record=stream.ReadLine()
		set fromX=+$piece(record,",",1),fromY=+$piece(record,",",2)
		set toX=+$piece($piece(record," -> ",2),",",1),toY=+$piece($piece(record," -> ",2),",",2)
		if verbose write !,record,";",fromX,";",fromY,";",toX,";",toY
		if (fromX=toX)||(fromY=toY) {
			if verbose write ";","inside"
			set DiffY=1 set:fromY>toY DiffY=-1
			set DiffX=1 set:fromX>toX DiffX=-1
			for Y=fromY:DiffY:toY {
				for X=fromX:DiffX:toX {
					if $increment(grid(Y,X))=2 set Overlap=Overlap+1
				}
			}
		}
	}
	set Answer=Overlap
	quit Answer
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set Overlap=0
	while 'stream.AtEnd {
		set record=stream.ReadLine()
		set fromX=+$piece(record,",",1),fromY=+$piece(record,",",2)
		set toX=+$piece($piece(record," -> ",2),",",1),toY=+$piece($piece(record," -> ",2),",",2)
		if verbose write !,record,";",fromX,";",fromY,";",toX,";",toY
		if (fromX=toX)||(fromY=toY)||($zabs(fromX-toX)=$zabs(fromY-toY)) {
			if verbose write ";","inside"
			set DiffY=1 set:fromY>toY DiffY=-1
			set DiffX=1 set:fromX>toX DiffX=-1
			set X=fromX
			for Y=fromY:DiffY:toY {
				if (fromX=toX)||(fromY=toY) {
					for X=fromX:DiffX:toX {
						if $increment(grid(Y,X))=2 set Overlap=Overlap+1
					}
				}
				else {
					if $increment(grid(Y,X))=2 set Overlap=Overlap+1
					set X=X+DiffX
				}
			}
		}
	}
	set Answer=Overlap
	quit Answer
}

}

