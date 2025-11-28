unit RoleBar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Layouts, FMX.Ani, FMX.Controls.Presentation, FMX.Menus, FMX.Edit,
  WalkFunctions,
  Winapi.Windows, Winapi.Messages, Vcl.Dialogs, System.Generics.Collections;

type
  TProgresEvent = procedure (Sender: TObject; var progres: integer)of object;

  TRole = class
    RoleName: AnsiString;
    RoleMenuName: string;
    lytButton: TLayout;
  end;

  TRoleButton = class
    lytButton: TLayout;
    rctButton: TRectangle;
    rctNote: TRectangle;
    rctProgres: TRectangle;

    rank: Integer;
    menu: TMenuItem;
  end;

  TRoleSubButton = class(TRoleButton)

  end;

  LstRoleButtons = TList<TRoleButton>;

  //TRoleNewItem = class(TCollectionItem)
//  private
//    FRoleNote: string;
//    FBmpIndex: Integer;
//    FMainButtons: TRoleButtonCollection;
//    procedure SetRoleNote(const Value: string);
//  protected
//    function GetDisplayName: string; override;
//  public
//    FPanel: TPanelRoles;
//    FRolButt: TRoleButton;
//    constructor Create(Collection: TCollection); override;
//    destructor Destroy; override;
//  published
//    property Panel: TPanelRoles read FPanel write SetPanel;
//    property RoleNote: string read FRoleNote write SetRoleNote;
//    property Bmp32List: TIcon32List read FBmp32List write SetBmp32List;
//    property BmpIndex: Integer read FBmpIndex write setBmpIndex;
//    property MainButtons: TRoleButtonCollection read FMainButtons write SetMainButtons;
//
//  end;
//
//  TRoleCollection = class(TCollection)
//  private
//    FOwner: TPersistent;
//    FActivePanel: TPanelRoles;
//    function  GetItem(Index: Integer): TRoleItem;
//    procedure SetItem(Index: Integer; Value: TRoleItem);
//    procedure SetActivePanel(const Value: TPanelRoles);
//  protected
//    function  GetOwner: TPersistent; override;
//  public
//    FPanelViewer: TPanelViewRoles;
//    constructor Create(AOwner: TPersistent);
//    function Add: TRoleItem;
//    property Items[Index: Integer]: TRoleItem read GetItem write SetItem; default;
//    property ActivePanel: TPanelRoles read FActivePanel write SetActivePanel;
//  end;

  TfrmRoleBar = class(TForm)
    lytRoleBar: TLayout;
    stylbk1: TStyleBook;
    anim1: TFloatAnimation;
    anim2: TFloatAnimation;
    rct2: TRectangle;
    lytMainButton: TLayout;
    lytButton: TLayout;
    rctNzisBTN: TRectangle;
    animNzisButton: TFloatAnimation;
    animBtnNzisStroke: TFloatAnimation;
    rctDescription: TRectangle;
    lytPading: TLayout;
    lytMainRole: TLayout;
    rctDeskr: TRectangle;
    rctButton: TRectangle;
    FloatAnimation2: TFloatAnimation;
    rctProgres: TRectangle;
    txtDescr: TText;
    Layout1: TLayout;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    procedure spl1Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure anim1Process(Sender: TObject);
    procedure lytRoleBarMouseEnter(Sender: TObject);
    procedure lytRoleBarMouseLeave(Sender: TObject);
    procedure rctButtonMouseEnter(Sender: TObject);
    procedure lytPadingMouseEnter(Sender: TObject);
    procedure lytButtonMouseLeave(Sender: TObject);
    procedure rctNzisBTNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lytRoleBarDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure lytRoleBarDragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FOnProgres: TProgresEvent;
    FWidthBarExpand: Integer;
    FWidthBarClosed: Integer;
    FOnBtnRoleClick: TNotifyEvent;
    //procedure DialogKey(var Msg: TWMKey); message CM_DIALOGKEY;
  public
    procedure FillRollBar;
    procedure FillRoleButtons;
    property WidthBarClosed: Integer read FWidthBarClosed write FWidthBarClosed;
    property WidthBarExpand: Integer read FWidthBarExpand write FWidthBarExpand;
    property OnProgres: TProgresEvent read FOnProgres write FOnProgres;


    property OnBtnRoleClick: TNotifyEvent read FOnBtnRoleClick write FOnBtnRoleClick;
  end;

var
  frmRoleBar: TfrmRoleBar;

implementation

uses
  TitleBar;

{$R *.fmx}

procedure TfrmRoleBar.anim1Process(Sender: TObject);
var
  w: Integer;
begin
  if Assigned(FOnProgres) then
  begin
    w := Round(lytRoleBar.Width);
    FOnProgres(Sender, w);
  end;
  //Caption := FloatToStr(lytRoleBar.Width);
end;

procedure TfrmRoleBar.FillRoleButtons;
begin

end;

procedure TfrmRoleBar.FillRollBar;
var
  h: Single;
begin
  lytRoleBar.Width := FWidthBarClosed;
  lytButton.Height := FWidthBarClosed - lytPading.Width;
  lytMainButton.RecalcSize;
  h := InnerChildrenRect(lytMainButton).Height ;
  lytMainButton.Height := h;
  anim1.StopValue := FWidthBarExpand;
  anim2.StopValue := FWidthBarClosed;
end;

procedure TfrmRoleBar.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  //
end;

procedure TfrmRoleBar.lytButtonMouseLeave(Sender: TObject);
begin
  if System.Types.PtInRect(lytRoleBar.BoundsRect, self.ScreenToClient(Screen.MousePos)) then
  begin

    //Caption := 'ddd';
  end
  else
  begin
    if anim2.Enabled then
    begin
      anim2.Start;
    end
    else
    begin
      anim2.Enabled := True;
    end;
    //Caption := 'nnn';
  end;
end;

procedure TfrmRoleBar.lytPadingMouseEnter(Sender: TObject);
begin
  if (GetKeyState(VK_CONTROL) >= 0) then
    Exit;
  if anim1.Enabled then
  begin
    anim1.Start;
  end
  else
  begin
    anim1.Enabled := True;
  end;
end;

procedure TfrmRoleBar.lytRoleBarDragDrop(Sender: TObject;
  const Data: TDragObject; const Point: TPointF);
begin
  //
end;

procedure TfrmRoleBar.lytRoleBarDragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  Operation := TDragOperation.Link;
end;

procedure TfrmRoleBar.lytRoleBarMouseEnter(Sender: TObject);
begin
  Exit;
  if anim1.Enabled then
  begin
    anim1.Start;
  end
  else
  begin
    anim1.Enabled := True;
  end;
end;

procedure TfrmRoleBar.lytRoleBarMouseLeave(Sender: TObject);
begin

  if (Sender <> nil) and (System.Types.PtInRect(lytRoleBar.BoundsRect, self.ScreenToClient(Screen.MousePos))) then
  begin
    //Caption := 'ddd';
  end
  else
  begin
    if anim2.Enabled then
    begin
      anim2.Start;
    end
    else
    begin
      anim2.Enabled := True;
    end;
    //Caption := 'nnn';
  end;
end;

procedure TfrmRoleBar.rctButtonMouseEnter(Sender: TObject);
begin
  //
end;

procedure TfrmRoleBar.rctNzisBTNMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if anim2.Enabled then
  begin
    anim2.Start;
  end
  else
  begin
    anim2.Enabled := True;
  end;
  if Assigned(FOnBtnRoleClick) then
    FOnBtnRoleClick(Sender);
end;

procedure TfrmRoleBar.spl1Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  //rctSplitterTop.Height := (ARect.Height - rctSpliterGrip.Height)/2 ;
  //rctSpliterBottom.Height := rctSplitterTop.Height;
end;

end.
