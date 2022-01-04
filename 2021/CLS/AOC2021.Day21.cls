Class AOC2021.Day21 Extends AOC2021.Base
{

Parameter InputFile = "d21.txt";

// d ##class(AOC2021.Day21).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set playerPos(1)=$piece(recordsArr(1),": ",2)
	set playerPos(2)=$piece(recordsArr(2),": ",2)
	set players(1)=0,players(2)=0,player=1,Moves=0,die=0
	for {
		if players(1)>=1000 set Loser=players(2) quit
		if players(2)>=1000 set Loser=players(1) quit
		set t=0 for i=1:1:3 set die=die+1 set:die>100 die=1 set t=t+die
		set Moves=Moves+3
		set playerPos(player)=(playerPos(player)+t)#10
		set:'playerPos(player) playerPos(player)=10
		set players(player)=players(player)+playerPos(player)
		set player=3-player
	}
	if verbose write !,"Moves=",Moves,", Loser=",Loser
	set Answer=Moves*Loser

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
	set pos1=$piece(recordsArr(1),": ",2)
	set pos2=$piece(recordsArr(2),": ",2)
	kill states set ans=..Play(pos1,pos2,0,0)
	if verbose zwrite ans
	set Answer=$list(ans,1)
	set:$list(ans,2)>Answer Answer=$list(ans,2)
	quit Answer
}

ClassMethod Play(playerPos1, playerPos2, score1, score2) As %String [ Private, PublicList = states ]
{
	quit:score1>=21 $listbuild(1,0)
	quit:score2>=21 $listbuild(0,1)
	quit:$data(states(playerPos1,playerPos2,score1,score2)) states(playerPos1,playerPos2,score1,score2)
	set ans=$listbuild(0,0)
	for dice1=1:1:3 {
		for dice2=1:1:3 {
			for dice3=1:1:3 {
				set tempPos1=(playerPos1+dice1+dice2+dice3)#10 set:'tempPos1 tempPos1=10
				set tempscore1=score1+tempPos1
				set tempAns=..Play(playerPos2,tempPos1,score2,tempscore1)
				set ans=$listbuild($list(ans,1)+$list(tempAns,2),$list(ans,2)+$list(tempAns,1))
			}
		}
	}
	set states(playerPos1,playerPos2,score1,score2)=ans
	quit ans
}

}

