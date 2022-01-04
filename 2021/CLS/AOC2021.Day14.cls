Class AOC2021.Day14 Extends AOC2021.Base
{

Parameter InputFile = "d14.txt";

// d ##class(AOC2021.Day14).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	set Template=""
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		continue:'$length(Record)
		if '$length(Template) {
			set Template=Record
			continue
		}
		set From=$piece(Record," -> ",1),To=$piece(Record," -> ",2)
		set PairArr(From)=To
	}
	if verbose write !,Template
	for i=1:1:10 {
		set NewTemplate=""
		for j=1:1:$length(Template)-1 {
			set From=$extract(Template,j,j+1)
			set To=PairArr(From)
			set NewTemplate=NewTemplate_$extract(Template,j)_To
		}
		set NewTemplate=NewTemplate_$extract(Template,*)
		if verbose write !,i,":  ",$length(NewTemplate)
		set Template=NewTemplate
	}
	for i=1:1:$length(Template) if $increment(Occur($extract(Template,i)))
	if verbose write !! zwrite Occur
	set Min=999999999999999999,Max=-1
	set Element=""
	for  {
		set Element=$order(Occur(Element)) quit:Element=""
		if Occur(Element)>Max set Max=Occur(Element)
		if Occur(Element)<Min set Min=Occur(Element)
	}
	set Answer=Max-Min
	quit Answer
}

ClassMethod Part2(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
	set Template=""
	while 'stream.AtEnd {
		set Record=stream.ReadLine()
		continue:'$length(Record)
		if '$length(Template) {
			set Template=Record
			continue
		}
		set From=$piece(Record," -> ",1),To=$piece(Record," -> ",2)
		set PairArr(From)=To
		set Occur($extract(From,1))=0
		set Occur($extract(From,2))=0
		set Occur(To)=0
	}
	for j=1:1:$length(Template) {
		set Occur($extract(Template,j))=Occur($extract(Template,j))+1
	}
	for j=1:1:$length(Template)-1 if $increment(DoubleArr($extract(Template,j,j+1)))
	if verbose zwrite Template,Occur,DoubleArr
	for i=1:1:40 {
		kill NewDoubleArr merge NewDoubleArr=DoubleArr
		set From="" for  {
			set From=$order(DoubleArr(From)) quit:From=""
			set count=DoubleArr(From)
			continue:'count
			set To=PairArr(From),Occur(To)=Occur(To)+count
			set NewDoubleArr(From)=NewDoubleArr(From)-count
			set NewDoubleArr($extract(From,1)_To)=$get(NewDoubleArr($extract(From,1)_To))+count
			set NewDoubleArr(To_$extract(From,2))=$get(NewDoubleArr(To_$extract(From,2)))+count
		}
		kill DoubleArr merge DoubleArr=NewDoubleArr
	}
	if verbose zwrite DoubleArr,Occur
	set Min=999999999999999999,Max=-1
	set Element=""
	for  {
		set Element=$order(Occur(Element)) quit:Element=""
		if Occur(Element)>Max set Max=Occur(Element)
		if Occur(Element)<Min set Min=Occur(Element)
	}
	set Answer=Max-Min
	quit Answer
}

}

