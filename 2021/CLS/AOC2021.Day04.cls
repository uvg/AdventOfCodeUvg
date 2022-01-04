Class AOC2021.Day04 Extends AOC2021.Base
{

Parameter InputFile = "d04.txt";

// d ##class(AOC2021.Day04).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set DrawnNumbers=..GetData(.recordsArr,.Boards)
	set Answer=""
	for pos=1:1:$length(DrawnNumbers,",") {
		set DrawnNumber=$piece(DrawnNumbers,",",pos)
		do ..MarkBoards(.Boards,DrawnNumber)
		set Board="",WinningBoard="",SW=0
		for  {
			set Board=$order(Boards(Board)) quit:Board=""
			set SW=..IsWinningBoard(.Boards,Board)
			if SW {
				set WinningBoard=Board
				quit
			}
		}
		quit:SW
	}
	set Sum=..BoardSum(.Boards,WinningBoard)
	if verbose write !,"Sum=",Sum,", DrawnNumber=",DrawnNumber
	set Answer=DrawnNumber*Sum

	quit Answer
}

ClassMethod GetData(ByRef RecordsArr, Output Boards) As %String [ Private ]
{
	set Line="",Board=0,DrawnNumbers=""
	for {
		set Line=$order(RecordsArr(Line)) quit:Line=""
		set Record=RecordsArr(Line)
		if '$length(Record) {
			set Board=Board+1
			continue
		}
		if Record["," {
			set DrawnNumbers=Record
			continue
		}
		set BoardLine=$increment(Boards(Board)),BoardNumbers=""
		for loc=1:3:$length(Record) {
			set BoardNumbers=BoardNumbers_$lb($lb(+$zstrip($extract(Record,loc,loc+2),"<>W"),0))
		}
		set Boards(Board,BoardLine)=BoardNumbers
	}
	set Board=""
	for  {
		set Board=$order(Boards(Board)) quit:Board=""
		set Boards(Board)=0
	}
	quit DrawnNumbers
}

ClassMethod MarkBoards(ByRef Boards, DrawnNumber) As %Boolean [ Private ]
{
	set Board="",SW=0
	for  {
		set Board=$order(Boards(Board)) quit:Board=""
		continue:Boards(Board)
		set SW=1
		for Row=1:1:5 {
			set RowData=Boards(Board,Row)
			for Column=1:1:5 {
				set NumberData=$list(RowData,Column)
				if $list(NumberData,1)=DrawnNumber {
					set $list(NumberData,2)=1
					set $list(RowData,Column)=NumberData
					set Boards(Board,Row)=RowData
				}
			}
		}
	}
	quit SW
}

ClassMethod IsWinningBoard(ByRef Boards, Board) As %Boolean [ Private ]
{
	set SW=0
	for Row=1:1:5 {
		set RowData=Boards(Board,Row)
		set SW=1
		for Column=1:1:5 {
			set NumberData=$list(RowData,Column)
			if $list(NumberData,2)=0 {
				set SW=0
				quit
			}
		}
		quit:SW
	}
	quit:SW 1
	for Column=1:1:5 {
		set SW=1
		for Row=1:1:5 {
			set RowData=Boards(Board,Row)
			set NumberData=$list(RowData,Column)
			if $list(NumberData,2)=0 {
				set SW=0
				quit
			}
		}
		quit:SW
	}
	quit SW
}

ClassMethod BoardSum(ByRef Boards, Board) As %Integer [ Private ]
{
	set Sum=0
	for Row=1:1:5 {
		set RowData=Boards(Board,Row)
		for Column=1:1:5 {
			set NumberData=$list(RowData,Column)
			if $list(NumberData,2)=0 {
				set Sum=Sum+$list(NumberData,1)
			}
		}
	}
	quit Sum
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
	set DrawnNumbers=..GetData(.recordsArr,.Boards)
	set Answer=""
	for pos=1:1:$length(DrawnNumbers,",") {
		set DrawnNumber=$piece(DrawnNumbers,",",pos)
		quit:'..MarkBoards(.Boards,DrawnNumber)
		set Board="",WinningBoard="",SW=0,LastDrawnNumber=DrawnNumber
		for  {
			set Board=$order(Boards(Board)) quit:Board=""
			continue:Boards(Board)
			set SW=..IsWinningBoard(.Boards,Board)
			if SW {
				set WinningBoard=Board,Boards(Board)=1
				continue
			}
		}
	}
	set Sum=..BoardSum(.Boards,WinningBoard)
	if verbose write !,"Sum=",Sum,", LastDrawnNumber=",LastDrawnNumber
	set Answer=LastDrawnNumber*Sum
	quit Answer
}

}

