  var pi = 3.14159265359;

  var canvasX = 400;
  var canvasY = 400;
  var fov = 90;

  var cubeRadius = 200;
  var cubeDiameter = cubeRadius * 2;

      var cubeX = 0;
      var cubeY = 0;
      var cubeZ = 400;
	  var plane1X;
	  var plane1Y;
	  var plane1Z;
	      var plane1truX;
	      var plane1truY;
	      var plane1truZ;
	      var plane1Dist;
		  var plane1DrawX;
		  var plane1DrawY;
		  var plane1DrawZ;
	      /*
	      var plane1RX;
	      var plane1RY;
	      var plane1RZ;

	      var plane1GX;
	      var plane1GY;
	      var plane1GZ;
	      */
	  var plane2X;
	  var plane2Y;
	  var plane2Z;
	      var plane2truX;
	      var plane2truY;
	      var plane2truZ;
	      var plane2Dist;
		  var plane2DrawX;
		  var plane2DrawY;
		  var plane2DrawZ;

	  var plane3X;
	  var plane3Y;
	  var plane3Z;
	      var plane3truX;
	      var plane3truY;
	      var plane3truZ;
	      var plane3Dist;
		  var plane3DrawX;
		  var plane3DrawY;
		  var plane3DrawZ; 

      var MouseX;
      var MouseY;
      var MouseZ;
      var MouseA = 0;
	  var MouseDist;
	      var MouseDistTerm;

void mouseIsPressed() {
  redraw();  // or loop()
}

       void setup() { 
 size(400,400);
     //loop();
 }
       void draw() 
{  
	MouseA = atan2(mouseX - canvasX/2, mouseY - canvasY/2);
    //MouseA += pi/360;
    MouseDist = dist(mouseX,mouseY,canvasX/2,canvasY/2);
    if (MouseDist > canvasY/2) {MouseDist = canvasY/2;}
    MouseX = (MouseDist)*sin(MouseA);
    MouseY = (MouseDist)*cos(MouseA);
    MouseZ = sqrt(sq(cubeRadius) - (sq(MouseX) + sq(MouseY)));
    if(MouseZ * 0 !== 0) {MouseZ = 0;} 
        
            MouseDistTerm = (MouseDist)*pi/canvasY;
			MouseXTerm = abs(MouseX)*pi/canvasX;
			MouseYTerm = abs(MouseY)*pi/canvasY;
    
    plane1X = cubeRadius*sin(MouseXTerm)*sin(MouseA);
    plane1Y = cubeRadius*sin(MouseYTerm)*cos(MouseA);
    //plane1X = abs(MouseX)*sin(MouseDistTerm)*sin(MouseA);
    //plane1Y = abs(MouseY)*sin(MouseDistTerm)*cos(MouseA);
    plane1Z = MouseZ;
        plane1truX = plane1X + cubeX;
        plane1truY = plane1Y + cubeY;
        plane1truZ = plane1Z + cubeZ;
        plane1Dist = sqrt(sq(plane1truX)+sq(plane1truY)+sq(plane1truZ));
            //plane1DrawX = (canvasX/2) + atan(plane1truX/plane1Dist);
            //plane1DrawY = (canvasY/2) + atan(plane1truY/plane1Dist);
            plane1DrawZ = (360/pi)*atan(10/plane1Dist);
    
    plane2X = -cubeRadius*sin(MouseDistTerm)*sin(MouseA);
    plane2Y = -cubeRadius*sin(MouseDistTerm)*cos(MouseA);
    plane2Z = -MouseZ;
        plane2truX = plane2X + cubeX;
        plane2truY = plane2Y + cubeY;
        plane2truZ = plane2Z + cubeZ;
        plane2Dist = sqrt(sq(plane2truX)+sq(plane2truY)+sq(plane2truZ));
            //plane2DrawX = (canvasX/2) + atan(plane2truX/plane2Dist);
            //plane2DrawY = (canvasY/2) + atan(plane2truY/plane2Dist);
            plane2DrawZ = (360/pi)*atan(10/plane2Dist);
    /*
    plane3X = ((cubeRadius)*sin(MouseDistTerm+90))*sin(MouseA+90);
    plane3Y = ((cubeRadius)*sin(MouseDistTerm+90))*cos(MouseA+90);
    plane3Z = sqrt(sq(cubeRadius) - (sq(plane3X) + sq(plane3Y)));
        plane3truX = plane3X + cubeX;
        plane3truY = plane3Y + cubeY;
        plane3truZ = plane3Z + cubeZ;
        plane3Dist = sqrt(sq(plane3truX)+sq(plane3truY)+sq(plane3truZ));
            //plane3DrawX = (canvasX/2) + atan(plane3truX/plane3Dist);
            //plane3DrawY = (canvasY/2) + atan(plane3truY/plane3Dist);
            plane3DrawZ = atan(70/plane3Dist);
    */
    background(240, 240, 240);
	fill(255,255,255);
	rect(190, 180, 60, 40);
    fill(0, 0, 0);
    text(MouseY, 200, 190);
    text(MouseX, 200, 200);
    text(dist(plane2truX,plane2truY,plane1truX,plane1truY), 200, 210);
	
    ellipse(plane1truX+200, plane1truY+200, plane1DrawZ, plane1DrawZ);
    ellipse(plane2truX+200, plane2truY+200, plane2DrawZ, plane2DrawZ);
	fill(0,255,0);
    //ellipse(0.5*(plane1truX+200+plane2truX+200), 0.5*(plane1truY+200+plane2truY+200), 3, 3);
    fill(255, 0, 0);
    
}
