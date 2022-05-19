uses {render, }logic, defines, {unmenu,} WPFObjects, GraphWPF;
var fon:ObjectWPF;
var name:ObjectWPF;
var questButton:ObjectWPF;
var manualButton:ObjectWPF;
var playButton:ObjectWPF;
var exitButton:ObjectWPF;
var state:string;
var newstate:string;
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
  var menuButton:ObjectWPF:=new RectangleWPF(Window.Center.X-50,Window.Center.Y+25,100,25,rgb(81, 50, 109));
  menuButton.Text:='назад';
  menuButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= procedure(x,y:real;b:integer) -> if (menuButton.Center.X-50<x) and (menuButton.Center.X+50>x) and (menuButton.Center.Y-12<y) and (menuButton.Center.Y+12>y) then newstate:='menu';
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
       newstate:='game';
       state:='game';
      end;
    if (x > exitButton.Center.X - 100) and (x < exitButton.Center.X + 100) and (y > exitButton.Center.Y - 25) and (y < exitButton.Center.Y + 25)then
       Window.Close;
    if (x > questButton.Center.X - 100) and (x < questButton.Center.X + 100) and (y > questButton.Center.Y - 25) and (y < questButton.Center.Y + 25)then
       newstate:='ques';
    if (x > manualButton.Center.X - 100) and (x < manualButton.Center.X + 100) and (y > manualButton.Center.Y - 25) and (y < manualButton.Center.Y + 25)then
       newstate:='manu';
   end;
end;
procedure menu();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  name:=new RectangleWPF(Window.Center.X-150,Window.Height/6,300,60,rgb(81, 50, 109));
  questButton:=new RectangleWPF(Window.Center.X-100,(Window.Height/7)*3,200,50,rgb(81, 50, 109));
  manualButton:=new RectangleWPF(Window.Center.X-100,(Window.Height/7)*4,200,50,rgb(81, 50, 109));
  playButton:=new RectangleWPF(Window.Center.X-100,(Window.Height/7)*5,200,50,rgb(81, 50, 109));
  exitButton:=new RectangleWPF(Window.Center.X-100,(Window.Height/7)*6,200,50,rgb(81, 50, 109));
  
  name.Text:='Кладоискатель';
  name.FontColor:=rgb(255,255,255);
  questButton.Text:='Задание';
  questButton.FontColor:=rgb(255,255,255);
  manualButton.Text:='Руководство';
  manualButton.FontColor:=rgb(255,255,255);
  playButton.Text:='Играть';
  playButton.FontColor:=rgb(255,255,255);
  exitButton.Text:='Выход';
  exitButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= MouseDown;
end;
procedure manual();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  fon.Text:='ну типа эээ карочи клацаешь та на стрелочки, вот, enjoy';
  fon.FontColor:=rgb(255,255,255);
  var menuButton:ObjectWPF:=new RectangleWPF(Window.Width-100,0,100,25,rgb(81, 50, 109));
  menuButton.Text:='назад';
  menuButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= procedure(x,y:real;b:integer) -> if (menuButton.Center.X-50<x) and (menuButton.Center.X+50>x) and (menuButton.Center.Y-12<y) and (menuButton.Center.Y+12>y) then newstate:='menu';
end;
procedure quest();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  fon.Text:='ну курсач запилить блин';
  fon.FontColor:=rgb(255,255,255);
  var menuButton:ObjectWPF:=new RectangleWPF(Window.Width-100,0,100,25,rgb(81, 50, 109));
  menuButton.Text:='назад';
  menuButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= procedure(x,y:real;b:integer) -> if (menuButton.Center.X-50<x) and (menuButton.Center.X+50>x) and (menuButton.Center.Y-12<y) and (menuButton.Center.Y+12>y) then newstate:='menu';
end;
begin
    window.Maximize;
    newstate:='menu';
    //init;
    //меню
   { menu;
    init();//инициализация
    //события
    BeginFrameBasedAnimation(game,60);}
    while True do
    begin
      if newstate<>state then
      begin
        if newstate='menu' then 
        begin
          state:='menu';
          menu();
        end
        else if newstate='manu' then
        begin
          state:='manu';
          manual();
        end
        else if newstate='ques' then
        begin
          state:='ques';
          quest();
        end
      end;
    //  else if state='manu' then

      //else if state='ques' then
    end;
    
end.