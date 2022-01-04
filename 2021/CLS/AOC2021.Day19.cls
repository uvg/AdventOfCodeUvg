Class AOC2021.Day19 Extends AOC2021.Base
{

Parameter InputFile = "d19.txt";

// d ##class(AOC2021.Day19).Run()

ClassMethod Part1(verbose = 0) As %String [ Private ]
{
	set stream=..GetInput(..#InputFile)
    set line=0
	while 'stream.AtEnd {
		set line=line+1
		set record=stream.ReadLine()
		set recordsArr(line)=record
	}
	do ..GetOrientationsArr(.OrientationsArr)
	do ..GetScannersData(.recordsArr,.Scanners)
	set minScanner=$order(Scanners(""))
	merge scannersAbsPos=Scanners(minScanner)
	merge scannersToAlign=Scanners kill scannersToAlign(minScanner)
	if verbose zwrite minScanner,scannersToAlign,scannersAbsPos,OrientationsArr
	set minIntersections=12
	set:$order(recordsArr(""),-1)<10 minIntersections=3 //example1 test
	for  {
		quit:'$data(scannersToAlign)
		set absPoint=""
		for  {
			set absPoint=$order(scannersAbsPos(absPoint)) quit:absPoint=""
			set scannerToAlign=""
			for  {
				set scannerToAlign=$order(scannersToAlign(scannerToAlign)) quit:scannerToAlign=""
				//ZW scannersToAlign(scannerToAlign)
				kill tempScanner merge tempScanner=scannersToAlign(scannerToAlign)
				for I=1:1:24 {
					set orientation=OrientationsArr(I)
					do ..GetScannerOrientation(.tempScanner,.newOrientedScanner,orientation)
					//ZW orientation,newOrientedScanner
					set alignToPoint=""
					for  {
						set alignToPoint=$order(newOrientedScanner(alignToPoint)) quit:alignToPoint=""
						//ZW alignToPoint,absPoint
						kill OrientedAlignedScanner
						set dx=$list(alignToPoint,1)-$list(absPoint,1)
						set dy=$list(alignToPoint,2)-$list(absPoint,2)
						set dz=$list(alignToPoint,3)-$list(absPoint,3)
						set tempPoint=""
						for  {
							set tempPoint=$order(newOrientedScanner(tempPoint)) quit:tempPoint=""
							set OrientedAlignedScanner($listbuild($list(tempPoint,1)-dx,$list(tempPoint,2)-dy,$list(tempPoint,3)-dz))=""
						}
						//zw newOrientedScanner,OrientedAlignedScanner h 1
						set intersections=..GetIntersections(.OrientedAlignedScanner,.scannersAbsPos)
						if intersections>=minIntersections {
							merge scannersAbsPos=OrientedAlignedScanner
							kill scannersToAlign(scannerToAlign)
							//zw scannerToAlign,absPoint,alignToPoint,orientation
							quit
						}
					}
					quit:'$data(scannersToAlign(scannerToAlign))
				}
			}
		}
	}
	set total=0,i=""
	for  {
		set i=$order(scannersAbsPos(i)) quit:i=""
		set total=total+1
	}
	if verbose zwrite scannersAbsPos
	set Answer=total

	quit Answer
}

ClassMethod GetIntersections(ByRef Points1, ByRef Points2) As %Integer [ Private ]
{
	set total=0
	set point=""
	for  {
		set point=$order(Points1(point)) quit:point=""
		set:$data(Points2(point)) total=total+1
	}	
	quit total
}

ClassMethod GetScannerOrientation(ByRef fromScanner, Output toScanner, orientation) [ Private ]
{
	kill tempScanner
	set point=""
	for  {
		set point=$order(fromScanner(point)) quit:point=""
		set newPoint=""
		for axis=1:1:3 {
			set naxis=$list(orientation,axis)
			set $list(newPoint,axis)=$select(naxis<0:-$list(point,-naxis),1:$list(point,naxis))
		}
		set tempScanner(newPoint)=""
	}
	kill toScanner
	merge toScanner=tempScanner
}

ClassMethod GetScannersData(ByRef RecordsArr, Output Scanners) [ Private ]
{
	kill Scanners
	set Line="",scannerCode=""
	for {
		set Line=$order(RecordsArr(Line)) quit:Line=""
		set Record=RecordsArr(Line)	continue:'$length(Record)
		if Record?1"--- scanner "1.n1" ---" {
			set scannerCode=+$piece(Record,"--- scanner ",2)
			continue
		}
		set x=+$piece(Record,",",1),y=+$piece(Record,",",2),z=+$piece(Record,",",3)
		set Scanners(scannerCode,$listbuild(x,y,z))=""
	}
}

ClassMethod GetOrientationsArr(ByRef OrientationsArr) [ Private ]
{
	//http://www.euclideanspace.com/maths/algebra/matrix/transforms/examples/index.htm
	kill OrientationsArr
	set OrientationsArr($increment(OrientationsArr))=$listbuild(1,2,3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(1,3,-2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(1,-2,-3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(1,-3,2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(2,-1,3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(2,3,1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(2,1,-3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(2,-3,-1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-1,-2,3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-1,-3,-2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-1,2,-3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-1,3,2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-2,1,3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-2,-3,1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-2,-1,-3)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-2,3,-1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(3,2,-1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(3,1,2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(3,-2,1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(3,-1,-2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-3,-2,-1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-3,-1,2)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-3,2,1)
	set OrientationsArr($increment(OrientationsArr))=$listbuild(-3,1,-2)
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
	do ..GetOrientationsArr(.OrientationsArr)
	do ..GetScannersData(.recordsArr,.Scanners)
	set minScanner=$order(Scanners(""))
	merge scannersAbsPos=Scanners(minScanner)
	merge scannersToAlign=Scanners kill scannersToAlign(minScanner)
	//ZW minScanner,scannersToAlign,scannersAbsPos //,OrientationsArr
	set minIntersections=12
	set:$order(recordsArr(""),-1)<10 minIntersections=3 //example1 test
	for  {
		quit:'$data(scannersToAlign)
		set absPoint=""
		for  {
			set absPoint=$order(scannersAbsPos(absPoint)) quit:absPoint=""
			set scannerToAlign=""
			for  {
				set scannerToAlign=$order(scannersToAlign(scannerToAlign)) quit:scannerToAlign=""
				//ZW scannersToAlign(scannerToAlign)
				kill tempScanner merge tempScanner=scannersToAlign(scannerToAlign)
				for I=1:1:24 {
					set orientation=OrientationsArr(I)
					do ..GetScannerOrientation(.tempScanner,.newOrientedScanner,orientation)
					//ZW orientation,newOrientedScanner
					set alignToPoint=""
					for  {
						set alignToPoint=$order(newOrientedScanner(alignToPoint)) quit:alignToPoint=""
						//ZW alignToPoint,absPoint
						set dx=$list(alignToPoint,1)-$list(absPoint,1)
						set dy=$list(alignToPoint,2)-$list(absPoint,2)
						set dz=$list(alignToPoint,3)-$list(absPoint,3)
						kill OrientedAlignedScanner
						set tempPoint=""
						for  {
							set tempPoint=$order(newOrientedScanner(tempPoint)) quit:tempPoint=""
							set OrientedAlignedScanner($listbuild($list(tempPoint,1)-dx,$list(tempPoint,2)-dy,$list(tempPoint,3)-dz))=""
						}
						//zw newOrientedScanner,OrientedAlignedScanner h 1
						set intersections=..GetIntersections(.OrientedAlignedScanner,.scannersAbsPos)
						if intersections>=minIntersections {
							merge scannersAbsPos=OrientedAlignedScanner
							kill scannersToAlign(scannerToAlign)
							set offsets($listbuild(dx,dy,dz))=""
							quit
						}
					}
					quit:'$data(scannersToAlign(scannerToAlign))
				}
			}
		}
	}
	if verbose zw offsets
	set i="",maxDist=0
	for  {
		set i=$order(offsets(i)) quit:i=""
		set j=i for  {
			set j=$order(offsets(j)) quit:j=""
			set dist=0
			for axis=1:1:3 {
				set dist=$zabs($list(j,axis)-$list(i,axis))+dist
			}
			set:dist>maxDist maxDist=dist
		}
	}
	if verbose zwrite scannersAbsPos
	set Answer=maxDist
	quit Answer
}

}

