Class AOC2021.Day10 Extends AOC2021.Base
{

Parameter InputFile = "d10.txt";

// d ##class(AOC2021.Day10).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Answer="",Line="",Total=0
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set start1=0,start2=0,start3=0,start4=0
		if verbose write !,Record
		kill arr
		set arr(1)=$extract(Record,1)
		for i=2:1:$length(Record) {
			set char=$extract(Record,i),sw=0
			if ")]}>"[char {
				set last=$order(arr(""),-1)
				quit:last=""
				set lastChar=arr(last)
				if char=")",lastChar'="(" set sw=1
				if char="]",lastChar'="[" set sw=1
				if char="}",lastChar'="{" set sw=1
				if char=">",lastChar'="<" set sw=1
				kill:'sw arr(last)
			}
			if sw {
				if verbose write !,char,";",i,!!!!
				set Total=Total+$case(char,")":3,"]":57,"}":1197,">":25137)
				quit
			}
			set:"([{<"[char arr($order(arr(""),-1)+1)=char
			set:char="(" start1=start1+1
			set:char=")" start1=start1-1
			set:char="[" start2=start2+1
			set:char="]" start2=start2-1
			set:char="{" start3=start3+1
			set:char="}" start3=start3-1
			set:char="<" start4=start4+1
			set:char=">" start4=start4-1
			if (start1<0)||(start2<0)||(start3<0)||(start4<0) {
				if verbose write !,char,";",start1,";",start2,";",start3,";",start4,!!!
				quit
			}
		}
	}
	set Answer=Total
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
	set Answer="",Line="",counter=0
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		set start1=0,start2=0,start3=0,start4=0
		if verbose write !,Record
		kill arr
		set char=$extract(Record,1)
		set arr(1)=char,sw=0
		set:char="(" start1=start1+1
		set:char=")" start1=start1-1
		set:char="[" start2=start2+1
		set:char="]" start2=start2-1
		set:char="{" start3=start3+1
		set:char="}" start3=start3-1
		set:char="<" start4=start4+1
		set:char=">" start4=start4-1
		for i=2:1:$length(Record) {
			set char=$extract(Record,i),sw=0
			if ")]}>"[char {
				set last=$order(arr(""),-1)
				quit:last=""
				set lastChar=arr(last)
				if char=")",lastChar'="(" set sw=1
				if char="]",lastChar'="[" set sw=2
				if char="}",lastChar'="{" set sw=3
				if char=">",lastChar'="<" set sw=4
				kill:'sw arr(last)
			}
			if sw {
				if verbose write !,char,";",i,!!!!
				quit
			}
			set:"([{<"[char arr($order(arr(""),-1)+1)=char
			set:char="(" start1=start1+1
			set:char=")" start1=start1-1
			set:char="[" start2=start2+1
			set:char="]" start2=start2-1
			set:char="{" start3=start3+1
			set:char="}" start3=start3-1
			set:char="<" start4=start4+1
			set:char=">" start4=start4-1
			if (start1<0)||(start2<0)||(start3<0)||(start4<0) {
				set sw=i_","_start1_","_start2_","_start3_","_start4
				if verbose write !,char,";",sw,!!!
				quit
			}
		}
		if 'sw {
			if verbose write !!!,sw,"=",Record,! zwrite arr
			set sum=0
			set pos=""
			for  {
				set pos=$order(arr(pos),-1) quit:pos=""
				set char=arr(pos)
				set sum=sum*5+$case(char,"(":1,"[":2,"{":3,"<":4)
			}
			if verbose write !,sum,!!
			set sums(sum)="",counter=counter+1
		}
	}
	set loc=counter\2+1
	set sum="",counter=0
	for  {
		set sum=$order(sums(sum)) quit:sum=""
		set counter=counter+1
		quit:counter=loc
	}
	set Answer=sum
	quit Answer
}

}

