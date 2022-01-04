Class AOC2021.Day01 Extends AOC2021.Base
{

Parameter InputFile = "d01.txt";

// d ##class(AOC2021.Day01).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set count=0,line=0
	while 'stream.AtEnd {
		set line=line+1
		set depth=stream.ReadLine()
		if line>1,depth>prev set count=count+1
		set prev=depth
		if verbose write !,line,"=",count
	}
	quit count
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set count=0,line=0
	while 'stream.AtEnd {
		set line=line+1
		set depth=stream.ReadLine()
		set records(line)=depth
	}
	set line=2
	for  {
		set line=$order(records(line)) quit:line=""
		set depths($increment(depths))=records(line)+records(line-1)+records(line-2)
	}
	set line=""
	for  {
		set line=$order(depths(line)) quit:line=""
		set depth=depths(line)
		if line>1,depth>prev set count=count+1
		set prev=depth
		if verbose write !,line,"=",count
	}
	quit count
}

}

