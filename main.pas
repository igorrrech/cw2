uses {render, }logic, defines, {unmenu,} WPFObjects, GraphWPF;
var fon:ObjectWPF;
var name:ObjectWPF;
var playButton:ObjectWPF;
var exitButton:ObjectWPF;

//завершение игры
procedure _end();
begin
  EndFrameBasedAnimation();
  foreach var h:ObjectWPF in hunters do
    h.Destroy;
  foreach var d:ObjectWPF in dots do
    d.Destroy;
  player.Visible:=false;
  counter.Visible:=false;
  var n:RectangleWPF:= new RectangleWPF(Window.Center.X-150,Window.Center.Y-25,300,50,EmptyColor);
  n.Text:='Счет: '+counter.Number;
  n.FontColor:=counter.FontColor;
  //DrawText(Window.Width/2-25,Window.Height/2-150,300,50,'Счет: '+counter.Number);
  sleep(500);
end;
//процедура игры
procedure game();
begin   
         if (score > 10*lvl) and (lvl<10)then 
         begin
           //counter.Number:=counter.Number+1;
           makeHunter();
           lvl:=lvl+1;
         end;
         if dots.Count < maxdots then
            makeDot();
         //удалить все точки пересекающиеся с игроком
         dots.RemoveAll(_destroyDots);
         movePlayer();
         moveHunters();
         foreach var h:ObjectWPF in hunters do
           if ObjectsIntersect(h,player) then
             _end();
         
end;
//инициализация
procedure init();
begin
    backRect:=new RectangleWPF(0,0,Window.Width,Window.Height,background);
    //счетчик очков
    counter:=new RectangleWPF(0,0,40,120,EmptyColor);
    counter.Number:=0;
    counter.Visible:=true;
    counter.FontColor:=rgb(255,255,255);
    //инициализация игрока
    player := new CircleWPF(100,100,radPlayer,colorPlayer);
    player.Direction:=(0,0);
    player.Visible:=true;
    OnKeyDown:=KeyDown;
    OnKeyUp:=KeyUp;
end;

procedure MouseDown(x,y:real;mousebut:integer);
begin
  if mousebut=1 then
    begin
    if (x > playButton.Center.X - 100) and (x < playButton.Center.X + 100) and (y > playButton.Center.Y - 25) and (y < playButton.Center.Y + 25)then
      begin
       OnMouseDown:=nil;
       init();
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
begin
    window.Maximize;
    menu;
    //init;
    //меню
   { menu;
    init();//инициализация
    //события
    BeginFrameBasedAnimation(game,60);}
    
end.