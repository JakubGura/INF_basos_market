unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ServiceManager, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Grids;

const maxpocet=100;

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
    Edit2: TEdit;
    Edit8: TEdit;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Timer2: TTimer;
    zoznamTovaru: TStringGrid;
    Timer1: TTimer;
    zoznamTovaru1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit8Click(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure zoznamTovaru1Click(Sender: TObject);
    procedure zoznamTovaruButtonClick(Sender: TObject; aCol, aRow: Integer);
    procedure zoznamTovaruClick(Sender: TObject);

  private

  public

  end;

var
  polozka:array[1..100]of zoznam;
  ciselnetriedenia:array[1..100]of Integer;
  subor:textfile;
  triedene,hladane:Boolean;
  path,odpad:String;
  poradievt,cislopolozky,pocet,indexobjednavky,pocetobjednanych,cenanakupu,mnozstvopridaneho,cenapridaneho:Integer;
  skladverziaaktualna,skladverzia:Integer;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
  var l,y:Integer;
      tovar:String;
begin
  cenanakupu:=0;
  pocetobjednanych:=1;
  indexobjednavky:=0;
  Timer1.Enabled:=false;
  Timer2.Enabled:=false;
  skladverziaaktualna:=1;
  skladverzia:=1;

  //path:='Z:\INFProjekt2019\TimA\';
  path:='';

  //Image2.Picture.LoadfromFile('pozadie1.jpg');   zbytocne
  Image3.Picture.LoadfromFile('logo.bmp');


  {cislopolozky:=0;

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
  Closefile(subor);  //cim skor zavriet subor }

    Assignfile(subor,path+'TOVAR.txt');
    Reset(subor);
    cislopolozky:=0;
    Readln(subor,odpad);
   while not eof(subor) do
     begin
       inc(cislopolozky);
       Readln(subor,tovar);
       polozka[cislopolozky].kod:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
       polozka[cislopolozky].nazov:=copy(tovar,pos(';',tovar)+1,length(tovar));
     end;
   Closefile(subor);

   Assignfile(subor,path+'CENNIK.txt');
   Reset(subor);
     cislopolozky:=0;
     Readln(subor,odpad);
    while not eof(subor) do
      begin
        inc(cislopolozky);
        Readln(subor,tovar);
        polozka[cislopolozky].kod:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
        delete(tovar,1,pos(';',tovar));
        polozka[cislopolozky].cena:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
      end;
    Closefile(subor);

      Assignfile(subor,path+'SKLAD.txt');
  Reset(subor);
    cislopolozky:=0;
    Readln(subor,odpad);
   while not eof(subor) do
     begin
       inc(cislopolozky);
       Readln(subor,tovar);
       polozka[cislopolozky].kod:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
       polozka[cislopolozky].mnozstvo:=StrtoInt(copy(tovar,pos(';',tovar)+1,length(tovar)));
     end;
   Closefile(subor);

    pocet:=cislopolozky;


 for l:=1 to pocet do
   ciselnetriedenia[l]:=l;    //beztriedenia,zakladny vypis

 Timer1.Enabled:=true;
 zoznamTovaru.Rowcount:=pocet+1;
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


  {cislopolozky:=0;
  if Edit1.Text='' then
  exit; }
  cislopolozky:=0;

  for i:=1 to pocet do
    begin
      if (Edit1.Text=polozka[ciselnetriedenia[i]].nazov) or (Edit1.Text=InttoStr(polozka[ciselnetriedenia[i]].kod))then
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
  zoznamTovaru.cells[1,1]:=polozka[ciselnetriedenia[cislopolozky]].nazov;
  zoznamTovaru.cells[2,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].cena);
  zoznamTovaru.cells[3,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].mnozstvo);


  zoznamTovaru.Rowcount:=2;
  hladane:=true;

  Timer1.Enabled:=true;
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
       hladane:=false;
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
  Label3.Caption:=('spolu cela objednavka: 0 centov' );

  cenanakupu:=0;
  pocetobjednanych:=1;
  indexobjednavky:=0;
  zoznamTovaru1.Rowcount:=1;

end;

procedure TForm1.Button5Click(Sender: TObject);
  var j,l:Integer;
begin
  triedene:=false;
  hladane:=false;

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

procedure TForm1.Edit1Click(Sender: TObject);
begin
  Edit1.Clear;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
   Edit1.Text:='zadaj nazov alebo kod';
end;

procedure TForm1.Edit2Click(Sender: TObject);
begin
   Edit2.Clear;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
begin
  if Edit2.Text='' then
    Edit2.Text:='zadaj mnozstvo';
end;



procedure TForm1.Edit8Click(Sender: TObject);
begin
   Edit8.Clear;
end;

procedure TForm1.Edit8Exit(Sender: TObject);
begin
  if Edit8.Text='' then
  Edit8.Text:='zadaj mnozstvo';
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
  var i,y,minobjednavkacislo,mnozstvoobjednavkycislo,error1,error2:Integer;
      mnozstvoobjednavky,minobjednavka:String;
begin
  minobjednavka:=Edit8.Text;
  mnozstvoobjednavky:= Edit2.Text;

  val(minobjednavka,minobjednavkacislo,error1);
  val(mnozstvoobjednavky,mnozstvoobjednavkycislo,error2);


   if (error1=0) and (error2=0) then
    begin
      for i:=1 to pocet do
        begin
        if  polozka[i].mnozstvo<minobjednavkacislo then
          begin
            polozka[i].mnozstvo:=StrtoInt(mnozstvoobjednavky);
          end;
        end;
      end;

       if hladane=true then
       begin
         zoznamTovaru.cells[0,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].kod);
         zoznamTovaru.cells[1,1]:=polozka[ciselnetriedenia[cislopolozky]].nazov;
         zoznamTovaru.cells[2,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].cena);
         zoznamTovaru.cells[3,1]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].mnozstvo);
         exit;
       end;

      for y:=1 to pocet do
      begin
      zoznamTovaru.cells[0,y]:=InttoStr(polozka[ciselnetriedenia[y]].kod);
      zoznamTovaru.cells[1,y]:=polozka[ciselnetriedenia[y]].nazov;
      zoznamTovaru.cells[2,y]:=InttoStr(polozka[ciselnetriedenia[y]].cena);
      zoznamTovaru.cells[3,y]:=InttoStr(polozka[ciselnetriedenia[y]].mnozstvo);
      end;






end;

procedure TForm1.Timer2Timer(Sender: TObject);
  var k:Integer;
begin

  {Assignfile(subor,'TOVAR..txt');
  Reset(subor);

   while not eof(subor) do
     begin
     Readln(subor,tovar);
     polozka[cislopolozky].kod:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
     polozka[cislopolozky].nazov:=copy(tovar,pos(';',tovar)+1,length(tovar));
     Memo1.Append(InttoStr(polozka[cislopolozky].kod)+(polozka[cislopolozky].nazov));
     end;
   Closefile(subor);

   Assignfile(subor,'CENNIK..txt');
   Reset(subor);

    while not eof(subor) do
      begin
      Readln(subor,tovar);
      polozka[cislopolozky].kod:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
      delete(tovar,1,pos(';',tovar));
      polozka[cislopolozky].cena:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
      Memo1.Append(InttoStr(polozka[cislopolozky].kod)+InttoStr((polozka[cislopolozky].cena)));
      end;
    Closefile(subor);

      Assignfile(subor,'SKLAD..txt');
  Reset(subor);

   while not eof(subor) do
     begin
     Readln(subor,tovar);
     polozka[cislopolozky].kod:=StrtoInt(copy(tovar,1,pos(';',tovar)-1));
     polozka[cislopolozky].mnozstvo:=StrtoInt(copy(tovar,pos(';',tovar)+1,length(tovar)));
     Memo1.Append(InttoStr(polozka[cislopolozky].kod)+InttoStr(polozka[cislopolozky].mnozstvo));
     end;
   Closefile(subor);

   Timer2.Enabled:=false; }
   if skladverzia<skladverziaaktualna then
    begin
      Assignfile(subor,path+'SKLAD.txt');
      Rewrite(subor);

      Writeln(subor,odpad[1]);
      for k:=1 to pocet do
        begin
         Writeln(subor,InttoStr(polozka[k].kod)+';'+InttoStr(polozka[k].mnozstvo));
        end;
    Closefile(subor);
    skladverzia:=skladverziaaktualna;
    end;
end;

procedure TForm1.zoznamTovaru1Click(Sender: TObject);

begin


end;

procedure TForm1.zoznamTovaruButtonClick(Sender: TObject; aCol, aRow: Integer);
  var i,j,l,pocetTriedenie,pomocna,najindex:Integer;
  triedenieMnozstvo:array[1..maxpocet]of Integer;
begin

  { if zoznamTovaru.Col=3 then              //nefunguje triedenie na klik
    begin
      for i:=1 to pocet do
       begin
         triedenieMnozstvo[i]:=i;
       end;   }



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


procedure TForm1.zoznamTovaruClick(Sender: TObject);
  var zadalNieco:Boolean;
      inputStringcislo,error,i,doobjednanemnozstvo,objednanemnozstvo:Integer;
      inputString:String;
begin

   if  hladane= false then
     cislopolozky:=zoznamTovaru.Row;

   zadalNieco:=inputQuery('objednaj '+(polozka[ciselnetriedenia[cislopolozky]].nazov),'zadaj mnozstvo',inputString);

      {  if StrtoInt(inputString) > (polozka[ciselnetriedenia[cislopolozky]].mnozstvo) then
         begin
         ShowMessage('Nemame dostatok tovaru na sklade');
         Exit;
         end;}
   val(inputString,inputStringcislo,error);

   if (inputString='') then
      begin
       exit;
      end;

   if (error=1) then
    begin
    Showmessage('nezadal si spravne mnozstvo');
    exit;
    end;



    for i:=1 to pocetobjednanych-1 do
      begin
       doobjednanemnozstvo:=StrtoInt(inputString);
       objednanemnozstvo:= StrtoInt(zoznamTovaru1.cells[3,i]);
       if zoznamTovaru1.cells[0,i]=InttoStr(polozka[ciselnetriedenia[cislopolozky]].kod) then
          begin
          zoznamTovaru1.cells[3,i]:=InttoStr(objednanemnozstvo + doobjednanemnozstvo);
          polozka[ciselnetriedenia[cislopolozky]].mnozstvo:= polozka[ciselnetriedenia[cislopolozky]].mnozstvo + StrtoInt(inputString);
          mnozstvopridaneho:=StrtoInt(InputString);
          cenapridaneho:=polozka[ciselnetriedenia[cislopolozky]].cena;
          cenanakupu:=cenanakupu+(cenapridaneho*mnozstvopridaneho);
          Label3.Caption:=('spolu cela objednavka: '+ InttoStr(cenanakupu)+' centov');
          end;



       if zoznamTovaru1.cells[0,i]=InttoStr(polozka[ciselnetriedenia[cislopolozky]].kod) then
        exit;
        end;
        inc(indexobjednavky);
        inc(pocetobjednanych);
        zoznamTovaru1.Rowcount:=pocetobjednanych;

        zoznamTovaru1.cells[0,indexobjednavky]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].kod);
        zoznamTovaru1.cells[1,indexobjednavky]:=polozka[ciselnetriedenia[cislopolozky]].nazov;
        zoznamTovaru1.cells[2,indexobjednavky]:=InttoStr(polozka[ciselnetriedenia[cislopolozky]].cena);
        zoznamTovaru1.cells[3,indexobjednavky]:=inputString;

        mnozstvopridaneho:=StrtoInt(zoznamTovaru1.cells[3,indexobjednavky]);
        cenapridaneho:=polozka[ciselnetriedenia[cislopolozky]].cena;
        cenanakupu:=cenanakupu+(cenapridaneho*mnozstvopridaneho);

        polozka[ciselnetriedenia[cislopolozky]].mnozstvo:= polozka[ciselnetriedenia[cislopolozky]].mnozstvo + StrtoInt(inputString);
        //spravit objednavanie cez imputquars
//
       Label3.Caption:=('spolu cela objednavka: '+ InttoStr(cenanakupu)+' centov');
       inc(skladverziaaktualna);
       Timer2.Enabled:=true;

end;


//test github, gitkraken inf basos market







end.

