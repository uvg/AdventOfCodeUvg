Class AOC2021.Day03 Extends AOC2021.Base
{

Parameter InputFile = "d03.txt";

// d ##class(AOC2021.Day03).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		s BitCount=$l(Record)
		for bitPos=1:1:BitCount {
			set bit=$extract(Record,bitPos)
			if $increment(bits(bitPos,bit))
		}
	}
	if verbose write ! zwrite bits
	set Gamma="",Epsilon="",bit=""
	for bitPos=1:1:BitCount {
		set bit=$select($get(bits(bitPos,0))>$get(bits(bitPos,1)):0,1:1)
		set Gamma=Gamma_bit
	}
	set Epsilon=$translate(Gamma,10,"01")
	if verbose write !,"Gamma=",Gamma,", Epsilon=",Epsilon,!
	set Answer=..BinToDec(Epsilon)*..BinToDec(Gamma)
	
	quit Answer
}

ClassMethod BinToDec(Val = 0) As %Integer [ Private ]
{
	quit:'Val 0
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

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	set Line=0
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		set Line=Line+1
		set RecordsArr(Line)=Record
	}
	set Answer="",bitsCount=$length(RecordsArr(1))
	merge OxyArr=RecordsArr,CO2Arr=RecordsArr
	for bitPos=1:1:bitsCount {
		kill bits
		set Line=""
		if $order(OxyArr(""))'=$order(OxyArr(""),-1) {
			for  {
				set Line=$order(OxyArr(Line)) quit:Line=""
				set Record=OxyArr(Line)
				set bit=$extract(Record,bitPos)
				if $increment(bits(bit)) set bits(bit,Line)=""
			}
			set MaxBit=1
			set:$get(bits(0))>$get(bits(1)) MaxBit=0
			set Line=""
			for  {
				set Line=$order(bits('MaxBit,Line)) quit:Line=""
				kill OxyArr(Line)
			}
		}
		kill bits
		set Line=""
		if $order(CO2Arr(""))'=$order(CO2Arr(""),-1) {
			for  {
				set Line=$order(CO2Arr(Line)) quit:Line=""
				set Record=CO2Arr(Line)
				set bit=$extract(Record,bitPos)
				if $increment(bits(bit)) set bits(bit,Line)=""
			}
			set MinBit=0
			set:$get(bits(1))<$get(bits(0)) MinBit=1
			set Line=""
			for  {
				set Line=$order(bits('MinBit,Line)) quit:Line=""
				kill CO2Arr(Line)
			}
		}
	}
	set CO2Line=$order(CO2Arr("")),OxyLine=$order(OxyArr(""))
	set CO2=CO2Arr(CO2Line),Oxy=OxyArr(OxyLine)
	if verbose write !,"CO2=",CO2,", Oxy=",Oxy,!
	set Answer=..BinToDec(CO2)*..BinToDec(Oxy)
	
	quit Answer
}

}

