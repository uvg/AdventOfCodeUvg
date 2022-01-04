Class AOC2021.Base
{

Parameter Folder = "C:\devl\work\Cache\AOC\Files\2021\";

ClassMethod GetInput(fn) As %Stream
{
   
    set fn=..#Folder_fn
    set stream = ##Class(%Stream.FileCharacter).%New()
    do stream.LinkToFile(fn)
    return stream
}

// d ##class(AOC2021.Day{D}).Run()

ClassMethod Run(verbose = 0, part = 0) [ Final ]
{
	if (part=0)||(part=1) set answer=..Part1(verbose) write !,"Part1: " zwrite answer
	if (part=0)||(part=2) set answer=..Part2(verbose) write !,"Part2: " zwrite answer
}

ClassMethod Part1(verbose = 0) As %String [ Abstract, Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Answer="Part1"
	quit Answer
}

ClassMethod Part2(verbose = 0) As %String [ Abstract, Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Answer="Part2"
	quit Answer
}

}

