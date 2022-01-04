Class AOC2021.Day20 Extends AOC2021.Base
{

Parameter InputFile = "d20.txt";

// d ##class(AOC2021.Day20).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set algo=recordsArr(1)
	set Answer="",Line=2
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set grid(Line-2)=Record
	}
	if verbose zwrite algo,grid
	for i=1:1:2 {
		set stat=i#2
		do ..SetGrid(.grid,stat||($extract(algo)="."))
		do ..OutputImage(.grid,algo,stat&&($extract(algo)="#"))
		if verbose do ..GridDisplay(.grid)
	}
	
	if verbose do ..GridDisplay(.grid)
	set Answer=..CountLit(.grid)

	quit Answer
}

ClassMethod SetGrid(ByRef Grid, state) [ Private ]
{
	//do GridDisplay(.Grid)
	set fromY=$order(Grid("")),toY=$order(Grid(""),-1),len=$length(Grid(1)),char=$select(state:".",1:"#")
	set str=""
	set $piece(str,char,len+5)=""
	for d=1:1:2 {
		set (Grid(fromY-d),Grid(toY+d))=str
	}
	for y=fromY:1:toY {
		set Grid(y)=char_char_Grid(y)_char_char
	}
	//do GridDisplay(.Grid)
}

ClassMethod CountLit(ByRef Grid) As %Integer [ Private ]
{
	set y="",total=0
	for  {
		set y=$order(Grid(y)) quit:y=""
		set total=total+$length($translate(Grid(y),"."))
	}
	quit total
}

ClassMethod OutputImage(Output Grid, algo, state) [ Private ]
{
	set fromY=$order(Grid("")),toY=$order(Grid(""),-1)
	set fromX=1,toX=$length(Grid(1)),char=$select('state:".",1:"#")
	//set:$extract(algo)="." char="."
	kill NewGrid merge NewGrid=Grid
	for y=fromY:1:toY {
		for x=fromX:1:toX {
			//i y=fromY,x=fromX w !,binNum
			if y>fromY,y<toY,x>fromX,x<toX {
				set binNum=..GetBin(.Grid,x,y)
				//w !,binNum
				set binLtr=$select($extract(algo,..BinToDec(binNum)+1)="#":"#",1:".")
			}
			else {
				set binLtr=char
			}
			set $extract(NewGrid(y),x)=binLtr
		}
	}
	//zw NewGrid
	kill Grid merge Grid=NewGrid
}

ClassMethod BinToDec(Val) As %Integer [ Private ]
{
	quit:'Val 0
	set Mul=1,Ans=0
	for i=1:1:$length(Val) {
		set:$extract(Val,*-i+1) Ans=Ans+Mul
		set Mul=Mul*2
	}
	quit Ans
}

ClassMethod GetBin(ByRef Grid, px, py) As %String [ Private ]
{
	set num=""
	for y=py-1:1:py+1 {
		set rec=$get(Grid(y))
		for x=px-1:1:px+1 {
			set bin=$select($extract(rec,x)="#":1,1:0)
			set num=num_bin
		}
	}
	quit num
}

ClassMethod GridDisplay(ByRef Grid) [ Private ]
{
	w !!
	//Grid(y)=data
	set y=""
	for  {
		set y=$order(Grid(y)) quit:y=""
		write !,Grid(y)
	}
	w !!
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
	set algo=recordsArr(1)
	set Answer="",Line=2
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set grid(Line-2)=Record
	}
	if verbose zwrite algo,grid
	for i=1:1:50 {
		set stat=i#2
		do ..SetGrid(.grid,stat||($extract(algo)="."))
		do ..OutputImage(.grid,algo,stat&&($extract(algo)="#"))
		if verbose do ..GridDisplay(.grid)
	}
	
	if verbose do ..GridDisplay(.grid)
	set Answer=..CountLit(.grid)
	quit Answer
}

}

