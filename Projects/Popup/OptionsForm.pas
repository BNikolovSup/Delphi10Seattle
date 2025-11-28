unit OptionsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  FMX.Objects, FMX.StdCtrls, FMX.ListBox, FMX.Effects, FMX.DateTimeCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.Edit, FMX.Ani,
  FMX.Layouts, FMX.TabControl, FMX.ExtCtrls, FMX.GifUtils,

  System.Diagnostics, System.TimeSpan, VirtualTrees, Aspects.Types,
  Aspects.Collections, system.Rtti, VirtualStringTreeAspect,
  System.Math.Vectors, FMX.Controls3D, System.Generics.Collections,
  System.ImageList, FMX.ImgList, WalkFunctions;

type

  TfrmOptionsForm = class(TForm)
    scrlbx1: TScrollBox;
    scldlyt1: TScaledLayout;
    rctBlanka: TRectangle;
    lytLeft: TLayout;
    slctnpnt3: TSelectionPoint;
    stylbk1: TStyleBook;
    rct2: TRectangle;
    anim1: TFloatAnimation;
    anim2: TFloatAnimation;
    anim3: TFloatAnimation;
    Rectangle2: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    rctSelector: TRectangle;
    tbcOption: TTabControl;
    tbtm1: TTabItem;
    tbtm2: TTabItem;
    tbtm3: TTabItem;
    btn1: TButton;
    edt1: TEdit;
    mmo1: TMemo;
    lytRight: TLayout;
    img2: TImage;
    OpenDialog1: TOpenDialog;
    btn2: TButton;
    lytTop: TLayout;
    txtCaptionOption: TText;
    lb1: TListBox;
    lst1: TListBoxItem;
    lst2: TListBoxItem;
    lst3: TListBoxItem;
    lst4: TListBoxItem;
    rct1: TRectangle;
    pmTest: TPopupMenu;
    mni1: TMenuItem;
    edt2: TEdit;
    il1: TImageList;
    procedure scrlbx1CalcContentBounds(Sender: TObject;
      var ContentBounds: TRectF);
    procedure scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure lytRightClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img2Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure txtCaptionOptionPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Rectangle2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edt2KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    FScaleDyn: Single;
    FGifPlayer: TGifPlayer;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    FOptionNode: PVirtualNode;
    FOptionTree: TVirtualStringTreeAspect;
    FBufOptions: Pointer;

    procedure CreateOptionsObject(AParent: TFmxObject;
                                              tagStr: string;
                                              SectionName: string;
                                              InIniName: string;
                                              ValueType: TValueType;
                                              DataPos: Cardinal
                                              );
    procedure SetScaleDyn(const Value: Single);
    procedure SetOptionNode(const Value: PVirtualNode);
    procedure SetOptionTree(const Value: TVirtualStringTreeAspect);
    procedure SetBufOptions(const Value: Pointer);

  public
    ListOptionObject: TList<TOptionObject>;
    procedure FillListOptionObject;
    procedure FillOptions;
    function FindTab(fmxObject: TFmxObject): TTabItem;
    property scaleDyn: Single read FScaleDyn write SetScaleDyn;
    property OptionTree: TVirtualStringTreeAspect read FOptionTree write SetOptionTree;
    property OptionNode: PVirtualNode read FOptionNode write SetOptionNode;
    property BufOptions: Pointer read FBufOptions write SetBufOptions;
  end;



implementation

{$R *.fmx}


procedure TfrmOptionsForm.btn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Stopwatch := TStopwatch.StartNew;
    FGifPlayer.LoadFromFile(OpenDialog1.FileName);
    Elapsed := Stopwatch.Elapsed;
    btn1.text := ( 'patlist ' + FloatToStr(Elapsed.TotalMilliseconds));
  end;

end;

procedure TfrmOptionsForm.btn2Click(Sender: TObject);
begin
  FGifPlayer.Destroy;
end;

procedure TfrmOptionsForm.CreateOptionsObject(AParent: TFmxObject;
                                              tagStr: string;
                                              SectionName: string;
                                              InIniName: string;
                                              ValueType: TValueType;
                                              DataPos: Cardinal
                                              );
var
  optObj: TOptionObject;
begin
  optObj := TOptionObject.Create(AParent);
  optObj.parent := AParent;
  optObj.TagString := tagStr;
  optObj.SectionIni := SectionName;
  optObj.NameInIni := InIniName;
  optObj.ValueType := ValueType;
  optObj.DataPos := DataPos;
end;

procedure TfrmOptionsForm.edt2KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  //
end;

procedure TfrmOptionsForm.FillListOptionObject;
begin
  FillOptions;
  WalkFunctions.WalkChildrenOptionObject(scldlyt1, ListOptionObject, FBufOptions);
  OptionTree.Repaint;
  edt2.Text := IntToStr(ListOptionObject.Count)
end;

procedure TfrmOptionsForm.FillOptions;
begin
  CreateOptionsObject(mmo1, 'memoto', '', '', TValueType.tvInteger, 164);
end;

function TfrmOptionsForm.FindTab(fmxObject: TFmxObject): TTabItem;
var
  runObject: TFmxObject;
begin
  Result := nil;
  runObject := fmxObject;
  while (runObject.Parent <> nil) do
  begin
    if runObject.Parent is TTabItem then
    begin
      Result := TTabItem(runObject.Parent);
      Break;
    end;
    runObject := runObject.Parent;
  end;
end;

procedure TfrmOptionsForm.FormCreate(Sender: TObject);
begin
  FGifPlayer := TGifPlayer.Create(Self);
  FGifPlayer.Image := img2;
  FOptionNode := nil;
  ListOptionObject := TList<TOptionObject>.create;
end;

procedure TfrmOptionsForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ListOptionObject);
end;

procedure TfrmOptionsForm.img2Click(Sender: TObject);
begin
  if FGifPlayer.IsPlaying then
    FGifPlayer.Pause
  else
    FGifPlayer.Play;
end;

procedure TfrmOptionsForm.lytRightClick(Sender: TObject);
begin
  edt1.TagString := '';
end;

procedure TfrmOptionsForm.Rectangle2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  btn1Click(nil);
end;

procedure TfrmOptionsForm.scrlbx1CalcContentBounds(Sender: TObject;
  var ContentBounds: TRectF);
begin
  ContentBounds := scldlyt1.BoundsRect;
end;

procedure TfrmOptionsForm.scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;
  vScrol, hScrol: TScrollBar;
  pMemo: TPointF;
begin

  scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
  scrlbx1.FindStyleResource<TScrollBar>('hscrollbar', hScrol);
  if ssCtrl in Shift then
  begin
    scrlbx1.BeginUpdate;
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
    pMemo.Y := scrlbx1.AbsoluteToLocal(Screen.MousePos).y - Self.Top;
    pMemo.X := scrlbx1.AbsoluteToLocal(Screen.MousePos).X - Self.Left;
    vScrol.Value := pMemo.Y * FScaleDyn - (pMemo.Y );// -(scrlbx1.AbsoluteToLocal(Screen.MousePos).Y - Self.Top) + mmo1.LocalToAbsolute(pMemo).Y + scrlbx1.ViewportPosition.y;
    hScrol.Value := pMemo.X * FScaleDyn - (pMemo.X); //-(scrlbx1.AbsoluteToLocal(Screen.MousePos).x - Self.Left) + mmo1.LocalToAbsolute(pMemo).X+ scrlbx1.ViewportPosition.X;


    //mmo1.Text := Format('%f', [mmo1.LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y]);
    mmo1.Text := Format('%f', [scrlbx1.AbsoluteToLocal(Screen.MousePos).Y - Self.Top]);
    Handled := True;
    scrlbx1.EndUpdate;
  end
  else
  begin


    if WheelDelta> 0 then
    begin
      vScrol.Value := vScrol.Value - 20 * scaleDyn;
    end
    else
    begin
      vScrol.Value := vScrol.Value + 20 * scaleDyn;
    end;
    mmo1.Text := Format('%f', [mmo1.AbsoluteToLocal(Screen.MousePos).y- Self.Top]);
   // mmo1.Text := Format('%f', [mmo1.LocalToAbsolute(Point(0,0)).x + scrlbx1.ViewportPosition.x]);
    Handled := True;
  end;


end;

procedure TfrmOptionsForm.SetBufOptions(const Value: Pointer);
var
  runNode: PVirtualNode;
  dataNode: PAspRec;
  CardinalData: PCardinal;
  LenDataOption, currentLen: Cardinal;
begin
  Stopwatch := TStopwatch.StartNew;

  FBufOptions := Value;
  CardinalData := FBufOptions;
  LenDataOption := CardinalData^;

  currentLen := 100;
  while currentLen <= LenDataOption  do
  begin
    runNode := Pointer(PByte(FBufOptions) + currentLen);
    dataNode := Pointer(PByte(runNode) + lenNode);
    dataNode.index := -1;

    inc(currentLen, LenData);
  end;
  Elapsed := Stopwatch.Elapsed;
    btn1.text := ( 'patlist ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmOptionsForm.SetOptionNode(const Value: PVirtualNode);
var
  data: PAspRec;
  tab: TTabItem;
  visualObject:TStyledControl;
begin
  exit;
  FOptionNode := Value;
  data := Pointer(PByte(FOptionNode) + lenNode);
  if data.index < 0 then Exit;

  tab := FindTab(ListOptionObject[Data.index]);
  tbcOption.ActiveTab := tab;

  visualObject :=  TStyledControl(ListOptionObject[Data.index].Parent);
  rctSelector.Parent := visualObject;
  rctSelector.Align := TAlignLayout.Contents;
  //rctSelector.BoundsRect := visualObject.BoundsRect;
  //rctSelector.Position.Point := visualObject.Position.Point;


  rctSelector.BringToFront;
  scldlyt1.Repaint;
end;

procedure TfrmOptionsForm.SetOptionTree(const Value: TVirtualStringTreeAspect);
var
  i: Integer;
begin
  FOptionTree := Value;
  tbcOption.BeginUpdate;
  for i := 0 to 60 do
  begin
    tbcOption.Add();
  end;
  tbcOption.endUpdate;
end;

procedure TfrmOptionsForm.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

procedure TfrmOptionsForm.txtCaptionOptionPainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
var
  data: PAspRec;
begin
  if FOptionNode = nil then
    Exit;
  data := Pointer(PByte(FOptionNode) + lenNode);
  txtCaptionOption.Text := TRttiEnumerationType.GetName(Data.vid);
end;

initialization

//reportMemoryLeaksOnShutdown := True;
//GlobalUseDirect2D := False;

end.
