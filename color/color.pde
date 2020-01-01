boolean mouseDown = false;
bollean update = true;
int r,g,b;


void mousePressed () 
{	
	mouseDown = true
}

void mouseReleased() 
{
	mouseDown = false;
}

void setup() 
{
	frameRate(60);
	size(940, 78);
	stroke(0,0,0,200);
	strokeWeight(30);
	size(window.innerWidth, window.innerHeight);
}

void draw() 
{	
	if(mouseDown)
	{
	update = true;
	float h,s,v;
	background(r,g,b);
	h = (mouseX/window.innerWidth);
	s = (mouseY/window.innerHeight)*2;
	v = 2-s;
	if(v>1){v=1;}
	
	float[] rgb = hsv2rgb(h,s,v);	
	r = rgb[0]*255;
	g = rgb[1]*255;
	b = rgb[2]*255;
	
	}
	if (update)
	{
	render();
	update = false;
	}   
}
void render()
{
	background(r,g,b);
}

float[] hsv2rgb(float h, s ,v)
{
	float[] out = new float[3];
	float hue = h*6;
	int hue0 = (int)hue;
	float hue1 = hue - hue0;
	
	float p = v * (1.0 - s);
	float q = v * (1.0 - (s * hue1));
	float t = v * (1.0 - (s * (1.0 - hue1)));

	switch(hue0)
	{
		case 0:
		out[0] = v;
		out[1] = t;
		out[2] = p;
		break;
		case 1:
		out[0] = q;
		out[1] = v;
		out[2] = p;
		break;
		case 2:
		out[0] = p;
		out[1] = v;
		out[2] = t;
		break;

		case 3:
		out[0] = p;
		out[1] = q;
		out[2] = v;
		break;
		case 4:
		out[0] = t;
		out[1] = p;
		out[2] = v;
		break;
		case 5:
		default:
		out[0] = v;
		out[1] = p;
		out[2] = q;
		break;
	}
	return out;
}
