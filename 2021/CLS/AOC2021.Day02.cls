Class AOC2021.Day02 Extends AOC2021.Base
{

Parameter InputFile = "d02.txt";

// d ##class(AOC2021.Day02).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set X=0,Y=0
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		set Dist=$piece(Record," ",2)
		set Inst=$piece(Record," ",1)
		if Inst="forward" set X=X+Dist
		if Inst="down" set Y=Y+Dist
		if Inst="up" set Y=Y-Dist
		if verbose write !,Record,": ",X,";",Y
	}
	quit X*Y
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
   	set X=0,Y=0,Aim=0
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		set Dist=$piece(Record," ",2)
		set Inst=$piece(Record," ",1)
		if Inst="forward" set X=X+Dist,Y=Aim*Dist+Y
		if Inst="down" set Aim=Aim+Dist
		if Inst="up" set Aim=Aim-Dist
		if verbose write !,Record,": ",X,";",Y
	}
	quit X*Y
}

}

