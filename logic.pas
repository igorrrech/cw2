unit logic;
interface
uses WPFObjects,defines;

procedure KeyDown(k:key);
procedure KeyUp(k: key);
procedure movePlayer();
function _destroyDots(dot:ObjectWPF):boolean;
procedure makeDot();
procedure makeHunter();
procedure moveHunters();

implementation
//скрытая функция перемещения охотника
procedure _moveHunter(h:ObjectWPF);
begin
  if Player.Center.X > h.Center.X then
    h.Dx:=speedHunters
  else
    h.Dx:=-speedHunters;
  if Player.Center.Y < h.Center.Y then
    h.Dy:=-speedHunters
  else
    h.Dy:=speedHunters;
  if h.Center.X>Window.Width then
           h.Dx:=-10
         else if h.Center.X<0 then
           h.Dx:=10;
         
         if h.Center.Y>Window.Height then
           h.Dy:=-10
         else if h.Center.Y<0 then
           h.Dy:=10;
  h.Move;
end;
//функция раставляет флаги движения игрока при нажатии клавиши
procedure KeyDown(k:key);
begin
  case k.ToString of
    'Left': 
    begin
      left:=true; right:=false;
    end;
  'Right': 
    begin
      left:=false; right:=true;
    end;
    'Up': 
    begin
      up:=true; down:=false;
    end;
    'Down': 
    begin
      up:=false; down:=true;
    end;
  end;
end;
//функция раставляет флаги движения игрока при отжатии
procedure KeyUp(k: key);
begin
  case k.ToString of
    'Left': left := false;
    'Right': right := false;
    'Up': up := false;
    'Down': down := false;
  end;
end;
//функция задающая вектор движения игрока
procedure movePlayer();
begin
  if left then player.Dx:= -7
  else if right then player.Dx:= 7
  else player.Dx:=0;
  
  if down then player.Dy:= 7
  else if up then player.Dy:= -7
  else player.Dy:=0;
  if player.Center.X>Window.Width then
           player.Dx:=-10
         else if player.Center.X<0 then
           player.Dx:=10;
         
         if player.Center.Y>Window.Height then
           player.Dy:=-10
         else if player.Center.Y<0 then
           player.Dy:=10;
  {if (player.Center.X = Window.Width) or (player.Center.X = 0) then
    player.Dx:=0;
  if (player.Center.Y = Window.Height) or (player.Center.Y = 0) then
    player.Dy:=0;}
  player.Move;
end;
//функция уничтожающая точки и подсчиттывания очков
function _destroyDots(dot:ObjectWPF):boolean;
begin
  var col:boolean:=ObjectsIntersect(dot,player);
  if col then
    begin
      score:=score+1;
      dot.Destroy;
    end;
  counter.Number:=score;
  result:=col;
end;
//функция создания точки в произвольном месте экрана
procedure makeDot();
begin
  if dots.Count < maxdots then
    dots.Add(new CircleWPF(RandomPoint(radDot),radDot,colorDot));
end;
//функция создания охотника
procedure makeHunter();
begin
  var hunter:CircleWPF:=new CircleWPF(RandomPoint(),radHunters,colorHunter);
  hunter.Direction:=(0,0);
  if abs(hunter.Center.X - player.Center.X)< 50 then
    hunter.Center.X:=hunter.Center.X+abs(hunter.Center.X - player.Center.X);
  if abs(hunter.Center.Y - player.Center.Y)< 50 then
    hunter.Center.Y:=hunter.Center.Y+abs(hunter.Center.Y - player.Center.Y);
  hunters.Add(hunter);
  //hunter.Destroy;
  //hunters[hunter.FindLastIndex()].Direction:=(0,0);
end;
//функция перемещения охотников
procedure moveHunters();
begin
  foreach var h:ObjectWPF in hunters do
  begin
    if Random(100)<=70 then
      _moveHunter(h)
    else
      begin
        h.Dx:=(o[Random(0,1)])*speedHunters*3;
        h.Dy:=(o[Random(0,1)])*speedHunters*3;
        h.Move;
      end;
  end;
end;
end.