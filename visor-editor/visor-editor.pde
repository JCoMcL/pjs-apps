//Click on a node to change its setting
//Drag a node to move the associated line
var browHeight = 180;
var browX = 100;
var browY = 200;

var sideX = 100;
var sideY = 250;

var CurveOutX = 120;
var CurveOutY = 280;
var CurveOutSize = 0;
var CurveInX = 180;
var CurveInY = 260;

var selected = 0;
var altered = [-1, 1, -1, -1];
var clickStor = [0, 0];

var Dist1 = dist(browX, browY, sideX, sideY);
var Dist2 = dist(200, browHeight, browX, browY);
var Dist3 = dist(sideX, sideY, CurveOutX, CurveOutY);

void mouseIsPressed() {
	redraw();
}

void setup() { 
	size(400,400);
}
void draw() { 
	background(255, 255, 255);

	noFill();
	if (altered[0] === -1) {
		bezier( browX, browY, 200, browHeight, 200, browHeight, 400 - browX, browY);
	} else {
		line( browX, browY, 200, browHeight);
		line( 400 - browX, browY, 200, browHeight);
	}
	Dist1 = dist(browX, browY, sideX, sideY);
	Dist2 = dist(200, browHeight, browX, browY);
	Dist3 = dist(sideX, sideY, CurveOutX, CurveOutY);
	if (altered[1] === -1) {
		bezier(browX, browY, ((browX-200) * (1+(Dist1/Dist2)) + 200), ((browY-browHeight) * (1+(Dist1/Dist2)) + browHeight), sideX+((sideX-CurveOutX)*(Dist1/Dist3)), sideY+(sideY-CurveOutY)*(Dist1/Dist3), sideX, sideY);
		bezier(400 - browX, browY, 400-((browX-200) * (1+(Dist1/Dist2)) + 200), ((browY-browHeight) * (1+(Dist1/Dist2)) + browHeight), 400-sideX-((sideX-CurveOutX)*(Dist1/Dist3)), sideY+(sideY-CurveOutY)*(Dist1/Dist3), 400-sideX, sideY); 
	} else {
		line( browX, browY, sideX, sideY);
		line( 400 - browX, browY, 400-sideX, sideY);
	}
	if (altered[2] === -1) {
	bezier(sideX, sideY, CurveOutX, CurveOutY, CurveInX, CurveInY, 185, 240);
	bezier(400-sideX, sideY, 400-CurveOutX, CurveOutY, 400-CurveInX, CurveInY, 215, 240);
	} else {
		line( sideX, sideY, CurveOutX, CurveOutY);
		line( CurveOutX, CurveOutY, 185, 240);
		line( 400-sideX, sideY, 400-CurveOutX, CurveOutY);
		line( 400-CurveOutX, CurveOutY, 215, 240);
	}

	bezier(185, 240, 185-((185-CurveInX)/-1.3), 240-((240-CurveInY)/-1.3) , 215-((185-CurveInX)/1.3), 240		 -((240-CurveInY)/-1.3) , 215, 240);
	text(clickStor[0],200,200);
	text(clickStor[1],200,210)

	fill(255, 0, 0);
	ellipse(200, browHeight, 5, 5);
	ellipse(sideX, sideY, 5, 5);
	ellipse(CurveOutX, CurveOutY, 5, 5);
	ellipse(browX, browY, 5, 5);

	fill(51, 255, 0);
	if (mousePressed) {
		if ((mouseX >= 197) && (mouseX <= 203) && (mouseY >= browHeight-3) && (mouseY <= browHeight+3)) {selected = 1;}
		if ((mouseX >= sideX-3) && (mouseX <= sideX+3) && (mouseY >= sideY-3) && (mouseY <= sideY+3)) {selected = 2;}
		if ((mouseX >= CurveOutX-3) && (mouseX <= CurveOutX+3) && (mouseY >= CurveOutY-3) && (mouseY <= CurveOutY+3)) {selected = 3;}
		if ((mouseX >= browX-3) && (mouseX <= browX+3) && (mouseY >= browY-3) && (mouseY <= browY+3)) {selected = 4;}

		if (selected === 1) {browHeight = mouseY;}
		if (selected === 2) {sideX = mouseX; sideY = mouseY;}
		if (selected === 3) {CurveOutX = mouseX; CurveOutY = mouseY;}
		if (selected === 4) {browX = mouseX; browY = mouseY;}
	}
	else {selected = 0;}
}

void mousePressed () {clickStor = [mouseX, mouseY];};
void mouseReleased () {
	if (mouseX === clickStor[0] && mouseY === clickStor[1]) {
		if ((selected === 1) && (mouseX >= 197) && (mouseX <= 203) && (mouseY >= browHeight-3) && (mouseY <= browHeight+3)) 
			{altered[0] *= -1;}
		if ((selected === 2) && (mouseX >= sideX-3) && (mouseX <= sideX+3) && (mouseY >= sideY-3) && (mouseY <= sideY+3)) 
			{altered[1] *= -1;}
		if ((selected === 3) && (mouseX >= CurveOutX-3) && (mouseX <= CurveOutX+3) && (mouseY >= CurveOutY-3) && (mouseY <= CurveOutY+3)) 
			{altered[2] *= -1;}
		if ((selected === 4) && (mouseX >= CurveInX-3) && (mouseX <= CurveInX+3) && (mouseY >= CurveInY-3) && (mouseY <= CurveInY+3)) 
			{altered[3] *= -1;}
	}
};
