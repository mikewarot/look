unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  ComCtrls, ExtCtrls, ExtendedTabControls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    OpenDialog1: TOpenDialog;
    Separator1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ExtendedTabToolbar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  BinaryData : String;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
var
  filename : string;
  f : file of byte;
  fsize,
  size     : int64;
begin
  If OpenDialog1.Execute then begin
//    Memo1.Clear;
    For filename in OpenDialog1.Files do begin
      Memo1.Append('File: '+filename);
      BinaryData := '';
      AssignFile(f,filename);
      Reset(f);
      fsize := FileSize(f);
      SetLength(BinaryData,fSize);
      BlockRead(F,BinaryData[1],fsize,size);
      If Size <> fSize then begin
        Memo1.Append('Something Went Wrong!');
        CloseFile(f);
        Exit;
      end;
      CloseFile(f);
      Memo1.Append(size.ToString + ' bytes read');
    end;
    Memo1.Append('--- EOF ---');
  end;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.ExtendedTabToolbar1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BinaryData := 'HELLO WORLD!';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.Append(BinaryData);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  offset : Int64;
  i : Int64;
  s : string;
  c : char;
begin
  Memo1.Clear;
  Offset := 0;
  repeat
    s := Offset.ToHexString(8)+': ';
    for i := 0 to 7 do
      s := s + Ord(BinaryData[offset+i+1]).ToHexString(2) + ' ';
    s := s + '- ';
    for i := 8 to 15 do
      s := s + Ord(BinaryData[offset+i+1]).ToHexString(2) + ' ';

    for i := 0 to 7 do begin
      c := BinaryData[offset+i+1];
      case c of ' '..#126 : ;
        else
          c := '.';
      end;
      s := s + c;
    end;
    s := s + '_';
    for i := 8 to 15 do begin
      c := BinaryData[offset+i+1];
      case c of ' '..#126 : ;
        else
          c := '.';
      end;
      s := s + c;
    end;

    Memo1.Append(s);
    inc(offset,16);
  until offset >= Length(BinaryData);

end;

end.

