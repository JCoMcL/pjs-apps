var ref = [];
int newLine = [];

boolean dragging =	false;
boolean panning =	false;
boolean zooming =	false;
boolean rim = 		false;
boolean override = 	false;
boolean drawLine = 	false;

float active;
float pActive;
float count;
float time;

float cX = 0;
float cY = 0;
float cZ;
float midX = window.innerWidth/2;
float midY = window.innerHeight/2;

class orb 
{ 
	float x; 
	float y;
	float rad = 	100;
	float vX;
	float vY;
	float vRad;
	color col1 =  	color(255, 255, 255, 235);
	color col2 = 	color(255, 255, 255);
	color col3 =	color(255, 255, 255, 100);
	string text;
	var relatives = [];
	
	orb (float setx, sety) 
	{  
		x = setx; 
		y = sety; 
	} 
	void drag() 
	{ 
		x += (mouseX - pmouseX) / cZ;
		y += (mouseY - pmouseY) / cZ;
	}
	void transform()
	{
		vX = (((x + cX) - midX) * cZ)+ midX;
		vY = (((y + cY) - midY) * cZ) + midY;
		vRad = (rad * cZ);
	}
}
void mousePressed () 
{	
	time = millis();
	if(mouseButton == LEFT)
	{	
		if (active < ref.length)
		{
			if(rim)
			{
				drawLine=true;
				pActive = active;
			}
			else
			{	
				var a = ref.splice(active,1);
				ref.push(a[0]);
				active = ref.length-1;
				dragging = true;	
			}
			override = true;
		}
	}
	if(mouseButton == CENTER)
	{
		panning = true;
	}
	if(mouseButton == RIGHT)
	{
		zooming = true;
	}
}

void mouseReleased() 
{
	if(millis() - time < 100 && pmouseY == mouseY && pmouseX == mouseX){cZ += 0.1;}
	dragging = false;
	override = false;
	panning = false;
	zooming = false;
	if(drawLine && pActive != active && active != ref.length)
	{
		var a = ref[pActive].relatives.indexOf(ref[active]);
		if(ref[pActive].relatives.includes(ref[active]))
			{ref[pActive].relatives.splice(a, 1);}
		else
			{ref[pActive].relatives.push(ref[active]);}
	}
	drawLine = false;
}

void setup() 
{
	frameRate(60);
	size(940, 78);
	strokeWeight(0);
	size(window.innerWidth, window.innerHeight);

	cX = 0;
	cY = 0;
	cZ = 0.8;

	count = 12;
	for(i=0; i<count; i++)
	{
		orb norb = new orb (random(window.innerWidth,0),random(window.innerHeight,0));
		int a = random(0,255);
		int b = random(0,255);
		int c = random(0,255);
		norb.col1 = color(a,b,c,200);
		norb.col2 = color(a,b,c);
		norb.col3 = color((a + a + 255) / 3,(b + b + 255) / 3,(c + c + 255) / 3, 125);
		norb.transform();
		ref.push(norb);
	}
}

void draw() 
{	
	midX = window.innerWidth/2;
	midY = window.innerHeight/2;
	
	//size(window.innerWidth, window.innerHeight);
		
		
	if(!dragging)
	{	//Mouse Tracking
		boolean focused = false;
		for (int i=0; i<ref.length; i++)
		{	
			if (dist(mouseX, mouseY, ref[i].vX, ref[i].vY) <= ref[i].vRad)
			{	
				active = i;
				focused = true;
				if (dist(mouseX, mouseY, ref[i].vX, ref[i].vY) <= ref[i].vRad * 0.8)
				{	rim=false;}
				else
				{	rim=true;}
			}
		}
		if (!focused)
		{	
			active = ref.length;
			focused = false;
			rim =  false;
		}
	}
	else
	{	//Dragging
		ref[active].drag();
		ref[active].transform();
	}

	if(panning)
	{
		cX += (mouseX - pmouseX) / cZ;
		cY += (mouseY - pmouseY) / cZ;
		for (int i=0; i<ref.length; i++){ref[i].transform();}	
	}

	if(zooming)
	{
		cZ = constrain(cZ + (mouseY - pmouseY) / 100 * cZ, 0.1, 2);
		for (int i=0; i<ref.length; i++){ref[i].transform();}	
	}
		
		//Drawing
	background(0);
	
	stroke(255,255,255,200);
	strokeWeight(constrain(10, 20 * cZ, 100 * cZ));
	if 	(drawLine)
		{	line(ref[pActive].vX, ref[pActive].vY, mouseX, mouseY);}
	
	for (int a=0; a < ref.length; a++)
	{
		for (int i=0; i < ref[a].relatives.length; i++)
		{
			int x1 = ref[a].vX;
			int y1 = ref[a].vY;
			int x2 = ref[a].relatives[i].vX;
			int y2 = ref[a].relatives[i].vY;
			stroke(ref[a].col3);
			line(x1, y1, x2, y2);
		}
	}
	
	for (int i=0; i<ref.length; i++)
	{
		if(i == active)
		{
			if(rim)
			{
				fill(ref[i].col1);
				stroke(ref[i].col2);
				strokeWeight(ref[i].vRad * 0.2);
				ellipse(ref[i].vX, ref[i].vY, ref[i].vRad * 1.8, ref[i].vRad * 1.8);
			}
			else
			{
				fill(ref[i].col2);
				stroke(ref[i].col1);
				strokeWeight(ref[i].vRad * 0.4)
				ellipse(ref[i].vX, ref[i].vY, ref[i].vRad * 1.6, ref[i].vRad * 1.6)

			}
		}
		else
		{
			fill(ref[i].col1);
			noStroke();
			ellipse(ref[i].vX, ref[i].vY, ref[i].vRad * 2, ref[i].vRad * 2);
		}
		fill(0,0,0);
		textAlign(CENTER, CENTER);
		textSize(25 * cZ);
		text(i+"\n"+active+"\n"+rim+"\n"+cZ, ref[i].vX, ref[i].vY)
	}
}	  
