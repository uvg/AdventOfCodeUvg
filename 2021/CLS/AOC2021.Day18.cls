Class AOC2021.Day18 Extends AOC2021.Base
{

Parameter InputFile = "d18.txt";

// d ##class(AOC2021.Day18).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Answer=recordsArr(1),Line=1
	for {
		set Line=$order(recordsArr(Line)) quit:Line=""
		set Record=recordsArr(Line)
		if verbose write !,Answer,"+",Record,"=",!
		set Answer=..Add(Answer,Record)
		if verbose write Answer
		set Answer=..Reduce(Answer)
		if verbose write " Reduced to",!,Answer
	}
	if verbose write !,Answer
	set Answer=..Magnitude(Answer)
	quit Answer
}

ClassMethod Add(num1, num2) As %String [ Private ]
{
	quit "["_num1_","_num2_"]"
}

ClassMethod Reduce(string) As %String [ Private ]
{
	for  {
		set nextString=string
		for  {
			set currString=nextString
			set nextString=..Explode(currString)
			//w !! zw string,nextString
			quit:currString=nextString
		}
		set currString=nextString
		set nextString=..Split(currString)
		//w !! zw string,nextString
		quit:nextString=string
		set string=nextString
	}
	quit string
}

ClassMethod Explode(string) As %String [ Private ]
{
	set (counter,start,end)=0
	for i=1:1:$length(string) {
		set ltr=$extract(string,i)
		if ltr="[" {
			set counter=counter+1
			continue
		}
		if ltr="]" {
			set counter=counter-1
			continue
		}
		continue:counter<5
		set start=i
		set end=$find(string,"]",i)-2
		set data=$extract(string,start,end)
		set val1=$piece(data,",",1),val2=$piece(data,",",2)
		set sw=0,sw1="",sw2=""
		set newString=string
		for j=start-1:-1:1 {
			if $extract(string,j)?1n {
				set sw=j
				quit
			}
		}
		set:'sw val1=""
		if sw {
			set leftVal=""
			for j=sw:-1:1 {
				set ltr=$extract(string,j)
				quit:ltr'?1n
				set leftVal=ltr_leftVal
			}
			set sw1=$listbuild(j+1,sw)
			set val1=val1+leftVal
		}
		set sw=0
		for j=end+1:1:$length(string) {
			if $extract(string,j)?1n {
				set sw=j
				quit
			}
		}
		set:'sw val2=""
		if sw {
			set rightVal=""
			for j=sw:1:$length(string) {
				set ltr=$extract(string,j)
				quit:ltr'?1n
				set rightVal=rightVal_ltr
			}
			set sw2=$listbuild(sw,j-1)
			set val2=val2+rightVal
		}
		set newString=string
		set:sw2'="" $extract(newString,$list(sw2,1),$list(sw2,2))=val2
		set $extract(newString,start-1,end+1)=0
		set:sw1'="" $extract(newString,$list(sw1,1),$list(sw1,2))=val1
		//zw string,newString
		set string=newString
		quit
	}
	quit string
}

ClassMethod Split(string) As %String [ Private ]
{
	//zw string
	for i=1:1:$length(string) {
		set ltr=$extract(string,i)
		continue:ltr'?1n
		set val=+$extract(string,i,*)
		continue:val<10
		set val1=val\2
		set val2=+$fnumber(val/2,"",0)
		set newVal="["_val1_","_val2_"]"
		set string=$replace(string,val,newVal,,1)
		quit
	}
	quit string
}

ClassMethod Magnitude(string) As %String [ Private ]
{
	for  {
		set nextString=string
		for i=1:1:$length(string) {
			continue:$extract(string,i,*)'?1"["1.N1","1.N1"]".E
			set val1=+$extract(string,i+1,*)
			set val2=+$piece($extract(string,i,*),",",2)
			//zwrite val1,val2
			set ans=(val1*3)+(val2*2)
			set nextString=$replace(nextString,"["_val1_","_val2_"]",ans,,1)
			quit
		}
		//zw string,nextString
		quit:nextString=string
		set string=nextString
	}
	//zw string,nextString
	quit string
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
	set lastLine=$order(recordsArr(""),-1)
	set maxMagnitude=0
	for Line1=1:1:lastLine-1 {
		for Line2=Line1+1:1:lastLine {
			set add1=..Add(recordsArr(Line1),recordsArr(Line2))
			set add2=..Add(recordsArr(Line2),recordsArr(Line1))
			set ans1=..Magnitude(..Reduce(add1))
			set ans2=..Magnitude(..Reduce(add2))
			if ans1>maxMagnitude {
				set maxMagnitude=ans1
				if verbose write !,add1,"=",maxMagnitude
			}
			if ans2>maxMagnitude {
				set maxMagnitude=ans2
				if verbose write !,add2,"=",maxMagnitude
			}
		}
	}
	set Answer=maxMagnitude
	quit Answer
}

}

