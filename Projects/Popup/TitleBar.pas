unit TitleBar;
           //onclick
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, system.json, REST.JSON, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.Menus, FMX.Objects, FMX.Layouts, FMX.Ani,
  FMX.StdCtrls, FMX.Platform, FMX.Controls.Presentation, FMX.Edit, FMX.Effects,
  FMX.ListBox, FMX.TextLayout, System.Math, FMX.Platform.Win, FMX.Filter.Effects,
  FMX.ComboEdit, System.TimeSpan, system.Diagnostics, Aspects.Types,
  System.ImageList, FMX.ImgList;

type
  TRestoreEvent = procedure (Sender: TObject; var txt: String)of object;

  TPopupMainMenu = class(TPopup);

  TMenuLabel = class
    chk: TCheckBox;
    edt: TEdit;
    rctMenu: TRectangle;

    rctIcon: TRectangle;
    menu: TMenuItem;
    constructor Create;
  private
    FtextMenu: TText;
    FListBoxIndex: Integer;
    procedure SettextMenu(const Value: TText);
  public
    property textMenu: TText read FtextMenu write SettextMenu;
    property ListBoxIndex: Integer read FListBoxIndex write FListBoxIndex;
  end;

  TfrmTitlebar = class(TForm)
    lytTitleBar: TLayout;
    rctTitleBar: TRectangle;
    MenuBar1: TMenuBar;
    rctClose: TRectangle;
    clrnmtn1: TColorAnimation;
    Text1: TText;
    rctRestore: TRectangle;
    ColorAnimation1: TColorAnimation;
    Text2: TText;
    rctMinMax: TRectangle;
    ColorAnimation2: TColorAnimation;
    Text3: TText;
    rctHelp: TRectangle;
    ColorAnimation3: TColorAnimation;
    Text4: TText;
    rctSetings: TRectangle;
    ColorAnimation4: TColorAnimation;
    Text5: TText;
    RectAnimation1: TRectAnimation;
    rctIcon: TRectangle;
    lytLeftIcon: TLayout;
    rctBK: TRectangle;
    StyleBook1: TStyleBook;
    ddm1Main: TMenuItem;
    miRegistratura1: TMenuItem;
    miVisitQueue: TMenuItem;
    miMainRegister: TMenuItem;
    miMainSeparator2: TMenuItem;
    miMainExamination: TMenuItem;
    mniSuperHip: TMenuItem;
    miMainSeparator3: TMenuItem;
    miMainSchedule: TMenuItem;
    miMainSeparator4: TMenuItem;
    mniUdostoverenia: TMenuItem;
    miGenerateReportsAndInvoice: TMenuItem;
    mniDalgGriga: TMenuItem;
    mniProf: TMenuItem;
    mniDisp: TMenuItem;
    miMainSeparator5: TMenuItem;
    miSeans: TMenuItem;
    miMainSeparator6: TMenuItem;
    miMainExit: TMenuItem;
    ddm2List: TMenuItem;
    miPractica: TMenuItem;
    miListDoctor: TMenuItem;
    miLKK_Komisii: TMenuItem;
    miPacientGroups: TMenuItem;
    N37: TMenuItem;
    miWorkPlan: TMenuItem;
    miListWorkIntervals: TMenuItem;
    miDeputizing: TMenuItem;
    miListSeparator1: TMenuItem;
    miListNumeration: TMenuItem;
    miListSpeshenShkaf: TMenuItem;
    miListUnits: TMenuItem;
    N38: TMenuItem;
    miListPraktika: TMenuItem;
    miListSpecialist: TMenuItem;
    mniNeblUsl: TMenuItem;
    N47: TMenuItem;
    N46: TMenuItem;
    N16: TMenuItem;
    miListStore: TMenuItem;
    miListReactives: TMenuItem;
    miListSeans: TMenuItem;
    miListThemes: TMenuItem;
    N49: TMenuItem;
    miILab: TMenuItem;
    miAliases: TMenuItem;
    miAliasesRules: TMenuItem;
    miInstruments: TMenuItem;
    miCultureInfo: TMenuItem;
    mntmhpAccount: TMenuItem;
    ddm3Nomenclature: TMenuItem;
    miListProcedures: TMenuItem;
    miListManipulation: TMenuItem;
    miAnalysisParams: TMenuItem;
    miListAnalysis: TMenuItem;
    miListImmunization: TMenuItem;
    miListSpeciality: TMenuItem;
    miListClinicPaths: TMenuItem;
    mniAmbProc: TMenuItem;
    N36: TMenuItem;
    miListICD: TMenuItem;
    N101: TMenuItem;
    N35: TMenuItem;
    N15: TMenuItem;
    miListMedicine: TMenuItem;
    miListDrugs: TMenuItem;
    miListFreeMedeicine: TMenuItem;
    N4: TMenuItem;
    miListDispNomenklatura: TMenuItem;
    N12: TMenuItem;
    N40: TMenuItem;
    miExemptFromChargeICD: TMenuItem;
    ddm93Incoming: TMenuItem;
    N18: TMenuItem;
    N23: TMenuItem;
    N27: TMenuItem;
    N1: TMenuItem;
    ddm4Accounting1: TMenuItem;
    miPayments1: TMenuItem;
    miInvoices1: TMenuItem;
    N50: TMenuItem;
    miCharges1: TMenuItem;
    miChargesCategory1: TMenuItem;
    miTariff1: TMenuItem;
    N52: TMenuItem;
    miContractors1: TMenuItem;
    miGoods1: TMenuItem;
    miCauseDDS1: TMenuItem;
    ddm5Report: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N11: TMenuItem;
    miImunizationNavigator: TMenuItem;
    mniOtchetLabNew: TMenuItem;
    mniClen37: TMenuItem;
    ddm6Service: TMenuItem;
    miServiceViewLicense: TMenuItem;
    mniShowLicFrmLiman: TMenuItem;
    mniPogrom1: TMenuItem;
    mniSetings: TMenuItem;
    Log1: TMenuItem;
    miServiceSeparator1: TMenuItem;
    miWindowFullScreen: TMenuItem;
    miServiceAppearance: TMenuItem;
    N3: TMenuItem;
    miServiceCalibrate: TMenuItem;
    mi_SchemaSeparator: TMenuItem;
    mi_BackupBySchema: TMenuItem;
    mi_RestoreBySchema: TMenuItem;
    mi_OpenBRSchema: TMenuItem;
    miServiceSeparator2: TMenuItem;
    miServiceArchive: TMenuItem;
    miServiceRestore: TMenuItem;
    miServiceRebuild: TMenuItem;
    miServiceSeparator3: TMenuItem;
    miServiceClearDatabase: TMenuItem;
    N24: TMenuItem;
    mniN29_Remind: TMenuItem;
    mi_Herald: TMenuItem;
    mniN29: TMenuItem;
    ddm7Tools: TMenuItem;
    miAutoCorrectExamTime: TMenuItem;
    mniNZIS: TMenuItem;
    mniPis: TMenuItem;
    miValidator: TMenuItem;
    N32: TMenuItem;
    mniGetLabResult: TMenuItem;
    mi_RestoreRecipes: TMenuItem;
    N67: TMenuItem;
    mi_UpdateAndCheckEImmunizations: TMenuItem;
    mi_UpdateOfImmunizationsEnteredAfterImport: TMenuItem;
    N69: TMenuItem;
    N33: TMenuItem;
    miNSSIDirectCheck: TMenuItem;
    N17: TMenuItem;
    miCheckGP: TMenuItem;
    miRegisterForEinvoice: TMenuItem;
    N70: TMenuItem;
    mi_ElectronicHealthRecordsForGPs: TMenuItem;
    N39: TMenuItem;
    acAuxSearch: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N45: TMenuItem;
    miUINImport: TMenuItem;
    miImportRCZ: TMenuItem;
    miLiveUpdate: TMenuItem;
    N53: TMenuItem;
    mi_Warehouse: TMenuItem;
    mi_WarehouseImmunizations: TMenuItem;
    N66: TMenuItem;
    mih_AnyDesk: TMenuItem;
    eamViewer1: TMenuItem;
    ddm8Export: TMenuItem;
    miZoksImpEx: TMenuItem;
    miXMLZoksImpExp: TMenuItem;
    miZoksCheck: TMenuItem;
    miExportHealthBooks: TMenuItem;
    N5: TMenuItem;
    miCommonSpecification: TMenuItem;
    miCommonSpecificationSeparator: TMenuItem;
    miDeklDisp: TMenuItem;
    miDispExport: TMenuItem;
    miSeparatorMotherChild: TMenuItem;
    miMotherHealth: TMenuItem;
    miNeosigBremAL: TMenuItem;
    miNeosigBremMDD: TMenuItem;
    miChildrenHealth: TMenuItem;
    miProfOver18Health: TMenuItem;
    mniImportFDB: TMenuItem;
    N28: TMenuItem;
    miMotherHealthImport: TMenuItem;
    miImportChildren: TMenuItem;
    miUnassured: TMenuItem;
    ddm90GDPR1: TMenuItem;
    N61: TMenuItem;
    N30: TMenuItem;
    Otog1: TMenuItem;
    Bi1: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N64: TMenuItem;
    N31: TMenuItem;
    N34: TMenuItem;
    N51: TMenuItem;
    N54: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    GDPRDosie: TMenuItem;
    ddm91Security: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N26: TMenuItem;
    N25: TMenuItem;
    N22: TMenuItem;
    mniGDPR: TMenuItem;
    ddm92Help: TMenuItem;
    miHelpContents: TMenuItem;
    miHelpIndex: TMenuItem;
    miHelpSeparator1: TMenuItem;
    Cloud1: TMenuItem;
    N44: TMenuItem;
    N48: TMenuItem;
    miHelpAbout: TMenuItem;
    mniLicSpor: TMenuItem;
    N68: TMenuItem;
    miFeedback: TMenuItem;
    lytMenu: TFlowLayout;
    rctMni: TRectangle;
    ColorAnimation5: TColorAnimation;
    txtMenu: TText;
    p1: TPopup;
    lbMenuLavel_1: TListBox;
    shdwfct1: TShadowEffect;
    lstItemLavel_1: TListBoxItem;
    edtSearchBar: TEdit;
    lstItemSeparator: TListBoxItem;
    linSeparator: TLine;
    rctItem: TRectangle;
    txtItem: TText;
    lytItemIcon: TLayout;
    rctItemIcon: TRectangle;
    clrnmtn2: TColorAnimation;
    lytItemLavel_1: TLayout;
    rctItemIconBK: TRectangle;
    Rectangle3: TRectangle;
    rctHistory: TRectangle;
    rctPrev: TRectangle;
    rctPrevList: TRectangle;
    rctNextList: TRectangle;
    rctNext: TRectangle;
    rctIconSearch: TRectangle;
    txtArowList: TText;
    txtArowList1: TText;
    clrnmtn3: TColorAnimation;
    clrnmtn4: TColorAnimation;
    InvertEffect1: TInvertEffect;
    InvertEffect2: TInvertEffect;
    cbb1: TComboBox;
    ComboEdit1: TComboEdit;
    rctSelector: TRectangle;
    mniNzisNomen: TMenuItem;
    mniDbTables: TMenuItem;
    mniSep: TMenuItem;
    rct1: TRectangle;
    il1: TImageList;
    p2: TPopup;
    lbMenuLavel_2: TListBox;
    ShadowEffect1: TShadowEffect;
    mniTerapy: TMenuItem;
    mniJurnals: TMenuItem;
    mniJurnalNzis: TMenuItem;
    mniImportNzis: TMenuItem;
    mniNasMesto: TMenuItem;
    procedure rctTitleBarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rctCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctRestoreMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctMinMaxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure rctTitleBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rectangle7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctTitleBarDblClick(Sender: TObject);
    procedure slctnpnt1Track(Sender: TObject; var X, Y: Single);
    procedure rctTestDragMouseDown1(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctTestDragMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure mniInfoDbClick(Sender: TObject);
    procedure mniLoadDbClick(Sender: TObject);
    procedure rctSetingsClick(Sender: TObject);
    procedure rctMniClick(Sender: TObject);
    procedure lbMenuLavel_1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure rctMniMouseEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure txtMenuPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure tmr1Timer(Sender: TObject);
    procedure ColorAnimation5Finish(Sender: TObject);
    procedure rctHelpClick(Sender: TObject);
    procedure edtSearchBarDblClick(Sender: TObject);
    procedure edtSearchBarValidating(Sender: TObject; var Text: string);
    procedure lbMenuLavel_1Change(Sender: TObject);
    procedure miListMedicineClick(Sender: TObject);
    procedure miListICDClick(Sender: TObject);
    procedure rctItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctItemMouseEnter(Sender: TObject);
    procedure p2Click(Sender: TObject);
    procedure mniProfClick(Sender: TObject);
    procedure mniDalgGrigaClick(Sender: TObject);
    procedure p2ClosePopup(Sender: TObject);
    procedure p1ClosePopup(Sender: TObject);
    procedure p1CanFocus(Sender: TObject; var ACanFocus: Boolean);
  private
    cnt: Integer;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    FOnRestoreApp: TRestoreEvent;
    FOnMinimizeApp: TNotifyEvent;
    FOnCloseApp: TNotifyEvent;
    FOnTitleMouseDown: TNotifyEvent;
    FOnTitleDblClick: TRestoreEvent;
    FOnDbClick: TNotifyEvent;
    FOnLoadDbClick: TNotifyEvent;
    FOnSetingsClick: TNotifyEvent;
    LstMenuLabels: TList<TMenuLabel>;
    txtCalcMemo: TTextLayout;
    txtCalcEdit: TTextLayout;
    FMenuItemHeight: Single;
    FOnHelpClick: TNotifyEvent;
    FOnProfGrafClick: TNotifyEvent;
    procedure FillMenu;
  public
    procedure ActivateTitleBar(IsActivate: Boolean);
    procedure WmHelp(mousePos: TPoint);
    function FindMenuItem(MenuTag: string): TMenuLabel;
    property MenuItemHeight: Single read FMenuItemHeight write FMenuItemHeight;


    property OnCloseApp: TNotifyEvent read FOnCloseApp write FOnCloseApp;
    property OnMinimizeApp: TNotifyEvent read FOnMinimizeApp write FOnMinimizeApp;
    property OnRestoreApp: TRestoreEvent read FOnRestoreApp write FOnRestoreApp;
    property OnTitleMouseDown: TNotifyEvent read FOnTitleMouseDown write FOnTitleMouseDown;
    property OnTitleDblClick: TRestoreEvent read FOnTitleDblClick write FOnTitleDblClick;
    property OnHelpClick: TNotifyEvent read FOnHelpClick write FOnHelpClick;

    property OnDbClick: TNotifyEvent read FOnDbClick write FOnDbClick;
    property OnLoadDbClick: TNotifyEvent read FOnLoadDbClick write FOnLoadDbClick;

    property OnSetingsClick: TNotifyEvent read FOnSetingsClick write FOnSetingsClick;
    property OnProfGrafClick: TNotifyEvent read FOnProfGrafClick write FOnProfGrafClick;
  end;

var
  frmTitlebar: TfrmTitlebar;

implementation
uses RolePanels, RoleBar, WalkFunctions;

{$R *.fmx}

procedure TfrmTitlebar.ActivateTitleBar(IsActivate: Boolean);
var
  clr: TAlphaColor;
  rf: TRectF;
begin
  //rf.Top := Self.ClientToScreen(PointF(0, 0)).y + lytMenu.LocalToAbsolute(PointF(0, 0)).y + 33;
//  rf.left := Self.ClientToScreen(PointF(0, 0)).x + lytMenu.LocalToAbsolute(PointF(0, 0)).x;
//  rf.Width := lytMenu.Width;
//  rf.Height := lytMenu.Height;
  if IsActivate or p1.IsOpen then //(PtInRect(rf , lytMenu.LocalToAbsolute(Screen.MousePos))) then
    clr := $FF0063B1
  else
    clr := $FFABC4DF;

  rctTitleBar.Fill.Color := clr;
  ColorAnimation1.StartValue := clr;
  ColorAnimation2.StartValue := clr;
  ColorAnimation3.StartValue := clr;
  ColorAnimation4.StartValue := clr;
  clrnmtn1.StartValue := clr;
  rctHelp.Fill.Color := clr;
  rctSetings.Fill.Color := clr;
  rctMinMax.Fill.Color := clr;
  rctRestore.Fill.Color := clr;
  rctClose.Fill.Color := clr;
end;

procedure TfrmTitlebar.ColorAnimation5Finish(Sender: TObject);
begin
  //edt1.Text := TimeToStr(now);
end;

procedure TfrmTitlebar.edtSearchBarDblClick(Sender: TObject);
begin
  //rctMniMouseEnter(LstMenuLabels[2].rctMenu);
//  p1.Popup();
end;

procedure TfrmTitlebar.edtSearchBarValidating(Sender: TObject;
  var Text: string);
var
  TempMenuLabel: TMenuLabel;
begin

  if Text = '' then
  begin
    if p1.IsOpen then
      p1.IsOpen := False;
    Exit;
  end;
  TempMenuLabel := FindMenuItem(Text);
  if (TempMenuLabel = nil) then
  begin
    Text := edtSearchBar.Text;
    Exit;
  end;

  rctMniMouseEnter(TempMenuLabel);
  lbMenuLavel_1.ItemIndex := TempMenuLabel.ListBoxIndex;
  p1.Popup();
  ComboEdit1.SetFocus;
  Self.Activate;
  Application.ProcessMessages;
  edtSearchBar.SetFocus;
  edtSearchBar.SelLength := 0;

end;

procedure TfrmTitlebar.FillMenu;
var
  i: Integer;
  TempRct: TRectangle;
  TempMenuLabel: TMenuLabel;
begin
  miListMedicine.Tag := word(vvMKB);


  rctMni.Visible := False;
  rctSelector.Parent := nil;
  LstMenuLabels := TList<TMenuLabel>.Create;
  for i := 0 to MenuBar1.ItemsCount - 1 do
  begin
    TempMenuLabel := TMenuLabel.Create;
    TempMenuLabel.menu := MenuBar1.Items[i];
    TempRct := TRectangle(rctMni.Clone(lytMenu));
    TempRct.TagString := TempMenuLabel.menu.Text;
    TempMenuLabel.rctMenu := TempRct;
    TempMenuLabel.textMenu := WalkChildrenText(TempRct);
    TempMenuLabel.textMenu.OnPainting := txtMenuPainting;

    txtCalcEdit.MaxSize := PointF(100000, 19);
    txtCalcEdit.Font.Assign(TempMenuLabel.textMenu.TextSettings.Font);
    txtCalcEdit.Text := TempMenuLabel.menu.Text;
    TempRct.Width := txtCalcEdit.TextWidth + 40;

    TempRct.TagObject := TempMenuLabel;
    TempRct.Parent := lytMenu;
    TempRct.OnClick := rctMniClick;
    TempRct.OnMouseEnter := rctMniMouseEnter;
    LstMenuLabels.Add(TempMenuLabel);
    TempRct.Visible := True;
  end;
  rctHistory.Height := rctMni.Height;
  rctHistory.BringToFront;
end;

function TfrmTitlebar.FindMenuItem(MenuTag: string): TMenuLabel;
var
  i, j: Integer;
  RunMenuLabel: TMenuLabel;
  ListBoxIndex: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  Result := nil;

  for i := 0 to LstMenuLabels.Count - 1 do
  begin
    RunMenuLabel := LstMenuLabels[i];
    ListBoxIndex := -1;
    for j := 0 to RunMenuLabel.menu.ItemsCount - 1 do
    begin
      if not RunMenuLabel.menu.Items[j].Visible then continue;
      //if RunMenuLabel.menu.Items[j].text = '-' then continue;
      inc(ListBoxIndex);
      if AnsiUpperCase(RunMenuLabel.menu.Items[j].Text).Contains(AnsiUpperCase(MenuTag)) then
      begin
        Result :=  RunMenuLabel;
        Result.ListBoxIndex := ListBoxIndex;
        ComboEdit1.Text := RunMenuLabel.menu.Items[j].Text;
        Exit;;
      end;
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
  //Caption := ( 'menu ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmTitlebar.FormCreate(Sender: TObject);
var
  role: TRole;
  lst: TList<TRole>;
  i: integer;
begin
  cnt := 0;
  MenuItemHeight := 22;
  lst := TList<TRole>.Create;
  role := TRole.Create;
  role.RoleName := 'Моята роля';
  role.RoleMenuName := 'Moeto menu';
  lst.Add(role);
  Caption := TJson.ObjectToJsonString(lst);
  role.Destroy;
  lst.Free;
  txtCalcEdit := TTextLayoutManager.DefaultTextLayout.Create;
  txtCalcEdit.HorizontalAlign:= TTextAlign.Leading;
  txtCalcEdit.VerticalAlign := TTextAlign.center;
  txtCalcEdit.WordWrap := false;
  lbMenuLavel_1.Parent := p1;
  lbMenuLavel_1.Align := TAlignLayout.Contents;
  lbMenuLavel_2.Parent := p2;
  lbMenuLavel_2.Align := TAlignLayout.Contents;
  FillMenu;
end;

procedure TfrmTitlebar.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LstMenuLabels);
  FreeAndNil(txtCalcEdit);
end;

procedure TfrmTitlebar.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  //
end;

procedure TfrmTitlebar.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  //edt1.Text := IntToStr(Integer(PtInRect(lytMenu.AbsoluteRect , lytMenu.AbsoluteToLocal(Screen.MousePos))));
end;

procedure TfrmTitlebar.lbMenuLavel_1Change(Sender: TObject);
var
  lstItem: TListBoxItem;
begin

end;

procedure TfrmTitlebar.lbMenuLavel_1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
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

procedure TfrmTitlebar.miListICDClick(Sender: TObject);
begin
  ShowMessage(miListICD.Text);
end;

procedure TfrmTitlebar.miListMedicineClick(Sender: TObject);
begin
  ShowMessage(miListMedicine.Text);
end;

procedure TfrmTitlebar.mniDalgGrigaClick(Sender: TObject);
begin
  //Exit; //zzzzzzzzzzzzzzzzzzzz
  if p2.IsOpen then
  begin
    p2.SetFocus;
    //TCustomPopupForm(TPopupMainMenu(p2).PopupForm).ApplyPlacement;
  end
  else
  begin
    p2.IsOpen := true;
  end;
end;

procedure TfrmTitlebar.mniInfoDbClick(Sender: TObject);
begin
  if Assigned(FOnDbClick) then
    FOnDbClick(Sender);
end;

procedure TfrmTitlebar.mniLoadDbClick(Sender: TObject);
begin
  if Assigned(FOnLoadDbClick) then
    FOnLoadDbClick(Sender);
end;

procedure TfrmTitlebar.mniProfClick(Sender: TObject);
begin
  p2.IsOpen := False;
end;

procedure TfrmTitlebar.p1CanFocus(Sender: TObject; var ACanFocus: Boolean);
begin
  //
end;

procedure TfrmTitlebar.p1ClosePopup(Sender: TObject);
begin
  //p1.IsOpen := False;
end;

procedure TfrmTitlebar.p2Click(Sender: TObject);
begin
  p2.IsOpen := False;
end;

procedure TfrmTitlebar.p2ClosePopup(Sender: TObject);
begin
  //p1.IsOpen := False;
end;

procedure TfrmTitlebar.rctCloseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnCloseApp) then
  begin
    FOnCloseApp(Sender);
  end
  else
  begin
    Close;
  end;
end;

procedure TfrmTitlebar.rctHelpClick(Sender: TObject);
begin
  if Assigned (FOnHelpClick) then
    FOnHelpClick(Self);
  //SendMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
end;

procedure TfrmTitlebar.rctItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  Svc: IFMXDragDropService;
  DragData: TDragObject;
  DragImage: TBitmap;
  obj: TObject;
  li: TListBoxItem;
  rf: TRectF;
begin
  Exit;
  if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then
  begin
    p1.PlacementTarget.BoundsRect;
    li := TListBoxItem(trectangle(Sender).parent.parent);
    rf := p1.PlacementTarget.AbsoluteRect;
    rf.Offset(li.Position.Point);
    rf.Offset(PointF(0, 20));
   // rf.Offset(p1.LocalToAbsolute(PointF(0, 0)));
    rct1.BoundsRect := rf;
    DragData.Source := rct1;
    DragImage := li.MakeScreenshot;
    //DragImage.SaveToFile('d:\test.bmp');
    try
      DragData.Data := DragImage;
      obj := TObject.Create;
      Svc.BeginDragDrop(self, DragData, DragImage);
    finally
      DragImage.Free;
    end;
  end;
end;


procedure TfrmTitlebar.rctItemMouseEnter(Sender: TObject);
var
  TempLstItem: TListBoxItem;
  tempRctMenu, rctListItem: TRectangle;
  //tempMenuLabel: TMenuLabel;
  menu1: TMenuItem;
  maxW, tempH: Single;
  i: integer;
begin
  tempRctMenu := TRectangle(Sender);
  //tempMenuLabel := TMenuLabel(tempRctMenu.TagObject);
  menu1 := TMenuItem(tempRctMenu.TagObject);




  if menu1.ItemsCount > 0 then
  begin
    lbMenuLavel_2.Clear;
    maxW := 0;
    tempH := 0;
    for i := 0 to menu1.ItemsCount - 1 do
    begin
      if not menu1.Items[i].Visible then continue;

      if menu1.Items[i].Text <> '-' then
      begin
        TempLstItem := TListBoxItem(lstItemLavel_1.Clone(self));
        TempLstItem.TagString := menu1.Items[i].Text;
        TempLstItem.Visible := True;
        txtMenu := WalkChildrenText(TempLstItem);
        txtMenu.Text := menu1.Items[i].Text;
        txtCalcEdit.MaxSize := PointF(100000, 19);
        txtCalcEdit.Font.Assign(txtMenu.TextSettings.Font);
        txtCalcEdit.Text := txtMenu.Text;
        maxW := max(txtCalcEdit.TextWidth, maxW);
        TempLstItem.Position.Point := PointF(TempLstItem.Position.Point.X, 0);
        TempLstItem.Height := FMenuItemHeight;
        tempH := tempH + TempLstItem.Height;
        rctListItem := WalkChildrenRectStyle(TempLstItem, 'rctListItem');
        rctListItem.TagObject := menu1.Items[i];
        rctListItem.TagString := menu1.Items[i].Text;
        rctListItem.OnClick := menu1.Items[i].OnClick;
        rctListItem.OnMouseDown := rctItemMouseDown;
        rctListItem.OnMouseEnter := nil;
        //rctListItem.Fill.Color := TAlphaColorRec.Brown;

        if not menu1.Items[i].Bitmap.IsEmpty then
        begin
          rctIcon := WalkChildrenRectStyle(TempLstItem, 'rctIcon');
          rctIcon.Fill.Bitmap.Bitmap.Assign(menu1.Items[i].Bitmap);
        end
        else
        begin
          rctIcon := WalkChildrenRectStyle(TempLstItem, 'rctIcon');
          rctIcon.Fill.Kind := TBrushKind.None;
        end;
        TempLstItem.Parent := lbMenuLavel_2;
      end
      else
      begin
        TempLstItem := TListBoxItem(lstItemSeparator.Clone(self));
        TempLstItem.Visible := True;
        TempLstItem.Text := '';

        TempLstItem.Position.Point := PointF(TempLstItem.Position.Point.X, 0);
        TempLstItem.Height := 10;
        rctIcon := WalkChildrenRectStyle(TempLstItem, 'rctIcon');
        rctIcon.Width := FMenuItemHeight;
        tempH := tempH + TempLstItem.Height;
        TempLstItem.Parent := lbMenuLavel_2;
      end;
    end;



    lbMenuLavel_2.Width := maxW + 80;
    lbMenuLavel_2.Height := tempH;
    p2.PopupFormSize := TSizeF.Create ( maxW + 80 , tempH + 4 );

    p2.PlacementTarget := TRectangle(Sender);
    p2.Placement := TPlacement.Right;
    if p2.IsOpen then
    begin
      TCustomPopupForm(TPopupMainMenu(p2).PopupForm).ApplyPlacement;
    end
    else
    begin
      p2.Popup();
    end;
  end
  else
  begin
    p2.IsOpen := False;
  end;
end;

procedure TfrmTitlebar.rctMinMaxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnMinimizeApp) then
  begin
    FOnMinimizeApp(Sender);
  end
  else
  begin
    Self.WindowState := TWindowState.wsMinimized;
  end;
end;

procedure TfrmTitlebar.rctMniClick(Sender: TObject);
begin
  
  p1.PlacementTarget := TRectangle(Sender);
  p1.Popup();
end;

procedure TfrmTitlebar.rctMniMouseEnter(Sender: TObject);
var
  TempLstItem: TListBoxItem;
  tempRctMenu: TRectangle;
  tempMenuLabel: TMenuLabel;
  tempRctSelector: TRectangle;
  i: Integer;
  maxW, tempH: Single;
  rctIcon, rctListItem: TRectangle;
  txtMenu: TText;
begin
  p2.IsOpen := False;
  if Sender is TRectangle then
  begin
    tempRctMenu := TRectangle(Sender);
    tempMenuLabel := TMenuLabel(tempRctMenu.TagObject);
  end
  else
  begin
    tempMenuLabel := TMenuLabel(sender);
  end;
  lbMenuLavel_1.Clear;
  maxW := 0;
  tempH := 0;
  for i := 0 to tempMenuLabel.menu.ItemsCount - 1 do
  begin
    if not tempMenuLabel.menu.Items[i].Visible then continue;

    if tempMenuLabel.menu.Items[i].Text <> '-' then
    begin
      TempLstItem := TListBoxItem(lstItemLavel_1.Clone(self));
      TempLstItem.TagString := tempMenuLabel.menu.Items[i].Text;
      TempLstItem.Visible := True;
      txtMenu := WalkChildrenText(TempLstItem);
      txtMenu.Text := tempMenuLabel.menu.Items[i].Text;
      txtCalcEdit.MaxSize := PointF(100000, 19);
      txtCalcEdit.Font.Assign(txtMenu.TextSettings.Font);
      txtCalcEdit.Text := txtMenu.Text;
      maxW := max(txtCalcEdit.TextWidth, maxW);
      TempLstItem.Position.Point := PointF(TempLstItem.Position.Point.X, 0);
      TempLstItem.Height := FMenuItemHeight;
      tempH := tempH + TempLstItem.Height;
      rctListItem := WalkChildrenRectStyle(TempLstItem, 'rctListItem');
      rctListItem.TagObject := tempMenuLabel.menu.Items[i];
      rctListItem.TagString := tempMenuLabel.menu.Items[i].Text;
      rctListItem.OnClick := tempMenuLabel.menu.Items[i].OnClick;
      rctListItem.OnMouseDown := rctItemMouseDown;

      rctListItem.OnMouseEnter := rctItemMouseEnter;
      //rctListItem.Fill.Color := TAlphaColorRec.Brown;

      if not tempMenuLabel.menu.Items[i].Bitmap.IsEmpty then
      begin
        rctIcon := WalkChildrenRectStyle(TempLstItem, 'rctIcon');
        rctIcon.Fill.Bitmap.Bitmap.Assign(tempMenuLabel.menu.Items[i].Bitmap);
      end
      else
      begin
        rctIcon := WalkChildrenRectStyle(TempLstItem, 'rctIcon');
        rctIcon.Fill.Kind := TBrushKind.None;
      end;
      TempLstItem.Parent := lbMenuLavel_1;
      if Sender is TMenuLabel then
      begin
        if TempLstItem.Index = tempMenuLabel.ListBoxIndex then
        begin
          tempRctSelector := TRectangle(rctSelector.Clone(Self));
          tempRctSelector.Parent := TempLstItem;
          tempRctSelector.SendToBack;
        end;
      end;
    end
    else
    begin
      TempLstItem := TListBoxItem(lstItemSeparator.Clone(self));
      TempLstItem.Visible := True;
      TempLstItem.Text := '';

      TempLstItem.Position.Point := PointF(TempLstItem.Position.Point.X, 0);
      TempLstItem.Height := 10;
      rctIcon := WalkChildrenRectStyle(TempLstItem, 'rctIcon');
      rctIcon.Width := FMenuItemHeight;
      tempH := tempH + TempLstItem.Height;
      TempLstItem.Parent := lbMenuLavel_1;
    end;
  end;



  lbMenuLavel_1.Width := maxW + 80;
  lbMenuLavel_1.Height := tempH;
  p1.PopupFormSize := TSizeF.Create ( maxW + 80 , tempH + 4 );

  p1.Placement := TPlacement.Bottom;
  if Sender is TRectangle then
  begin
    p1.PlacementTarget:= TRectangle(Sender);
  end
  else
  begin
    p1.PlacementTarget:= tempMenuLabel.rctMenu;
  end;

end;

procedure TfrmTitlebar.rctRestoreMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  txt: string;
begin
  if Assigned(FOnRestoreApp) then
  begin
    FOnRestoreApp(Sender, txt);
    Text2.Text := txt;
  end
  else
  begin
    if Self.WindowState = TWindowState.wsMaximized then
    begin
      Self.WindowState := TWindowState.wsNormal;
      Text2.Text := '1';
    end
    else
    begin
      Self.WindowState := TWindowState.wsMaximized;
      Text2.Text := '2';
    end;
  end;
end;

procedure TfrmTitlebar.rctSetingsClick(Sender: TObject);
begin
  if Assigned(FOnSetingsClick) then
    FOnSetingsClick(Sender);
end;

procedure TfrmTitlebar.rctTestDragMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Svc: IFMXDragDropService;
  DragData: TDragObject;
  DragImage: TBitmap;
  //obj: TObject;
begin
  //if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then
//  begin
//    DragData.Source := Sender;
//    DragImage := mni3.MakeScreenshot;
//    try
//      DragData.Data := DragImage;
//      //obj := TObject.Create;
//      Svc.BeginDragDrop(TCommonCustomForm(mni3.Root), DragData, DragImage);
//    finally
//      DragImage.Free;
//    end;
//  end;
end;

procedure TfrmTitlebar.rctTestDragMouseDown1(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
const
  DraggingOpacity = 0.99;
var
  B, S: TBitmap;
  R: TRectF;
begin
  //if mni3.Root <> nil then
//  begin
//    S := mni3.MakeScreenshot;
//    try
//      B := nil;
//      try
//        if (S.Width > 512) or (S.Height > 512) then
//        begin
//          R := TRectF.Create(0, 0, S.Width, S.Height);
//          R.Fit(TRectF.Create(0, 0, 512, 512));
//          B := TBitmap.Create(Round(R.Width), Round(R.Height));
//          B.Clear(0);
//          if B.Canvas.BeginScene then
//          try
//            B.Canvas.DrawBitmap(S, TRectF.Create(0, 0, S.Width, S.Height), TRectF.Create(0, 0, B.Width, B.Height),
//              DraggingOpacity, True);
//          finally
//            B.Canvas.EndScene;
//          end;
//        end else
//        begin
//          B := TBitmap.Create(S.Width, S.Height);
//          B.Clear(0);
//          if B.Canvas.BeginScene then
//          try
//            B.Canvas.DrawBitmap(S, TRectF.Create(0, 0, B.Width, B.Height), TRectF.Create(0, 0, B.Width, B.Height),
//              DraggingOpacity, True);
//          finally
//            B.Canvas.EndScene;
//          end;
//        end;
//        mni3.Root.BeginInternalDrag(mni3, B);
//      finally
//        B.Free;
//      end;
//    finally
//      S.Free;
//    end;
//  end;
end;

procedure TfrmTitlebar.rctTitleBarClick(Sender: TObject);
var
  clr: TAlphaColor;
begin
  inc(cnt);
  
end;

procedure TfrmTitlebar.rctTitleBarDblClick(Sender: TObject);
var
  txt: string;
begin
  if Assigned(FOnTitleDblClick) then
    FOnTitleDblClick(Sender, txt);
  Text2.Text := txt;
end;

procedure TfrmTitlebar.rctTitleBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Assigned(FOnTitleMouseDown) then
    FOnTitleMouseDown(Sender);
end;

procedure TfrmTitlebar.Rectangle7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  btn: TRectangle;
  ctrl: TFmxObject;
  datEdt: TDateEdit;
begin
  btn := TRectangle(Sender);
  ctrl := btn.Parent;
  while true  do
  begin
    if (ctrl is TDateEdit)then
    begin
      datEdt := TDateEdit(ctrl);
      Break;
    end;
    ctrl := ctrl.Parent;
  end;
  datEdt.IsChecked := True;

  if datEdt.IsPickerOpened then
    datEdt.ClosePicker
  else
    datEdt.OpenPicker;
end;

procedure TfrmTitlebar.slctnpnt1Track(Sender: TObject; var X, Y: Single);
begin
  rctTitleBar.Height := y;
end;

procedure TfrmTitlebar.tmr1Timer(Sender: TObject);
var
  rf: TRectF;
begin
  rf.Top := Self.ClientToScreen(PointF(0, 0)).y + lytMenu.LocalToAbsolute(PointF(0, 0)).y + 33;
  rf.left := Self.ClientToScreen(PointF(0, 0)).x + lytMenu.LocalToAbsolute(PointF(0, 0)).x;
  rf.Width := lytMenu.Width;
  rf.Height := lytMenu.Height;
  //edt1.Text := FloatToStr(Self.ClientToScreen(PointF(0, 0)).y + lytMenu.LocalToAbsolute(PointF(0, 0)).y);
  //edt1.Text := FloatToStr(lytMenu.LocalToAbsolute(PointF(0, 0)).y);
  //edt1.Text := IntToStr(Integer(PtInRect(rf , lytMenu.LocalToAbsolute(Screen.MousePos))));
end;

procedure TfrmTitlebar.txtMenuPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  tempText: TText;
  tempMenuLabel: TMenuLabel;
  tempRctMenu: TRectangle;
begin
  tempText := TText(Sender);
  tempRctMenu := TRectangle(tempText.Parent);
  tempMenuLabel := TMenuLabel(tempRctMenu.TagObject);
  tempText.Text := tempMenuLabel.menu.Text;
end;

procedure TfrmTitlebar.WmHelp(mousePos: TPoint);
var
  p: TPointF;
  Cntrl: IControl;
  StyledCtrl: TStyledControl;
  hnd: THandle;
begin
  if p1.IsOpen then
  begin
    hnd := FmxHandleToHWND(TCustomPopupForm(TPopupMainMenu(p1).PopupForm).Handle);
    edtSearchBar.Text := (IntToStr(hnd));
    Cntrl := TCustomPopupForm(TPopupMainMenu(p1).PopupForm).ObjectAtPoint(MousePos);
    edtSearchBar.Text := Cntrl.GetObject.TagString;
  end
  else
  begin
    Cntrl := self.ObjectAtPoint(MousePos);
    ShowMessage(Cntrl.GetObject.TagString);
  end;
end;

{ TMenuLabel }

constructor TMenuLabel.Create;
begin
//
end;

procedure TMenuLabel.SettextMenu(const Value: TText);
begin
  FtextMenu := Value;
  //Self.rctMenu.Width := FtextMenu.Width;
end;

end.
