Class AOC2021.Day16 Extends AOC2021.Base
{

Parameter InputFile = "d16.txt";

// d ##class(AOC2021.Day16).Run()

ClassMethod Part1(verbose = 0) As %String [ Private, PublicList = verbose ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Data=..HexToBin(recordsArr(1))
	if verbose write !,Data
	set Answer=..GetPacketsTotalVersion(.Data)

	quit Answer
}

ClassMethod GetPacketsTotalVersion(ByRef Data) As %Integer [ PublicList = verbose ]
{
	quit:'$length(Data) 0
	set Version=..BinToDec($extract(Data,1,3)),ID=..BinToDec($extract(Data,4,6))
	set Data=$extract(Data,7,*)
	quit:'$length(Data) 0
	if verbose write !,"data=",Data,";",Version,";",ID
	if ID=4 {
		set value=""
		for i=1:5:$length(Data) {
			set part=$extract(Data,i,i+4)
			set end='$extract(part,1)
			set value=value_$extract(part,2,5)
			quit:end
		}
		if verbose write !,"value=",value
		set value=..BinToDec(value)
		set Data=$extract(Data,i+5,*)
		if verbose write !,"Data=",Data,",version=",Version
		quit Version
	}
	else {
		set lengthType=$extract(Data),$extract(Data)=""
		if verbose write !,"lengthType=",lengthType,";Data=",Data
		if lengthType=0 {
			set Length=..BinToDec($extract(Data,1,15)),Data=$extract(Data,16,*)
			set SubPackets=$extract(Data,1,Length),Data=$extract(Data,Length+1,*)
			set value=0
			for  quit:'$length(SubPackets)  set value=value+..GetPacketsTotalVersion(.SubPackets)
		}
		else {
			set numOfPackets=..BinToDec($extract(Data,1,11)),Data=$extract(Data,12,*)
			set value=0
			for i=1:1:numOfPackets {
				set value=value+..GetPacketsTotalVersion(.Data)
			}
		}
		if verbose write !,Version+value
		quit Version+value
	}
}

ClassMethod BinToDec(Val = "") As %Integer
{
	quit:'$length(Val) 0
	set ans=""
	//from 36bit to 40bit easier for translation to hex
	if $length(Val)#4 for i=1:1 set Val=0_Val quit:'($length(Val)#4)
	for i=0:1:$length(Val)/4-1 {
		set part=$extract(Val,i*4+1,i*4+4)
		set char=$case(part,"0000":0,"0001":1,"0010":2,"0011":3,"0100":4,"0101":5,"0110":6,"0111":7,1000:8,1001:9,1010:"A",1011:"B",1100:"C",1101:"D",1110:"E",1111:"F")
		set ans=ans_char
	}
	quit $zhex(""_ans)
}

ClassMethod HexToBin(Val) As %String [ Private ]
{
	quit:'$length(Val) "0000"
	set ans=""
	for i=1:1:$length(Val) {
		set part=$extract(Val,i)
		set char=$case(part,0:"0000",1:"0001",2:"0010",3:"0011",4:"0100",5:"0101",6:"0110",7:"0111",8:1000,9:1001,"A":1010,"B":1011,"C":1100,"D":1101,"E":1110,"F":1111)
		set ans=ans_char
	}
	quit ans
}

ClassMethod Part2(verbose = 0) As %String [ Private, PublicList = verbose ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Data=..HexToBin(recordsArr(1))
	if verbose write !,Data
	set Answer=..GetPacketsTotalValue(.Data)

	quit Answer
}

ClassMethod GetPacketsTotalValue(ByRef Data) As %Integer [ PublicList = verbose ]
{
	quit:'$length(Data) 0
	set Version=..BinToDec($extract(Data,1,3)),ID=..BinToDec($extract(Data,4,6))
	set Data=$extract(Data,7,*)
	quit:'$length(Data) 0
	i verbose w !,"data=",Data,";",Version,";",ID
	if ID=4 {
		set value=""
		for i=1:5:$length(Data) {
			set part=$extract(Data,i,i+4)
			set end='$extract(part,1)
			set value=value_$extract(part,2,5)
			quit:end
		}
		if verbose write !,"value=",value
		set value=..BinToDec(value)
		set Data=$extract(Data,i+5,*)
		if verbose write !,"Data=",Data,",version=",Version
		quit value
	}
	else {
		set lengthType=$extract(Data),$extract(Data)=""
		if verbose write !,"lengthType=",lengthType,";Data=",Data
		if lengthType=0 {
			set Length=..BinToDec($extract(Data,1,15)),Data=$extract(Data,16,*)
			set SubPackets=$extract(Data,1,Length),Data=$extract(Data,Length+1,*)
			set value=0
			set:ID=1 value=1
			set:ID=2 value=9999999999999999
			set:ID=3 value=-9999999999999999
			set val1=""
			for  {
				quit:'$length(SubPackets)
				set tempVal=..GetPacketsTotalValue(.SubPackets)
				if ID<5 {
					set value=..GetValue(ID,value,tempVal)
				}
				else {
					if '$length(val1) {
						set val1=tempVal
					}
					else {
						set value=..GetValue(ID,val1,tempVal)
					}
				}
			}
		}
		else {
			set numOfPackets=..BinToDec($extract(Data,1,11)),Data=$extract(Data,12,*)
			set value=0
			set:ID=1 value=1
			set:ID=2 value=9999999999999999
			set:ID=3 value=-9999999999999999
			set val1=""
			for i=1:1:numOfPackets {
				set tempVal=..GetPacketsTotalValue(.Data)
				if ID<5 {
					set value=..GetValue(ID,value,tempVal)
				}
				else {
					if '$length(val1) {
						set val1=tempVal
					}
					else {
						set value=..GetValue(ID,val1,tempVal)
					}
				}
			}
		}
		//w !,Version+value
		quit value
	}
}

ClassMethod GetValue(ID, val1, val2) As %Integer [ Private, PublicList = verbose ]
{
	if verbose write !,ID,";",val1,";",val2
	set val1=+val1,val2=+val2
	quit:ID=0 val1+val2
	quit:ID=1 val1*val2
	quit:ID=2 ..Min(val1,val2)
	quit:ID=3 ..Max(val1,val2)
	quit:ID=5 val1>val2
	quit:ID=6 val1<val2
	quit val1=val2
}

ClassMethod Min(Val1, Val2) As %Integer [ Private ]
{
	if Val1<Val2 quit Val1
	quit Val2
}

ClassMethod Max(Val1, Val2) As %Integer [ Private ]
{
	if Val1>Val2 quit Val1
	quit Val2
}

}

