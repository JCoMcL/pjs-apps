string[] splitChars = {" ","\t","\n"};
string[] endChars = {", ",". ","; ",": "};
int fontSize = 20;
int lineLength = 20;

public string[] strings = {"life","the universe","everything"};
public boolean redraw = true;
public boolean mouseDown = false;
public int index = 0;

public var col0 = #ffffff;
public var col1 = #000000;

var[] clickables;
var[] renderables;
var[] updatables;

void mousePressed () 
{
	mouseDown = true;
	for(int i = 0; i<clickables.length; i++)
	{
		if(clickables[i].click())
		{return;}
	}
	next();
}
void mouseReleased()
{
	mouseDown = false;
	for(int i = 0; i<clickables.length; i++)
	{ 
		if(clickables[i].active)
			{clickables[i].active=false;}
	}
}
void keyPressed()
{
	if(keyCode == UP || keyCode == LEFT)
			{previous();}
	else
			{next();}
}

void setup() 
{
	frameRate(60);
    size(940, 78);
    stroke(col1);
    fill(col1);
    //noFill();
    strokeWeight(10);
    textAlign(CENTER);
    txtSize(20);
    textMode(SCREEN);

    progScroller p = new progScroller();
   	clickables = {p};
   	renderables = {p};
   	updatables = {p};
    ArrayList out = new ArrayList();
    string[] lines = loadStrings("text.txt");
    console.log(lines);
    for(int p = 0; p<lines.length; p++)
    {
    	string line = lines[p];
    	string[] words = splitString(line);
    	for(int i = 0; words!=null && i<words.length;i++)
    		{out.add(words[i]);}	
    }
    strings = out.toArray();
    size(window.innerWidth, window.innerHeight);
}

boolean containsChar(string[] a, string b)
{
	for(int i = 0; i < a.length; i++)
	{
		if(b.equals(a[i]))
			{return true;}
	}
	return false;
}
string[] splitString(string s)
{
	if(s.length() == 0){return null;}
	string str = "";
	ArrayList out = new ArrayList();
	for(int i = 0; i<s.length()-1; i++)
	{
		char c = s[i];
		boolean split = containsChar(splitChars, c);
		boolean end = containsChar(endChars, c+s[i+1]);
		if(end || (split && str.length>lineLength) || i==s.length-1)
		{
			if(end)				{str+=c;}
			if(str.length>0)	{out.add(str);}
			str="";
		}
		else{
			str+=c;
		}
	}
	int i = s.length()-1;
	char c = s[i];
	if(!containsChar(splitChars,c))	{str+=c;}
	if(str.length>0)	{out.add(str);}
	return out.toArray();
}
int txtSize(int set)
{
	if(set>0)
	{
		textSize(set);
		fontSize = set;
	}
	else(console.log(set));
	return fontSize;
}
void next()
{
	if(index < strings.length-1){index++;}
	else{index=0;}
	redraw = true;
}
void previous()
{
	if(index > 0){index--;}
	else{index=strings.length-1;}
	redraw = true;
}
void draw() 
{	
	for(int i = 0; i<updatables.length; i++)
		{updatables[i].update();} 	
    if (redraw)
    {
    	render();
    	redraw = false;
    }   
}
void render()
{
	size(window.innerWidth, window.innerHeight);
	background(col0);
	stroke(col1);
	string str = strings[index];
	txtSize(Math.round(width/str.length*2));
	bool idealtextSize = false;
	for(int i = 0; i<2000&&!idealtextSize; i++)
	{
		float tWidth = 	textWidth(str);
		int dif = 	width-tWidth;
		if(dif>50)		{txtSize(fontSize+Math.round(dif/str.length)+1);}
		else if(dif<5)	{txtSize(fontSize+Math.round(dif/str.length)-1);}
		else{			idealtextSize = true; break;}
		if(fontSize>height*0.8)
		{
			txtSize(height*0.8);
			idealtextSize = true; break;
		}
	}
	fill(col1);
	text(str,width/2, (height+fontSize*.3)/2);
	for(int i = 0; i<renderables.length; i++)
		{renderables[i].render();}

}

class progScroller
{
	public boolean active;

	float r = 10;
	float y = height*0.9+r;
	float x;
	float p = 0.1;
	float x0 = r+width*p;
	float x1 = width-x0;

	public void render()
	{
		strokeWeight(5);
		x = (x1-x0)*(index/(strings.length-1))+x0;
		y = height*0.9+r;
		line(x0,y,x1,y);
		fill(col0);
		ellipse(x,y,r*2,r*2);
	}
	public boolean click()
	{
		if(includes(mouseX,mouseY))
		{
			active = true;
			update();
			return true;
		}
		return false;

	}
	public void update()
	{
		if(active)
		{
			if(!mouseDown)	{active = false; return;}
			index = (mouseX-(r+width*p))*(strings.length-1)/(width*(1-2*p)-r);
			if(index < 0)				{index = 0;}
			if(index >= strings.length)	{index = strings.length-1;}
			index = Math.round(index);
			redraw = true;
		}
		x0 = r+width*p;
		x1 = width-x0;
	}
	boolean includes(float mx,my)
	{
		if(
			mx<=x+r &&
			mx>=x-r &&
			my<=y+r &&
			my>=y-r &&
			Math.sqrt((my-y)*(my-y)+(mx-x)*(mx-x))<=r
		){return true;}
		return false;
	}
}