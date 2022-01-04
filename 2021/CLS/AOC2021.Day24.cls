Class AOC2021.Day24 Extends AOC2021.Base
{

Parameter InputFile = "d24.txt";

// d ##class(AOC2021.Day24).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	if verbose zwrite recordsArr
	set Answer=$list(..AnalayzeData(.recordsArr),1)

	quit Answer
}

ClassMethod AnalayzeData(ByRef Instructions) As %String [ Private ]
{
	//zw Instructions
	//w !!!
	//
	//14 blocks of code repeating
	//changes on add x .. and add y .. in lines 6/16 of routine block
	//stack dy&block# on positive dx and when you get to a negative dx (because each time dx is negative then 'div z 26' is following)
	//pop last dy&block# and compute borders.
	//if pop'd value ("previous" y) is larger than current x value (-x since we take x on negative values) then take previous index as a digit location
	//otherwise take current index as a digit location (compute delta value as delta*10^position counting from zero! and subtract it from the end value)
	//for part2 where the start is needed then do the "opposite" -> add delta value to the start and the digit location is when y is smaller than -x
	set start=11111111111111,end=99999999999999
	for i=0:1:13 {  //i=current block number
		set x=$piece(Instructions(i*18+6)," ",3)  //start of block +6
		set y=$piece(Instructions(i*18+16)," ",3) //start of block +16
		//zw x,y
		if x>0 {
			set Stack($increment(Stack))=$listbuild(i,y)
			continue
		}
		set index=$order(Stack(""),-1),data=Stack(index) kill Stack(index)
		set j=$list(data,1),y=$list(data,2)
		set start=start+$zabs((x+y)*(10**(13-$select(-x>y:j,1:i))))
		set end=end-$zabs((x+y)*(10**(13-$select(-x<y:j,1:i))))
	}
	quit $listbuild(end,start)
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
	if verbose zwrite recordsArr
	set Answer=$list(..AnalayzeData(.recordsArr),2)
	quit Answer
}

}

