unit FmxControls;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Ani, FMX.Layouts, FMX.Objects, FMX.ListBox,
  WalkFunctions,
  Aspects.Collections,
  RealObj.RealHipp,
  Table.Diagnosis,

  ADB_DataUnit, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls
  ;

type
  TfrmFmxControls = class(TForm)
    stylbk1: TStyleBook;
    lbDiagVerifStatus: TListBox;
    lstVerifStatusCL078_10: TListBoxItem;
    Rectangle1: TRectangle;
    lstVerifStatusCl078_20: TListBoxItem;
    Rectangle2: TRectangle;
    ListBoxItem1: TListBoxItem;
    Rectangle3: TRectangle;
    ListBoxItem2: TListBoxItem;
    Rectangle4: TRectangle;
    ListBoxItem3: TListBoxItem;
    Rectangle5: TRectangle;
    ListBoxItem4: TListBoxItem;
    Rectangle6: TRectangle;
    Layout1: TLayout;
    Rectangle7: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    ShadowEffect1: TShadowEffect;
    lbDiagClinicStatus: TListBox;
    ListBoxItem5: TListBoxItem;
    Rectangle8: TRectangle;
    ListBoxItem6: TListBoxItem;
    Rectangle9: TRectangle;
    ListBoxItem7: TListBoxItem;
    Rectangle10: TRectangle;
    ListBoxItem8: TListBoxItem;
    Rectangle11: TRectangle;
    ListBoxItem9: TListBoxItem;
    Rectangle12: TRectangle;
    ListBoxItem10: TListBoxItem;
    Rectangle13: TRectangle;
    Layout2: TLayout;
    Rectangle14: TRectangle;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    FloatAnimation6: TFloatAnimation;
    ShadowEffect2: TShadowEffect;
    pDiagClinicStatus: TPopup;
    pDiagVerifStatus: TPopup;
    animAnswPat: TFloatAnimation;
    FloatAnimation7: TFloatAnimation;
    lytMdn: TLayout;
    rctTestMdn: TRectangle;
    GridLayout1: TGridLayout;
    edtMdn1: TEdit;
    edtMdn2: TEdit;
    edtMdn3: TEdit;
    edtMdn4: TEdit;
    edtMdn5: TEdit;
    edtMdn6: TEdit;
    lytMdnLeft: TLayout;
    edtMdn: TEdit;
    Rectangle15: TRectangle;
    FloatAnimation8: TFloatAnimation;
    edtMainMkbMDN: TEdit;
    Rectangle16: TRectangle;
    FloatAnimation9: TFloatAnimation;
    Text1: TText;
    Edit1: TEdit;
    Rectangle17: TRectangle;
    FloatAnimation10: TFloatAnimation;
    Text2: TText;
    Edit2: TEdit;
    Rectangle18: TRectangle;
    FloatAnimation11: TFloatAnimation;
    lytEdit: TLayout;
    chkEditDyn: TCheckBox;
    rctIsNullEdit: TRectangle;
    Line1: TLine;
    edtCl132Sup: TEdit;
    txtErr: TText;
    anim4: TFloatAnimation;
    Rectangle19: TRectangle;
    txtUnit: TText;
    lytComboDyn: TLayout;
    chkComboDyn: TCheckBox;
    Rectangle20: TRectangle;
    Line2: TLine;
    cbb3: TComboBox;
    txtComboOne: TText;
    Layout3: TLayout;
    Rectangle21: TRectangle;
    lytMemo: TLayout;
    chkMemoDyn: TCheckBox;
    rctCheckDyn: TRectangle;
    mmoDyn: TMemo;
    linSaver: TLine;
    lytAnswMemo: TLayout;
    rctAnsw1: TRectangle;
    lytDate: TLayout;
    chkDateDyn: TCheckBox;
    rctIsNullDate: TRectangle;
    dtdtCl132: TDateEdit;
    Rectangle22: TRectangle;
    FloatAnimation12: TFloatAnimation;
    edtDateRaw: TEdit;
    lin1: TLine;
    Layout4: TLayout;
    Rectangle23: TRectangle;
    lytMultiCombo: TLayout;
    chkMultiComboDyn: TCheckBox;
    Rectangle24: TRectangle;
    Line3: TLine;
    rctMulti: TRectangle;
    flwlytMultiCombo: TFlowLayout;
    lytButtonCombo: TLayout;
    rctBtnMulti: TRectangle;
    FloatAnimation13: TFloatAnimation;
    Layout5: TLayout;
    Rectangle25: TRectangle;
    chkMemoDynOne: TCheckBox;
    Rectangle26: TRectangle;
    rctAnsw: TRectangle;
    btnMulti: TSpeedButton;
    lytDeleteMulti: TLayout;
    crcDelete: TCircle;
    txtDelBtnMulti: TText;
    fltnmtn1: TFloatAnimation;
    lbComboOne: TListBox;
    Layout6: TLayout;
    rctBtnSaveLst: TRectangle;
    FloatAnimation14: TFloatAnimation;
    FloatAnimation15: TFloatAnimation;
    rctBtnCancelLst: TRectangle;
    FloatAnimation16: TFloatAnimation;
    FloatAnimation17: TFloatAnimation;
    FloatAnimation18: TFloatAnimation;
    shdwfct1: TShadowEffect;
    expndrCL132: TExpander;
    Rectangle27: TRectangle;
    flwlyt2: TFlowLayout;
    edtCl132: TEdit;
    mmoCL132: TMemo;
    cbb2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure pDiagClinicStatusMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure lbDiagClinicStatusMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure ListBoxItemClick(Sender: TObject);
    procedure lbDiagClinicStatusChange(Sender: TObject);
  private
    FAdb_DM: TADBDataModule;
    { Private declarations }
  public
    property Adb_DM: TADBDataModule read FAdb_DM write FAdb_DM;
  end;

var
  frmFmxControls: TfrmFmxControls;

implementation

{$R *.fmx}

procedure TfrmFmxControls.FormCreate(Sender: TObject);
begin
  pDiagClinicStatus.BoundsRect := lbDiagClinicStatus.BoundsRect;
  lbDiagClinicStatus.Parent := pDiagClinicStatus;
  lbDiagClinicStatus.Align := TAlignLayout.Client;

  pDiagVerifStatus.BoundsRect := lbDiagVerifStatus.BoundsRect;
  lbDiagVerifStatus.Parent := pDiagVerifStatus;
  lbDiagVerifStatus.Align := TAlignLayout.Client;
end;

procedure TfrmFmxControls.lbDiagClinicStatusChange(Sender: TObject);
var
  p: TPopup;
  TempCombo: TRectangle;
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  log16: TlogicalDiagnosis;
  log16Set: TLogicalData16;
begin
  if Sender = nil then Exit;

  if TControl(Sender).Parent.Parent.parent is TPopup then
  begin
    p := TPopup(TControl(Sender).Parent.Parent.parent);
    TempCombo := TRectangle(p.PlacementTarget);
    TempRect := TRectangle(TempCombo.Parent.Parent.parent);
    TempDiagLabel := TDiagLabel(TempRect.TagObject);
    log16Set := FAdb_DM.CollDiag.getLogical16Map(TempDiagLabel.diag.DataPos, Word(Diagnosis_Logical));
    log16 := TlogicalDiagnosis(Word(ClinicalStatus_Active) + lbDiagClinicStatus.ItemIndex);
    log16Set := TLogicalData16(TRealDiagnosisColl.SetClinicStatus(TlogicalDiagnosisSet(log16Set), log16));
    FAdb_DM.CollDiag.SetLogical16Map(TempDiagLabel.diag.DataPos, Word(Diagnosis_Logical), log16Set); //TLogicalData16([TLog16(ClinicalStatus_Recurrence)]));
    TempDiagLabel.ClinicStatusTXT.Repaint;
  end;
  //TempDiagLabel.diag
  //TempDiagLabel.ClinicStatusTXT.Text := lbDiagClinicStatus.ListItems[lbDiagClinicStatus.ItemIndex].Text;
end;

procedure TfrmFmxControls.lbDiagClinicStatusMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  TempItem: TListBoxItem;
begin
  TempItem := TListBox(sender).ItemByPoint(x, y);
  if TempItem <> nil then
  begin
    TListBox(sender).ItemIndex := TempItem.Index;
  end
  else
  begin
    TListBox(sender).ItemIndex := -1;
  end;
end;

procedure TfrmFmxControls.ListBoxItemClick(Sender: TObject);
var
  p : TPopup;
begin
  if Sender = nil then Exit;

  if TControl(Sender).Parent.Parent.parent is TPopup then
  begin
    p := TPopup(TControl(Sender).Parent.Parent.parent);
    p.IsOpen := False;
  end;
end;

procedure TfrmFmxControls.pDiagClinicStatusMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  pDiagClinicStatus.Position.Y := 20;
  pDiagClinicStatus.Scale.x := pDiagClinicStatus.Scale.x * 1.1;
  pDiagClinicStatus.Scale.y := pDiagClinicStatus.Scale.y * 1.1;
end;

end.
