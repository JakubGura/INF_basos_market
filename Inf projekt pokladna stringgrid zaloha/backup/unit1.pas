unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ServiceManager, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Grids;

const maxpocet=20;
type
  zoznam=record
         nazov:String;
         kod,mnozstvo,cena:Integer;
         end;
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Edit8: TEdit;
    Image2: TImage;
    Image3: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    zoznamTovaru: TStringGrid;
    Timer1: TTimer;
    zoznamTovaru1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure zoznamTovaru1Click(Sender: TObject);
    procedure zoznamTovaruClick(Sender: TObject);

  private

  public

  end;

var
  polozka:array[1..8]of zoznam;
  ciselnetriedenia:array[1..8]of Integer;
  subor:textfile;
  triedene:Boolean;
  poradievt,cislopolozky,pocet,indexobjednavky:Integer;
  minobjednavka:String;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
  var l,y:Integer;
begin

  indexobjednavky:=1;
  Timer1.Enabled:=false;
  Image2.Picture.LoadfromFile('pozadie1.jpg');
  Image3.Picture.LoadfromFile('logo.png');

  Memo1.Clear;

  cislopolozky:=0;

  Assignfile(subor,'tovar.txt');
  Reset(subor);

  while not eof(subor) do
    begin
      inc(cislopolozky);
      Readln(subor,polozka[cislopolozky].nazov);
      Readln(subor,polozka[cislopolozky].cena);
      Readln(subor,polozka[cislopolozky].kod);
      Readln(subor,polozka[cislopolozky].mnozstvo);

    end;
  Closefile(subor);  //cim skor zavriet subor
    pocet:=cislopolozky;


 for l:=1 to pocet do
   ciselnetriedenia[l]:=l;    //beztriedenia,zakladny vypis

 Timer1.Enabled:=true;

    for y:=1 to pocet do
      begin
        zoznamTovaru.cells[0,y]:=InttoStr(polozka[y].kod);
        zoznamTovaru.cells[1,y]:=polozka[y].nazov;
        zoznamTovaru.cells[2,y]:=InttoStr(polozka[y].cena);
        zoznamTovaru.cells[3,y]:=InttoStr(polozka[y].mnozstvo);
      end;
    end;


procedure TForm1.Button1Click(Sender: TObject);
  var i:Integer;
begin
    {if  RadioButtonnazov.Checked =true then
    hladane:='nazov'
    else hladane:='kod';

 Memo1.Append(hladane);    }
  Timer1.Enabled:=false; //zastavenie updatovania zoznamu

  {cislopolozky:=0;
  if Edit1.Text='' then
  exit; }
  cislopolozky:=0;

  for i:=1 to pocet do
    begin
      if (Edit1.Text=polozka[i].nazov) or (Edit1.Text=InttoStr(polozka[i].kod))then
       cislopolozky:=i;
    end;

   if cislopolozky=0 then
    begin
    Showmessage('nezadal si správne,skús znova.');
    exit;
    end;

  { repeat
    inc(i);
   until
       Edit1.Text=InttoStr(polozka[i].kod);   }


  zoznamTovaru.cells[0,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].kod);
  zoznamTovaru.cells[1,1]:=polozka[cislopolozky].nazov;
  zoznamTovaru.cells[2,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].cena);
  zoznamTovaru.cells[3,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].mnozstvo);

  zoznamTovaru.Rowcount:=2;
 // if cislopolozky=1 then
end;

procedure TForm1.Button2Click(Sender: TObject);
  var i,j,l,pocetTriedenie,pomocna,najindex:Integer;
  triedenieCena:array[1..maxpocet]of Integer;
begin

   //if (zoznamTovaru.Col=3) and (zoznamTovaru.Row=1) then
    //begin

     for i:=1 to pocet do
       begin
         triedenieCena[i]:=i;
       end;



     for pocetTriedenie:= pocet downto 2 do
       begin
         najindex:=1;
         for j:=2 to pocetTriedenie do
           begin
             if polozka[triedenieCena[j]].cena>polozka[triedenieCena[najindex]].cena then
              begin
               najindex:=j;
              end;
             pomocna:=triedenieCena[pocetTriedenie];
             triedenieCena[pocetTriedenie]:=triedenieCena[najindex];
             triedenieCena[najindex]:=pomocna;
           end;
         end;

       for l:=1 to pocet do
        ciselnetriedenia[l]:=triedenieCena[l];   //triedenie podla ceny



    Timer1.Enabled:=true;

    //end;
end;

procedure TForm1.Button3Click(Sender: TObject);
   var i,j,l,pocetTriedenie,pomocna,najindex:Integer;
  triedenieKod:array[1..maxpocet]of Integer;
begin

  for i:=1 to pocet do
       begin
         triedenieKod[i]:=i;
       end;



     for pocetTriedenie:= pocet downto 2 do
       begin
         najindex:=1;
         for j:=2 to pocetTriedenie do
           begin
             if polozka[triedenieKod[j]].kod>polozka[triedenieKod[najindex]].kod then
              begin
               najindex:=j;
              end;
             pomocna:=triedenieKod[pocetTriedenie];
             triedenieKod[pocetTriedenie]:=triedenieKod[najindex];
             triedenieKod[najindex]:=pomocna;
           end;
         end;

       for l:=1 to pocet do
        ciselnetriedenia[l]:=triedenieKod[l];   //triedenie podla kodu

       Timer1.Enabled:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
  var i,j:Integer;
begin
  {if triedene=false then
     begin
       for j:=1 to pocet do
       polozka[ciselnetriedenia[j]]:=polozka[j];
     end
   else }
   //begin

  { if StrtoInt(Edit2.Text)>0 then
    begin
     polozka[ciselnetriedenia[1]].mnozstvo:=polozka[ciselnetriedenia[1]].mnozstvo+StrtoInt(Edit2.Text);
    end;

   if StrtoInt(Edit3.Text)>0 then
    begin
     polozka[ciselnetriedenia[2]].mnozstvo:=polozka[ciselnetriedenia[2]].mnozstvo+StrtoInt(Edit3.Text);
    end;

   if StrtoInt(Edit4.Text)>0 then
    begin
     polozka[ciselnetriedenia[3]].mnozstvo:=polozka[ciselnetriedenia[3]].mnozstvo+StrtoInt(Edit4.Text);
    end;

   if StrtoInt(Edit5.Text)>0 then
    begin
     polozka[ciselnetriedenia[4]].mnozstvo:=polozka[ciselnetriedenia[4]].mnozstvo+StrtoInt(Edit5.Text);
    end;

   if StrtoInt(Edit6.Text)>0 then
    begin
     polozka[ciselnetriedenia[5]].mnozstvo:=polozka[ciselnetriedenia[5]].mnozstvo+StrtoInt(Edit6.Text);
    end;

   if StrtoInt(Edit7.Text)>0 then
    begin
     polozka[ciselnetriedenia[6]].mnozstvo:=polozka[ciselnetriedenia[6]].mnozstvo+StrtoInt(Edit7.Text);
    end;

   end;

   triedene:=true;  }
 //nejde menit v subore,zapisovat
 { Assignfile(subor,'tovar.txt');
  Rewrite(subor);

  for i:=1 to pocet do
    begin
      Writeln(subor,polozka[i].nazov);
      Writeln(subor,polozka[i].cena);
      Writeln(subor,InttoStr(polozka[i].kod));
      Writeln(subor,InttoStr(polozka[i].mnozstvo));
    end;
  closeFile(subor);  }
end;

procedure TForm1.Button5Click(Sender: TObject);
  var j,l:Integer;
begin
   for l:=1 to pocet do
   ciselnetriedenia[l]:=l;

  zoznamTovaru.Rowcount:=pocet+1;

  Timer1.Enabled:=true;
 { Image1.Canvas.Fillrect(Clientrect);

      for j:=1 to pocet do
    begin
    Image1.Canvas.TextOut(50,30+35*j,InttoStr(polozka[j].kod));
    Image1.Canvas.TextOut(140,30+35*j,polozka[j].nazov);
    Image1.Canvas.TextOut(220,30+35*j,InttoStr(polozka[j].cena));
    Image1.Canvas.TextOut(320,30+35*j,InttoStr(polozka[j].mnozstvo));
    end;  }
end;

procedure TForm1.Button6Click(Sender: TObject);
  var i,j,l,pocetTriedenie,pomocna,najindex:Integer;
  triedenieMnozstvo:array[1..maxpocet]of Integer;
begin
      for i:=1 to pocet do
       begin
         triedenieMnozstvo[i]:=i;
       end;



     for pocetTriedenie:= pocet downto 2 do
       begin
         najindex:=1;
         for j:=2 to pocetTriedenie do
           begin
             if polozka[triedenieMnozstvo[j]].mnozstvo>polozka[triedenieMnozstvo[najindex]].mnozstvo then
              begin
               najindex:=j;
              end;
             pomocna:=triedenieMnozstvo[pocetTriedenie];
             triedenieMnozstvo[pocetTriedenie]:=triedenieMnozstvo[najindex];
             triedenieMnozstvo[najindex]:=pomocna;
           end;
         end;

       for l:=1 to pocet do
        ciselnetriedenia[l]:=triedenieMnozstvo[l];   //triedenie podla kodu

       Timer1.Enabled:=true;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
  var i,j,k,l,pocetTriedenie,pomocna,najindex:Integer;
  triedenieCena:array[1..maxpocet]of Integer;
begin
  Timer1.Enabled:=true;


 for i:=1 to pocet do
   begin
     triedenieCena[i]:=i;
   end;



 for pocetTriedenie:= pocet downto 2 do
   begin
     najindex:=1;
     for j:=2 to pocetTriedenie do
       begin
         if polozka[triedenieCena[j]].cena>polozka[triedenieCena[najindex]].cena then
          begin
           najindex:=j;
          end;
         pomocna:=triedenieCena[pocetTriedenie];
         triedenieCena[pocetTriedenie]:=triedenieCena[najindex];
         triedenieCena[najindex]:=pomocna;
       end;
     end;


    for l:=1 to pocet do
      ciselnetriedenia[l]:=triedenieCena[l];

    triedene:=true;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
  var i,y,minobjednavkacislo,error:Integer;
begin
  minobjednavka:=Edit8.Text;

  val(minobjednavka,minobjednavkacislo,error);

   if error=0 then
    begin
      for i:=1 to pocet do
        begin
        if  polozka[i].mnozstvo<minobjednavkacislo then
          begin
            polozka[i].mnozstvo:=20;
          end;
        end;
      end;

      for y:=1 to pocet do
      begin
      zoznamTovaru.cells[0,y]:=InttoStr(polozka[ciselnetriedenia[y]].kod);
      zoznamTovaru.cells[1,y]:=polozka[ciselnetriedenia[y]].nazov;
      zoznamTovaru.cells[2,y]:=InttoStr(polozka[ciselnetriedenia[y]].cena);
      zoznamTovaru.cells[3,y]:=InttoStr(polozka[ciselnetriedenia[y]].mnozstvo);
      end;




end;

procedure TForm1.zoznamTovaru1Click(Sender: TObject);

begin


end;

procedure TForm1.zoznamTovaruClick(Sender: TObject);
  var zadalNieco:Boolean;
      inputString:String;
begin
   zadalNieco:=inputQuery('objednaj '+(polozka[ciselnetriedenia[zoznamTovaru.Row]].nazov),'zadaj mnozstvo',inputString);

        if StrtoInt(inputString) > (polozka[ciselnetriedenia[zoznamTovaru.Row]].mnozstvo) then
         begin
         ShowMessage('Nemame dostatok tovaru na sklade');
         Exit;
         end;

        zoznamTovaru1.cells[0,indexobjednavky]:=InttoStr(polozka[ciselnetriedenia[zoznamTovaru.Row]].kod);
        zoznamTovaru1.cells[1,indexobjednavky]:=polozka[ciselnetriedenia[zoznamTovaru.Row]].nazov;
        zoznamTovaru1.cells[2,indexobjednavky]:=InttoStr(polozka[ciselnetriedenia[zoznamTovaru.Row]].cena);
        zoznamTovaru1.cells[3,indexobjednavky]:=inputString;

        polozka[ciselnetriedenia[zoznamTovaru.Row]].cena:= polozka[ciselnetriedenia[zoznamTovaru.Row]].mnozstvo - StrtoInt(inputString);
        //spravit objednavanie cez imputquars
end;


//test github, gitkraken inf basos market







end.

