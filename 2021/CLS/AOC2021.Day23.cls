Class AOC2021.Day23 Extends AOC2021.Base
{

Parameter InputFile = "d23.txt";

// d ##class(AOC2021.Day23).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	set Empty=$listbuild("E")
	set startState=$listbuild(Empty,Empty)
	for i=4:2:10 {
		set col=""
		for y=3,4 {
			set Data=recordsArr(y)
			set ltr=$extract(Data,i)
			set col=col_$listbuild(ltr)
		}
		set startState=startState_$listbuild(col)_$listbuild(Empty)
	}
	set startState=startState_$listbuild(Empty)
	if verbose zwrite recordsArr,startState
	set Answer=..FindMinPath(startState)

	quit Answer
}

ClassMethod FindMinPath(startState) As %Integer [ Private ]
{
	set total=0,Q(total,$increment(Q))=startState,totalMoves=0
	for  {
		set total=$order(Q("")) quit:'$length(total)
		set line=$order(Q(total,"")),state=Q(total,line) kill Q(total,line)
		continue:$data(visited(state))
		//zwrite total,state
		quit:..IsFinished(state)
		set visited(state)=total
		for room=1:1:$listlength(state) {
			set x=1
			if room>2,room<10,room#2 {
				set roomData=$list(state,room)
				set roomSize=$listlength(roomData)
				while (x<roomSize)&&($list(roomData,x)="E") {
					set x=x+1
				}
			}
			do ..ComputeMoves(room,state,x,.moves)
			set move=""
			for  {
				set move=$order(moves(move)) quit:move=""
				set nextState=state,data=moves(move)
				set room1=$list(nextState,room),room2=$list(nextState,$list(data,1))
				set p1=$list(room2,$list(data,2)),p2=$list(room1,x)
				set $list(room1,x)=p1,$list(room2,$list(data,2))=p2
				set $list(nextState,room)=room1,$list(nextState,$list(data,1))=room2
				set nextEnergy=total+..GetEnergy($list($list(state,room),x),room,x,$list(data,1),$list(data,2))
				set totalMoves=totalMoves+1
				//zw nextEnergy,nextState
				set Q(nextEnergy,$increment(Q))=nextState
			}
		}
	}
	quit total
}

ClassMethod IsFinished(state) As %Boolean [ Private ]
{
	set Empty=$listbuild("E")
	if state=$listbuild(Empty,Empty,$listbuild("A","A"),Empty,$listbuild("B","B"),Empty,$listbuild("C","C"),Empty,$listbuild("D","D"),Empty,Empty) quit 1
	if state=$listbuild(Empty,Empty,$listbuild("A","A","A","A"),Empty,$listbuild("B","B","B","B"),Empty,$listbuild("C","C","C","C"),Empty,$listbuild("D","D","D","D"),Empty,Empty) quit 1
	quit 0
}

ClassMethod ComputeMoves(room, state, position, Output moves) [ Private ]
{
	kill moves
	set Amphipod=$list($list(state,room),position)
	quit:Amphipod="E"  //Empty space isn't moving
	set roomTarget=($ascii(Amphipod)-$ascii("A")+1)*2+1  //where to put the amphipod
	if roomTarget=room,position=$listlength($list(state,room)) quit  //Amphipod is allready in it's final position in the room it need to be in so stop moving
	//
	//Hallway places that we can go from current room to left/right (until a place in the hallway isn't empty)
	set visit(room)=""
	for nextRoom=room+1:1:$listlength(state) {
		if ",3,5,7,9,"'[(","_nextRoom_","),$list($list(state,nextRoom),1)'="E" quit
		set visit(nextRoom)=""
	}
	for nextRoom=room-1:-1:1 {
		if ",3,5,7,9,"'[(","_nextRoom_","),$list($list(state,nextRoom),1)'="E" quit
		set visit(nextRoom)=""
	}
	// 
	set maxDepth=0
		if $data(visit(roomTarget)) {
			//maybe we can get the amphipod into it's room
			//so check how deep we can go into this room
			set stateRoomData=$list(state,roomTarget)
			for nextDepth=$listlength(stateRoomData):-1:1 {
				set nextAmphipod=$list(stateRoomData,nextDepth)
				if nextAmphipod="E" {
					//empty space so we can go there
					set:nextDepth>maxDepth maxDepth=nextDepth
				}
	else {
					//not empty space in a room and the amphipod in this place is not the amphipod we're trying to move, so stop look in this room
					quit:nextAmphipod'=Amphipod
				}
	}
		if maxDepth {
			set moves($increment(moves))=$listbuild(roomTarget,maxDepth)
			quit
		}
	}
	//
	//if we got to here then we couldn't move the amphipod into it's room
	quit:",3,5,7,9,"'[(","_room_",")  //In the hallway and couldn't get to it's room, so no moves for this amphipod
	//
	//check what rooms we can get closer to
	set nextRoom=""
	for  {
		set nextRoom=$order(visit(nextRoom)) quit:nextRoom=""
		continue:",3,5,7,9,"[(","_nextRoom_",")
		set moves($increment(moves))=$listbuild(nextRoom,1)
	}
	quit
}

ClassMethod GetEnergy(Amphipod, RoomStart, DepthStart, RoomEnd, DepthEnd) As %Integer [ Private ]
{
	set Energy=$zabs(RoomEnd-RoomStart)
	set:",3,5,7,9,"[(","_RoomStart_",") Energy=Energy+DepthStart
	set:",3,5,7,9,"[(","_RoomEnd_",") Energy=Energy+DepthEnd
	set multi=1
	for i=1:1:$ascii(Amphipod)-$ascii("A") set multi=multi_0
	quit Energy*multi
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
	set Empty=$listbuild("E")
	set startState=$listbuild(Empty,Empty)
	set recordsArr(6)=recordsArr(4)
	set recordsArr(4)="  #D#C#B#A#"
	set recordsArr(5)="  #D#B#A#C#"
	for i=4:2:10 {
		set col=""
		set y=2
		for  {
			set y=$order(recordsArr(y)) quit:y=""
			set Data=recordsArr(y)
			set ltr=$extract(Data,i)
			set col=col_$listbuild(ltr)
		}
		set startState=startState_$listbuild(col)_$listbuild(Empty)
	}
	set startState=startState_$listbuild(Empty)
	if verbose zwrite recordsArr,startState
	set Answer=..FindMinPath(startState)
	quit Answer
}

}

