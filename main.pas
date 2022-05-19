uses {render, }logic, defines, {unmenu,} WPFObjects, GraphWPF;
var fon:ObjectWPF;
var name:ObjectWPF;
//кнопки
var questButton:ObjectWPF;
var manualButton:ObjectWPF;
var playButton:ObjectWPF;
var exitButton:ObjectWPF;
//состояния программы
var state:string;
var newstate:string;
//рейтинг
var rate:Text;
var str:string;
var bestScore:integer;
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
  if counter.Number > bestScore then
    begin
      Rewrite(rate);
      writeln(rate, counter.Number);
      close(rate);
      bestScore:=counter.Number;
    end;
  var n:RectangleWPF:= new RectangleWPF(Window.Center.X-200,Window.Center.Y-25,400,50,EmptyColor);
  n.Text:='Ваш счет: '+counter.Number+ ' Лучший счет: '+bestScore;
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
//инструкция
procedure manual();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  fon.Text:='Для перемещения используются клавиши "стрелки"'+#10+'В игре 10 уровней сложности'+#10+'Цель заключается в том чтобы набрать как можно больше очков'+#10+'за каждые 10 очков повышается уровень сложности'+#10+'Каждый охотник - красная точка что будет гнаться за тобой - считается за уровень сложности';
  fon.FontColor:=rgb(255,255,255);
  var menuButton:ObjectWPF:=new RectangleWPF(Window.Width-100,0,100,25,rgb(81, 50, 109));
  menuButton.Text:='назад';
  menuButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= procedure(x,y:real;b:integer) -> if (menuButton.Center.X-50<x) and (menuButton.Center.X+50>x) and (menuButton.Center.Y-12<y) and (menuButton.Center.Y+12>y) then newstate:='menu';
end;
//задание
procedure quest();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  fon.Text:='Задание 3.2. Искатель кладов'+#10+'На экране дисплея изображаются игровое поле и табло,'+#10+'фиксирующее количество набранных очков. На игровом поле'+#10+'случайным образом располагается определенное число "кладов",'+#10+'причем с течением времени их количество может увеличиваться.'+#10+'Задача играющего состоит в том, чтобы набрать наибольшее'+#10+'количество очков - "кладов". При этом за кладоискателем гонится'+#10+'разбойник, который движется быстрее кладоискателя, но выбор'+#10+'направления движения является случайным с некоторой степенью'+#10+'вероятности в сторону кладоискателя. Если собраны все клады, то'+#10+'происходит переход на более высокий уровень сложности игры'+#10+'(например, увеличивается число разбойников), если же кладоискатель'+#10+'пойман разбойником, то игра заканчивается, фиксируется набранное'+#10+'количество очков и определяется место играющего в таблице'+#10+'рекордов. Количество уровней должно быть не менее 10';
  fon.FontColor:=rgb(255,255,255);
  var menuButton:ObjectWPF:=new RectangleWPF(Window.Width-100,0,100,25,rgb(81, 50, 109));
  menuButton.Text:='назад';
  menuButton.FontColor:=rgb(255,255,255);
  OnMouseDown:= procedure(x,y:real;b:integer) -> if (menuButton.Center.X-50<x) and (menuButton.Center.X+50>x) and (menuButton.Center.Y-12<y) and (menuButton.Center.Y+12>y) then newstate:='menu';
end;
//заставка
procedure cutscene();
begin
  fon:=new RectangleWPF(0,0,Window.Width,Window.Height,rgb(31, 0, 59));
  var hatObj:=new RectangleWPF(Window.Center.X-350,0,700,100,rgb(31, 0, 59));
  hatObj.Text:=hat; hatObj.FontColor:=rgb(255,255,255);
  var courseObj:=new RectangleWPF(Window.Center.X-300,150,600,80,rgb(31, 0, 59));
  courseObj.Text:='Курсовая по теме №3 "Игровые прорграммы"'+#10+'              Вариант №2 "Искатель кладов"'; courseObj.FontColor:=rgb(255,255,255);
  var stdObj:=new RectangleWPF(Window.Width-400,500,500,80,rgb(31, 0, 59));
  stdObj.Text:='Выполнил: студент группы 145'+#10+'Сурма М.В.'+#10+'Проверила: Москвитина О.А.';stdObj.FontColor:=rgb(255,255,255);
  var dataObj:=new RectangleWPF(Window.Center.X-100,Window.Height-80,200,80,rgb(31, 0, 59));
  dataObj.Text:='        Рязань 2022'+#10+'Подождите 10 секунд...';dataObj.FontColor:=rgb(255,255,255);
  sleep(10000);
end;
begin
    Assign(rate,'rate.txt');
    Reset(rate);
    while not EOF(rate) do
      readln(rate,str);
    bestScore:=StrToInt(str);
    close(rate);
 
    window.Maximize;
    cutscene();
    newstate:='menu';
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
    end;
    
end.