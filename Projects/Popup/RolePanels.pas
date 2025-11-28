unit RolePanels;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Edit, FMX.Objects, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation,

  VirtualTrees, System.Generics.Collections, WalkFunctions;

type
  TExpanerRoleLabel = class
    Expander: TExpander;
    Lyt: TLayout;
    LytIn: TLayout;
    //constructor create;
    //destructor destroy; override;
  end;


  TfrmRolePanels = class(TForm)
    scrlbx1: TScrollBox;
    scldlyt1: TScaledLayout;
    btn1: TButton;
    rctBlanka: TRectangle;
    lytBlanka: TLayout;
    lytCollection: TLayout;
    expndrCollection: TExpander;
    lytExpIn: TLayout;
    lytEGN: TLayout;
    txtEGN: TText;
    edtEGN: TEdit;
    lytPatName: TLayout;
    txtPatName: TText;
    edtPatName: TEdit;
    stylbk1: TStyleBook;
    edtForCloning: TEdit;
    brshbjctCOT_contain: TBrushObject;
    txt1: TText;
    rctMenu: TRectangle;
    animPlanedTypeIcon: TFloatAnimation;
    rctCot1: TRectangle;
    FloatAnimation1: TFloatAnimation;
    rctCot2: TRectangle;
    FloatAnimation2: TFloatAnimation;
    rctCot3: TRectangle;
    FloatAnimation3: TFloatAnimation;
    rctCot4: TRectangle;
    FloatAnimation4: TFloatAnimation;
    rctCot5: TRectangle;
    FloatAnimation5: TFloatAnimation;
    rct2: TRectangle;
    anim1: TFloatAnimation;
    anim2: TFloatAnimation;
    anim3: TFloatAnimation;
    RectAnimation1: TRectAnimation;
    Rectangle1: TRectangle;
    FloatAnimation9: TFloatAnimation;
    lytIcon: TLayout;
    lytIconLeft: TLayout;
    Rectangle3: TRectangle;
    FloatAnimation6: TFloatAnimation;
    txt2: TText;
    txtDescr: TText;
    rctBorderDescr: TRectangle;
    procedure scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure expndrCollectionResize(Sender: TObject);
  private
    FScaleDyn: Single;
    lstExpanedrRole: TList<TExpanerRoleLabel>;
    procedure SetScaleDyn(const Value: Single);
    { Private declarations }
  public
    procedure AddExpanderRole(idxListExpander: Integer; RunNode: PVirtualNode);
    property scaleDyn: Single read FScaleDyn write SetScaleDyn;
  end;

var
  frmRolePanels: TfrmRolePanels;

implementation

{$R *.fmx}

{ TForm8 }

procedure TfrmRolePanels.AddExpanderRole(idxListExpander: Integer;
  RunNode: PVirtualNode);
var
  TempExpndrLyt, TempExpIn: TLayout;   ///TExpanerTableLabel;
  TempExpander: TExpander;
  i: integer;
  edt: TEdit;
  ArctCot1: TRectangle;
  h: Single;
begin
  if (lstExpanedrRole.Count - 1) < idxListExpander then
  begin
    TempExpndrLyt := TLayout(self.lytCollection.Clone(self));
    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    TempExpander.OnResize := expndrCollectionResize;
    TempExpIn := WalkChildrenLyt(TempExpander);

    //TempExpndrLyt.Width := flwlytVizitFor.Width ;
    //TempExpander.Text := 'Преглед';
    TempExpndrLyt.Margins.Left := 10;
    TempExpndrLyt.Margins.Right := 10;
    TempExpndrLyt.Tag := nativeint(RunNode);
   // LstExpanders.Add(TempExpndrLyt);
    //TempExpndrLyt := LstExpanders[idxListExpander];
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 10000);
    TempExpndrLyt.Parent := Self.lytBlanka;
    //TempExpndrLyt.OnResize := Expander1Resize;
  end
  else
  begin
//    TempExpndrLyt := LstExpanders[idxListExpander];
//    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);
//    TempExpndrLyt.Height := 61;
//    TempExpndrLyt.Parent := flwlytVizitFor;
//    TempExpndrLyt.Width := flwlytVizitFor.Width ;
//    TempExpndrLyt.Text := pr001Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Description));
//    TempExpndrLyt.Tag := nativeInt(RunNode);
//    TempExpndrLyt.OnResize := Expander1Resize;
//
  end;


  TempExpIn.RecalcSize;
  h := InnerChildrenRect(TempExpIn).Height / FScaleDyn ;
  TempExpndrLyt.Height := h + 75;
  if h = 0 then
  begin

    TempExpander.Height := 55;
  end
  else
  begin
    TempExpander.Height := h+ 45;
  end;
  TempExpIn.Height := TempExpander.Height;
  scldlyt1.Repaint;
end;

procedure TfrmRolePanels.btn1Click(Sender: TObject);
begin
  AddExpanderRole(0, nil);
end;

procedure TfrmRolePanels.expndrCollectionResize(Sender: TObject);
var
  h: Single;
  TempExpander: TExpander;
  TempExpIn, TempExpndrLyt: TLayout;
begin
  TempExpander := TExpander(Sender);
  TempExpndrLyt := TLayout(TempExpander.Parent);
  TempExpIn := WalkChildrenLytStyle(TempExpander, 'LytIn');
  //TempExpIn.Height := 10;
  if not TempExpander.IsExpanded then
  begin
    TempExpander.Height := 55;
    TempExpndrLyt.Height := 75;
  end
  else
  begin
    h := InnerChildrenRect(TempExpIn).Height / FScaleDyn ;
    TempExpander.Height := h+ 75;
    TempExpIn.Height := TempExpander.Height + 35;
    TempExpndrLyt.Height := h + 95;
  end;

end;

procedure TfrmRolePanels.FormCreate(Sender: TObject);
begin
  FScaleDyn := 1;
  edtForCloning.Visible := False;
  lstExpanedrRole := TList<TExpanerRoleLabel>.Create;
  //lstEditCot := TList<TEditCotLabel>.Create;
  lytCollection.Visible := False;
end;

procedure TfrmRolePanels.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstExpanedrRole);
end;

procedure TfrmRolePanels.scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;

begin
  if ssCtrl in Shift then
  begin
    tempH := scldlyt1.Height;
    if WheelDelta> 0 then
    begin
      tempH  := scldlyt1.Height * 1.1;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width * 1.1;
      scldlyt1.Height := scldlyt1.Height * 1.1;
    end
    else
    begin
      tempH  := scldlyt1.Height / 1.1;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width / 1.1;
      scldlyt1.Height := scldlyt1.Height / 1.1;
    end;
    Handled := True;
  end
  else
  begin
    if WheelDelta> 0 then
    begin
      scldlyt1.Position.Point :=  PointF(scldlyt1.Position.Point.x, scldlyt1.Position.Point.y + 20);
    end
    else
    begin
      scldlyt1.Position.Point :=  PointF(scldlyt1.Position.Point.x, scldlyt1.Position.Point.y - 20);
    end;
    Handled := True;

  end;

end;

procedure TfrmRolePanels.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

end.
