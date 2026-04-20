program QuickLauncher;

uses
  Vcl.Forms,
  wndMain in 'Wnd\wndMain.pas' {frmMain};

{$R *.res}

begin
   Application.Initialize;
   Application.CreateForm(TfrmMain, frmMain);
   Application.MainFormOnTaskbar := False;
   Application.ShowMainForm := False;
   Application.Run;
end.
