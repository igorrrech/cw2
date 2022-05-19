unit unmenu;

uses WPFObjects,GraphWPF;
var fon:ObjectWPF;
var name:ObjectWPF;
var playButton:ObjectWPF;
var exitButton:ObjectWPF;

procedure MouseDown(x,y:real;mousebut:integer);
begin
  if mousebut=1 then
    begin
    if (x > playButton.Center.X - 100) and (x < playButton.Center.X + 100) and (y > playButton.Center.Y - 25) and (y < playButton.Center.Y + 25)then
      begin
       OnMouseDown:=nil;
       BeginFrameBasedAnimation(game,60);
      end;
    if (x > exitButton.Center.X - 100) and (x < exitButton.Center.X + 100) and (y > exitButton.Center.Y - 25) and (y < exitButton.Center.Y + 25)then
       Window.Close;
   end;
end;
procedure menu();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  name:=new RectangleWPF(Window.Center.X-150,Window.Height/6,300,60,rgb(81, 50, 109));
  playButton:=new RectangleWPF(Window.Center.X-100,(Window.Height/6)*3,200,50,rgb(81, 50, 109));
  exitButton:=new RectangleWPF(Window.Center.X-100,(Window.Height/6)*4,200,50,rgb(81, 50, 109));
  name.Text:='Кладоискатель';
  name.FontColor:=rgb(255,255,255);
  playButton.Text:='Играть';
  playButton.FontColor:=rgb(255,255,255);
  exitButton.Text:='Выход';
  exitButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= MouseDown;
end;
end.