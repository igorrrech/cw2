unit defines;
uses WPFObjects;

var left, right, down, up:boolean;//логические переменные напрваления движения

var score:integer;
var background:Color;
var lvl:byte;
var o:List<integer>;//список для рандомизации направления
var counter:RectangleWPF;
//переменные игрока
const radPlayer = 20;
var colorPlayer:Color;
var player: CircleWPF;
//параметры точек
const radDot = 5;
const maxdots = 10;
var colorDot:Color;
//параметры охотников
const radHunters = 7;
const speedHunters = 4;
var colorHunter:Color;
//лист точек
var dots:List<ObjectWPF>;  
//лист охотников
var hunters:List<ObjectWPF>;
//задний фон
var backRect:RectangleWPF;
begin
 colorPlayer := rgb(203, 203, 23);
 colorDot := rgb(255,255,255);
 colorHunter := rgb(255,0,0);
 score:=0;
 lvl:=1;
 dots := new List<ObjectWPF>();
 background:=rgb(31, 0, 59);
 hunters:= new List<ObjectWPF>(); 
 o:=new List<integer>();
 o.Add(-1);
 o.Add(1);
end.