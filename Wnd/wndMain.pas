unit wndMain;

interface

uses
   Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
   System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls;

type
   TfrmMain = class(TForm)
      tray: TTrayIcon;
      mnuLeft: TPopupMenu;
      mnuRight: TPopupMenu;
      procedure FormCreate(Sender: TObject);
   private
      procedure BuildMenu;
      procedure MenuClick(Sender: TObject);
   public
end;

var
   frmMain: TfrmMain;
   Categories: TDictionary<string, TDictionary<string,string>>;

implementation

{$R *.dfm}

procedure TfrmMain.BuildMenu;
var
  ShellMenu, CatItem, SubItem: TMenuItem;
  CatName, ItemName, ShellCmd: string;
  CatDict: TDictionary<string,string>;
begin
   ShellMenu := TMenuItem.Create(mnuRight);
   ShellMenu.Caption := 'Shell Folders';
   mnuRight.Items.Add(ShellMenu);

  for CatName in Categories.Keys do
  begin
    CatItem := TMenuItem.Create(ShellMenu);
    CatItem.Caption := CatName;
    ShellMenu.Add(CatItem);

    CatDict := Categories[CatName];

    for ItemName in CatDict.Keys do
    begin
      ShellCmd := CatDict[ItemName];

      SubItem := TMenuItem.Create(CatItem);
      SubItem.Caption := ItemName;
      SubItem.Hint := ShellCmd;
      SubItem.OnClick := MenuClick;

      CatItem.Add(SubItem);
    end;
  end;
end;

procedure TfrmMain.MenuClick(Sender: TObject);
var
  Cmd: string;
begin
  Cmd := (Sender as TMenuItem).Hint;
  ShellExecute(0, 'open', 'explorer.exe', PChar(Cmd), nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   tray.Visible:=true;
   tray.PopupMenu:=mnuRight;

   Categories:=TDictionary<string, TDictionary<string,string>>.Create;

   var CurrentUser := TDictionary<string,string>.Create;
   CurrentUser.Add('Desktop', 'shell:Desktop');
   CurrentUser.Add('Documents', 'shell:Documents');
   CurrentUser.Add('Downloads', 'shell:Downloads');

   var PublicUser := TDictionary<string,string>.Create;
   PublicUser.Add('Desktop', 'shell:Common Desktop');
   PublicUser.Add('Documents', 'shell:Common Documents');

   var WindowsCat := TDictionary<string,string>.Create;
   WindowsCat.Add('Fonts', 'shell:Fonts');

   Categories.Add('Current User', CurrentUser);
   Categories.Add('Public', PublicUser);
   Categories.Add('Windows', WindowsCat);

   BuildMenu;
end;

end.
