Class AOC2021.Day09 Extends AOC2021.Base
{

Parameter InputFile = "d09.txt";

// d ##class(AOC2021.Day9).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Line="",RISK=0
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set RecordBelow=$get(recordsArr(Line+1))
		set RecordAbove=$get(recordsArr(Line-1))
		for I=1:1:$length(Record) {
			set H=$extract(Record,I)
			set (Right,Left,Up,Down)=999999999999
			set:$extract(Record,I-1)'="" Left=$extract(Record,I-1)
			set:$extract(Record,I+1)'="" Right=$extract(Record,I+1)
			set:$extract(RecordBelow,I)'="" Down=$extract(RecordBelow,I)
			set:$extract(RecordAbove,I)'="" Up=$extract(RecordAbove,I)
			if H<Right,H<Left,H<Up,H<Down {
				set RISK=RISK+H+1
				if verbose write H,";",Line,!
			}
		}
	}
	set Answer=RISK
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
	set Line=""
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		for I=1:1:$length(Record) {
			continue:$extract(Record,I)=9
			set Size=..GetSize(.recordsArr,Line,I)
			if Size,$increment(Arr(Size))
			if verbose write:Size !,Line,";",I,"=",Size
		}
	}

	set Size="",Total=1,Count=0
	while Count<3 {
		set Size=$order(Arr(Size),-1)
		for i=1:1:Arr(Size) {
			if verbose write !,Size
			set Total=Size*Total
			set Count=Count+1
			quit:Count=3
		}
	}

	set Answer=Total
	quit Answer
}

ClassMethod GetSize(ByRef RecordsArr, Y, X) As %Integer [ Private ]
{
	set Digit=$extract($get(RecordsArr(Y)),X)
	quit:Digit'?1N 0
	quit:Digit=9 0
	set $extract(RecordsArr(Y),X)=" "
	//Can also flow downward to a location "above" //quit 1+..GetSize(.RecordsArr,Y,X+1)+..GetSize(.RecordsArr,Y,X-1)+..GetSize(.RecordsArr,Y+1,X)
	quit 1+..GetSize(.RecordsArr,Y,X+1)+..GetSize(.RecordsArr,Y,X-1)+..GetSize(.RecordsArr,Y+1,X)+..GetSize(.RecordsArr,Y-1,X)
}

}

