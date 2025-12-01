unit Table.CL009;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults;

type
TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

TFindedResult = record
  PropIndex: Word;
  DataPos: Cardinal;
end;

TTeeGRD = class(VCLTee.Grid.TTeeGrid);

TLogicalCL009 = (
    Is_);
TlogicalCL009Set = set of TLogicalCL009;


TCL009Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL009_Key
       , CL009_Description
       , CL009_units
       , CL009_inn_code
       , CL009_form_id
       , CL009_package
       , CL009_permit_owner
       , CL009_form
       , CL009_permit_number
       , CL009_quantity
       , CL009_atc
       , CL009_is_narcotic
       , CL009_inn
       , CL009_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL009 = ^TRecCL009;
      TRecCL009 = record
        Key: AnsiString;
        Description: AnsiString;
        units: AnsiString;
        inn_code: AnsiString;
        form_id: AnsiString;
        package: AnsiString;
        permit_owner: AnsiString;
        form: AnsiString;
        permit_number: AnsiString;
        quantity: AnsiString;
        atc: AnsiString;
        is_narcotic: AnsiString;
        inn: AnsiString;
        Logical: TlogicalCL009Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL009;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL009;
    procedure UpdateCL009;
    procedure SaveCL009(var dataPosition: Cardinal)overload;
	procedure SaveCL009(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL009(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL009Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL009Item;
    function GetItem(Index: Integer): TCL009Item;
    procedure SetItem(Index: Integer; const Value: TCL009Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL009Item>;
    ListCL009Search: TList<TCL009Item>;
	PRecordSearch: ^TCL009Item.TRecCL009;
    ArrPropSearch: TArray<TCL009Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL009Item.TPropertyIndex>;
	VisibleColl: TCL009Item.TSetProp;
	ArrayPropOrder: TArray<TCL009Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL009Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL009: TCL009Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL009: TCL009Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL009Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function DisplayLogicalName(flagIndex: Integer): string;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode; override;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL009Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL009Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL009Item.TPropertyIndex);
    property Items[Index: Integer]: TCL009Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL009Set);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
	{NZIS_START}
	procedure ImportXMLNzis(cl000: TObject);
	{NZIS_END}
  end;

implementation
{NZIS_START}
uses
  Nzis.Nomen.baseCL000, System.Rtti;
{NZIS_END}  

{ TCL009Item }

constructor TCL009Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL009Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL009Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
var
  paramField: TParamProp;
  setPropPat: TSetProp;
  i: Integer;
  PropertyIndex: TPropertyIndex;
begin
  i := 0;
  for paramField in SetOfProp do
  begin
    PropertyIndex := TPropertyIndex(byte(paramField));
    Include(Self.PRecord.setProp, PropertyIndex);
    //case PropertyIndex of
      //PatientNew_EGN: Self.PRecord.EGN := arrstr[i];
    //end;
    inc(i);
  end;
end;

function TCL009Item.GetCollType: TCollectionsType;
begin
  Result := ctCL009;
end;

function TCL009Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TCL009Item.InsertCL009;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL009;
  pCardinalData := pointer(PByte(buf));
  FPosMetaData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 4);
  FLenMetaData := pCardinalData^;
  metaPosition :=  FPosMetaData + FLenMetaData;

  pCardinalData := pointer(PByte(buf) + 8);
  FPosData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 12);
  FLenData := pCardinalData^;
  dataPosition :=  FPosData + FLenData;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toInsert, FVersion, metaPosition + 4);
  case FVersion of
    0:
    begin
      pWordData := pointer(PByte(buf) + metaPosition);
      pWordData^  := word(CollType);
      pWordData := pointer(PByte(buf) + metaPosition + 2);
      pWordData^  := FVersion;
      inc(metaPosition, 4);
	  Self.DataPos := metaPosition;
	  
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            CL009_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL009_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL009_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL009_inn_code: SaveData(PRecord.inn_code, PropPosition, metaPosition, dataPosition);
            CL009_form_id: SaveData(PRecord.form_id, PropPosition, metaPosition, dataPosition);
            CL009_package: SaveData(PRecord.package, PropPosition, metaPosition, dataPosition);
            CL009_permit_owner: SaveData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL009_form: SaveData(PRecord.form, PropPosition, metaPosition, dataPosition);
            CL009_permit_number: SaveData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL009_quantity: SaveData(PRecord.quantity, PropPosition, metaPosition, dataPosition);
            CL009_atc: SaveData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL009_is_narcotic: SaveData(PRecord.is_narcotic, PropPosition, metaPosition, dataPosition);
            CL009_inn: SaveData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL009_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          SaveNull(metaPosition);
        end;
      end;
      pCardinalData := pointer(PByte(buf) + 4);
      pCardinalData^  := metaPosition - FPosMetaData;
      pCardinalData := pointer(PByte(buf) + 12);
      pCardinalData^  := dataPosition - FPosData;
    end;
  end;
end;

function  TCL009Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL009Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL009Item;
begin
  Result := True;
  for i := 0 to Length(TCL009Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL009Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL009Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL009_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL009_Key), cot);
            CL009_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL009_Description), cot);
            CL009_units: Result := IsFinded(ATempItem.PRecord.units, buf, FPosDataADB, word(CL009_units), cot);
            CL009_inn_code: Result := IsFinded(ATempItem.PRecord.inn_code, buf, FPosDataADB, word(CL009_inn_code), cot);
            CL009_form_id: Result := IsFinded(ATempItem.PRecord.form_id, buf, FPosDataADB, word(CL009_form_id), cot);
            CL009_package: Result := IsFinded(ATempItem.PRecord.package, buf, FPosDataADB, word(CL009_package), cot);
            CL009_permit_owner: Result := IsFinded(ATempItem.PRecord.permit_owner, buf, FPosDataADB, word(CL009_permit_owner), cot);
            CL009_form: Result := IsFinded(ATempItem.PRecord.form, buf, FPosDataADB, word(CL009_form), cot);
            CL009_permit_number: Result := IsFinded(ATempItem.PRecord.permit_number, buf, FPosDataADB, word(CL009_permit_number), cot);
            CL009_quantity: Result := IsFinded(ATempItem.PRecord.quantity, buf, FPosDataADB, word(CL009_quantity), cot);
            CL009_atc: Result := IsFinded(ATempItem.PRecord.atc, buf, FPosDataADB, word(CL009_atc), cot);
            CL009_is_narcotic: Result := IsFinded(ATempItem.PRecord.is_narcotic, buf, FPosDataADB, word(CL009_is_narcotic), cot);
            CL009_inn: Result := IsFinded(ATempItem.PRecord.inn, buf, FPosDataADB, word(CL009_inn), cot);
            CL009_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL009_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL009Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexCL009: TCL009Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL009Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCL009 := Low(TCL009Item.TPropertyIndex) to High(TCL009Item.TPropertyIndex) do
  begin
    if not (propindexCL009 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL009);
      dataCmdProp.vid := vvCL009;
    end;
    self.FillPropCL009(propindexCL009, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL009Item.FillPropCL009(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL009_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL009_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL009_units:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.units, lenStr);
              stream.Read(Self.PRecord.units[1], lenStr);
            end;
            CL009_inn_code:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.inn_code, lenStr);
              stream.Read(Self.PRecord.inn_code[1], lenStr);
            end;
            CL009_form_id:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.form_id, lenStr);
              stream.Read(Self.PRecord.form_id[1], lenStr);
            end;
            CL009_package:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.package, lenStr);
              stream.Read(Self.PRecord.package[1], lenStr);
            end;
            CL009_permit_owner:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.permit_owner, lenStr);
              stream.Read(Self.PRecord.permit_owner[1], lenStr);
            end;
            CL009_form:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.form, lenStr);
              stream.Read(Self.PRecord.form[1], lenStr);
            end;
            CL009_permit_number:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.permit_number, lenStr);
              stream.Read(Self.PRecord.permit_number[1], lenStr);
            end;
            CL009_quantity:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.quantity, lenStr);
              stream.Read(Self.PRecord.quantity[1], lenStr);
            end;
            CL009_atc:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.atc, lenStr);
              stream.Read(Self.PRecord.atc[1], lenStr);
            end;
            CL009_is_narcotic:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.is_narcotic, lenStr);
              stream.Read(Self.PRecord.is_narcotic[1], lenStr);
            end;
            CL009_inn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.inn, lenStr);
              stream.Read(Self.PRecord.inn[1], lenStr);
            end;
            CL009_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL009Item.SaveCL009(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL009(dataPosition);
end;

procedure TCL009Item.SaveCL009(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL009;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, dataPosition);
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          SaveHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            CL009_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL009_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL009_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL009_inn_code: SaveData(PRecord.inn_code, PropPosition, metaPosition, dataPosition);
            CL009_form_id: SaveData(PRecord.form_id, PropPosition, metaPosition, dataPosition);
            CL009_package: SaveData(PRecord.package, PropPosition, metaPosition, dataPosition);
            CL009_permit_owner: SaveData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL009_form: SaveData(PRecord.form, PropPosition, metaPosition, dataPosition);
            CL009_permit_number: SaveData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL009_quantity: SaveData(PRecord.quantity, PropPosition, metaPosition, dataPosition);
            CL009_atc: SaveData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL009_is_narcotic: SaveData(PRecord.is_narcotic, PropPosition, metaPosition, dataPosition);
            CL009_inn: SaveData(PRecord.inn, PropPosition, metaPosition, dataPosition);
            CL009_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

procedure TCL009Item.UpdateCL009;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL009;
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          UpdateHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            CL009_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL009_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL009_units: UpdateData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL009_inn_code: UpdateData(PRecord.inn_code, PropPosition, metaPosition, dataPosition);
            CL009_form_id: UpdateData(PRecord.form_id, PropPosition, metaPosition, dataPosition);
            CL009_package: UpdateData(PRecord.package, PropPosition, metaPosition, dataPosition);
            CL009_permit_owner: UpdateData(PRecord.permit_owner, PropPosition, metaPosition, dataPosition);
            CL009_form: UpdateData(PRecord.form, PropPosition, metaPosition, dataPosition);
            CL009_permit_number: UpdateData(PRecord.permit_number, PropPosition, metaPosition, dataPosition);
            CL009_quantity: UpdateData(PRecord.quantity, PropPosition, metaPosition, dataPosition);
            CL009_atc: UpdateData(PRecord.atc, PropPosition, metaPosition, dataPosition);
            CL009_is_narcotic: UpdateData(PRecord.is_narcotic, PropPosition, metaPosition, dataPosition);
            CL009_inn: UpdateData(PRecord.inn, PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

{ TCL009Coll }

function TCL009Coll.AddItem(ver: word): TCL009Item;
begin
  Result := TCL009Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL009Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL009Item;
begin
  ItemForSearch := TCL009Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL009Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
var
  run: PVirtualNode;
  data: PAspRec;
begin
  VisibleColl := [];

  run := RootNode.FirstChild;
  while run <> nil do
  begin
    data := PAspRec(PByte(run) + lenNode);

    if run.CheckState = csCheckedNormal then
      Include(VisibleColl, TCL009Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL009Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL009Root, 0, NodeRoot , amAddChildLast, result, linkPos);
  linkOptions.AddNewNode(vvOptionSearchGrid, 0, Result , amAddChildLast, vOptionSearchGrid, linkPos);
  linkOptions.AddNewNode(vvOptionSearchCot, 0, Result , amAddChildLast, vOptionSearchCOT, linkPos);

  vOptionSearchGrid.CheckType := ctTriStateCheckBox;

  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i + 1;
	  run.CheckType := ctCheckBox;
      run.CheckState := csCheckedNormal;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;  
end;

procedure TCL009Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL009Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (CL009_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_Key))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_Description))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_units in tempItem.PRecord.setProp) and (tempItem.PRecord.units <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_units))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_inn_code in tempItem.PRecord.setProp) and (tempItem.PRecord.inn_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_inn_code))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_form_id in tempItem.PRecord.setProp) and (tempItem.PRecord.form_id <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_form_id))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_package in tempItem.PRecord.setProp) and (tempItem.PRecord.package <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_package))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_permit_owner in tempItem.PRecord.setProp) and (tempItem.PRecord.permit_owner <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_permit_owner))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_form in tempItem.PRecord.setProp) and (tempItem.PRecord.form <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_form))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_permit_number in tempItem.PRecord.setProp) and (tempItem.PRecord.permit_number <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_permit_number))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_quantity in tempItem.PRecord.setProp) and (tempItem.PRecord.quantity <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_quantity))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_atc in tempItem.PRecord.setProp) and (tempItem.PRecord.atc <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_atc))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_is_narcotic in tempItem.PRecord.setProp) and (tempItem.PRecord.is_narcotic <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_is_narcotic))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_inn in tempItem.PRecord.setProp) and (tempItem.PRecord.inn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL009_inn))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL009_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL009_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TCL009Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL009Item.Create(nil);
  ListCL009Search := TList<TCL009Item>.Create;
  ListForFinder := TList<TCL009Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL009Coll.destroy;
begin
  FreeAndNil(ListCL009Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL009Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL009Item.TPropertyIndex(propIndex) of
    CL009_Key: Result := 'Key';
    CL009_Description: Result := 'Description';
    CL009_units: Result := 'units';
    CL009_inn_code: Result := 'inn_code';
    CL009_form_id: Result := 'form_id';
    CL009_package: Result := 'package';
    CL009_permit_owner: Result := 'permit_owner';
    CL009_form: Result := 'form';
    CL009_permit_number: Result := 'permit_number';
    CL009_quantity: Result := 'quantity';
    CL009_atc: Result := 'atc';
    CL009_is_narcotic: Result := 'is_narcotic';
    CL009_inn: Result := 'inn';
    CL009_Logical: Result := 'Logical';
  end;
end;

function TCL009Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL009Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
var
  FieldCollOptionNode, run: PVirtualNode;
  pSource, pTarget: PVirtualNode;
begin
  inherited;
  if linkOptions = nil then Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionGridNode;
  run := FieldCollOptionNode.FirstChild;
  pSource := nil;
  pTarget := nil;
  while run <> nil do
  begin
    if run.Index = NewPos - 1 then
    begin
      pTarget := run;
    end;
    if run.index = OldPos - 1 then
    begin
      pSource := run;
    end;
    run := run.NextSibling;
  end;

  if pTarget = nil then Exit;
  if pSource = nil then Exit;
  //ShowMessage(Format('pSource = %d, pTarget = %d', [pSource.Index, pTarget.Index]));
  if pSource.Index < pTarget.Index then
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertAfter, False);
  end
  else
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertBefore, False);
  end;
  run := FieldCollOptionNode.FirstChild;
  while run <> nil do
  begin
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end; 
end;


function TCL009Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 14;
end;

function TCL009Coll.FindRootCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  PosLinkData: Cardinal;
  Run: PVirtualNode;
  data: PAspRec;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(linkOptions.Buf));
  PosLinkData := pCardinalData^;

  while linkPos <= PosLinkData do
  begin
    Run := pointer(PByte(linkOptions.Buf) + linkpos);
    data := Pointer(PByte(Run)+ lenNode);
    if data.vid = vvCL009Root then
    begin
      Result := Run;
	  data := Pointer(PByte(Result)+ lenNode);
      data.DataPos := Cardinal(Self);
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
  if Result <> nil then
  begin
    data := Pointer(PByte(Result)+ lenNode);
    data.DataPos := Cardinal(Self);
  end;
end;

function TCL009Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchCot: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TCL009Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();

  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TCL009Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  run, vOptionSearchGrid, vOptionSearchCOT, vRootPregOptions: PVirtualNode;
  i: Integer;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  if vRootPregOptions = nil then
    vRootPregOptions := CreateRootCollOptionNode;
  vOptionSearchGrid := nil;
  vOptionSearchCOT := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: vOptionSearchGrid := run;
      vvOptionSearchCot: vOptionSearchCOT := run;
    end;

    run := run.NextSibling;
  end;
  if vOptionSearchGrid = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchGrid, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;
  if vOptionSearchCOT = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchCot, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;

  Result := vOptionSearchGrid;
  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;
end;

procedure TCL009Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL009: TCL009Item;
  ACol: Integer;
  prop: TCL009Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL009 := Items[ARow];
  prop := TCL009Item.TPropertyIndex(ACol);
  if Assigned(CL009.PRecord) and (prop in CL009.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL009, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL009, AValue);
  end;
end;

procedure TCL009Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TCL009Item.TPropertyIndex;
begin
  inherited;
 
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;
  try
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;

  GetCellFromMap(ArrayPropOrderSearchOptions[AColumn.Index], RowSelect, TempItem, AValue);
end;

procedure TCL009Coll.GetCellFromRecord(propIndex: word; CL009: TCL009Item; var AValue: String);
var
  str: string;
begin
  case TCL009Item.TPropertyIndex(propIndex) of
    CL009_Key: str := (CL009.PRecord.Key);
    CL009_Description: str := (CL009.PRecord.Description);
    CL009_units: str := (CL009.PRecord.units);
    CL009_inn_code: str := (CL009.PRecord.inn_code);
    CL009_form_id: str := (CL009.PRecord.form_id);
    CL009_package: str := (CL009.PRecord.package);
    CL009_permit_owner: str := (CL009.PRecord.permit_owner);
    CL009_form: str := (CL009.PRecord.form);
    CL009_permit_number: str := (CL009.PRecord.permit_number);
    CL009_quantity: str := (CL009.PRecord.quantity);
    CL009_atc: str := (CL009.PRecord.atc);
    CL009_is_narcotic: str := (CL009.PRecord.is_narcotic);
    CL009_inn: str := (CL009.PRecord.inn);
    CL009_Logical: str := CL009.Logical08ToStr(TLogicalData08(CL009.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL009Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL009Item;
  ACol: Integer;
  prop: TCL009Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TCL009Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL009Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL009Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL009Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL009Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL009: TCL009Item;
  ACol: Integer;
  prop: TCL009Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL009 := ListCL009Search[ARow];
  prop := TCL009Item.TPropertyIndex(ACol);
  if Assigned(CL009.PRecord) and (prop in CL009.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL009, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL009, AValue);
  end;
end;

function TCL009Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL009;
end;

function TCL009Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL009Del;
end;

procedure TCL009Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL009: TCL009Item;
  prop: TCL009Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL009 := Items[ARow];
  prop := TCL009Item.TPropertyIndex(ACol);
  if Assigned(CL009.PRecord) and (prop in CL009.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL009, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL009, AFieldText);
  end;
end;

procedure TCL009Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL009: TCL009Item; var AValue: String);
var
  str: string;
  len: Word;
  int: PInt;
  wrd: PWord;
  bt: PByte;
  pstr: pchar;
  pDbl: PDouble;
  pbl: PBoolean;
begin
  case TCL009Item.TPropertyIndex(propIndex) of
    CL009_Key: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_Description: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_units: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_inn_code: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_form_id: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_package: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_permit_owner: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_form: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_permit_number: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_quantity: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_atc: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_is_narcotic: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_inn: str :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL009_Logical: str :=  CL009.Logical08ToStr(CL009.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL009Coll.GetItem(Index: Integer): TCL009Item;
begin
  Result := TCL009Item(inherited GetItem(Index));
end;


procedure TCL009Coll.IndexValue(propIndex: TCL009Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL009Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL009_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL009_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_units:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_inn_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_form_id:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_package:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_permit_owner:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_form:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_permit_number:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_quantity:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_atc:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_is_narcotic:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL009_inn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
    end;
  end;
end;

procedure TCL009Coll.IndexValueListNodes(propIndex: TCL009Item.TPropertyIndex);
begin

end;

function TCL009Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL009Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TCL009Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL009Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL009Item.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(field, -1, Tempitem, value);
    Tempitem.Free;
  end
  else
  begin
    Tempitem := Self.Items[index];
    if Assigned(Tempitem.PRecord) then
    begin
      GetCellFromRecord(field, Tempitem, value);
    end
    else
    begin
      GetCellFromMap(field, index, Tempitem, value);
    end;
  end;
end;

{=== TEXT SEARCH HANDLER ===}
procedure TCL009Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL009Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL009Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL009Item.TPropertyIndex(Field) of
CL009_Key: ListForFinder[0].PRecord.Key := AText;
    CL009_Description: ListForFinder[0].PRecord.Description := AText;
    CL009_units: ListForFinder[0].PRecord.units := AText;
    CL009_inn_code: ListForFinder[0].PRecord.inn_code := AText;
    CL009_form_id: ListForFinder[0].PRecord.form_id := AText;
    CL009_package: ListForFinder[0].PRecord.package := AText;
    CL009_permit_owner: ListForFinder[0].PRecord.permit_owner := AText;
    CL009_form: ListForFinder[0].PRecord.form := AText;
    CL009_permit_number: ListForFinder[0].PRecord.permit_number := AText;
    CL009_quantity: ListForFinder[0].PRecord.quantity := AText;
    CL009_atc: ListForFinder[0].PRecord.atc := AText;
    CL009_is_narcotic: ListForFinder[0].PRecord.is_narcotic := AText;
    CL009_inn: ListForFinder[0].PRecord.inn := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL009Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL009Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL009Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL009Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL009Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL009Item.TPropertyIndex(Field) of
    CL009_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL009(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL009(logIndex))   
    end;
  end;
end;


procedure TCL009Coll.OnSetTextSearchLog(Log: TlogicalCL009Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL009Coll.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  ApplyVisibilityFromTree(FieldCollOptionNode);
  run := FieldCollOptionNode.FirstChild;

  while run <> nil do
  begin
    Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy - 1);
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end;

end;

function TCL009Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL009Item.TPropertyIndex(propIndex) of
    CL009_Key: Result := actAnsiString;
    CL009_Description: Result := actAnsiString;
    CL009_units: Result := actAnsiString;
    CL009_inn_code: Result := actAnsiString;
    CL009_form_id: Result := actAnsiString;
    CL009_package: Result := actAnsiString;
    CL009_permit_owner: Result := actAnsiString;
    CL009_form: Result := actAnsiString;
    CL009_permit_number: Result := actAnsiString;
    CL009_quantity: Result := actAnsiString;
    CL009_atc: Result := actAnsiString;
    CL009_is_narcotic: Result := actAnsiString;
    CL009_inn: Result := actAnsiString;
    CL009_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL009Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL009Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL009: TCL009Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL009 := Items[ARow];
  if not Assigned(CL009.PRecord) then
  begin
    New(CL009.PRecord);
    CL009.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL009Item.TPropertyIndex(ACol) of
      CL009_Key: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_Description: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_units: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_inn_code: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_form_id: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_package: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_permit_owner: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_form: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_permit_number: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_quantity: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_atc: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_is_narcotic: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL009_inn: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL009.PRecord.setProp, TCL009Item.TPropertyIndex(ACol));
    if CL009.PRecord.setProp = [] then
    begin
      Dispose(CL009.PRecord);
      CL009.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL009.PRecord.setProp, TCL009Item.TPropertyIndex(ACol));
  case TCL009Item.TPropertyIndex(ACol) of
    CL009_Key: CL009.PRecord.Key := AValue;
    CL009_Description: CL009.PRecord.Description := AValue;
    CL009_units: CL009.PRecord.units := AValue;
    CL009_inn_code: CL009.PRecord.inn_code := AValue;
    CL009_form_id: CL009.PRecord.form_id := AValue;
    CL009_package: CL009.PRecord.package := AValue;
    CL009_permit_owner: CL009.PRecord.permit_owner := AValue;
    CL009_form: CL009.PRecord.form := AValue;
    CL009_permit_number: CL009.PRecord.permit_number := AValue;
    CL009_quantity: CL009.PRecord.quantity := AValue;
    CL009_atc: CL009.PRecord.atc := AValue;
    CL009_is_narcotic: CL009.PRecord.is_narcotic := AValue;
    CL009_inn: CL009.PRecord.inn := AValue;
    CL009_Logical: CL009.PRecord.Logical := tlogicalCL009Set(CL009.StrToLogical08(AValue));
  end;
end;

procedure TCL009Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL009: TCL009Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL009 := Items[ARow];
  if not Assigned(CL009.PRecord) then
  begin
    New(CL009.PRecord);
    CL009.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL009Item.TPropertyIndex(ACol) of
      CL009_Key: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_Description: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_units: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_inn_code: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_form_id: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_package: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_permit_owner: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_form: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_permit_number: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_quantity: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_atc: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_is_narcotic: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL009_inn: isOld :=  CL009.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL009.PRecord.setProp, TCL009Item.TPropertyIndex(ACol));
    if CL009.PRecord.setProp = [] then
    begin
      Dispose(CL009.PRecord);
      CL009.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL009.PRecord.setProp, TCL009Item.TPropertyIndex(ACol));
  case TCL009Item.TPropertyIndex(ACol) of
    CL009_Key: CL009.PRecord.Key := AFieldText;
    CL009_Description: CL009.PRecord.Description := AFieldText;
    CL009_units: CL009.PRecord.units := AFieldText;
    CL009_inn_code: CL009.PRecord.inn_code := AFieldText;
    CL009_form_id: CL009.PRecord.form_id := AFieldText;
    CL009_package: CL009.PRecord.package := AFieldText;
    CL009_permit_owner: CL009.PRecord.permit_owner := AFieldText;
    CL009_form: CL009.PRecord.form := AFieldText;
    CL009_permit_number: CL009.PRecord.permit_number := AFieldText;
    CL009_quantity: CL009.PRecord.quantity := AFieldText;
    CL009_atc: CL009.PRecord.atc := AFieldText;
    CL009_is_narcotic: CL009.PRecord.is_narcotic := AFieldText;
    CL009_inn: CL009.PRecord.inn := AFieldText;
    CL009_Logical: CL009.PRecord.Logical := tlogicalCL009Set(CL009.StrToLogical08(AFieldText));
  end;
end;

procedure TCL009Coll.SetItem(Index: Integer; const Value: TCL009Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL009Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL009Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL009Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL009_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL009Search.Add(self.Items[i]);
  end;
end;
      CL009_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_units:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_inn_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_form_id:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_package:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_permit_owner:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_form:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_permit_number:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_quantity:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_atc:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_is_narcotic:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
      CL009_inn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL009Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL009Coll.ShowGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCell;
  TVirtualModeData(Grid.Data).OnSetValue:=self.SetCell;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL009Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL009Item>);
var
  i: word;

begin
  ListForFinder := LST;
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, LST.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellList;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL009Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL009Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL009Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
end;

procedure TCL009Coll.SortByIndexAnsiString;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I].IndexAnsiStr1) < (Items[P].IndexAnsiStr1) do Inc(I);
        while (Items[J].IndexAnsiStr1) > (Items[P].IndexAnsiStr1) do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TCL009Coll.SortByIndexInt;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I]).IndexInt < (Items[P]).IndexInt do Inc(I);
        while (Items[J]).IndexInt > (Items[P]).IndexInt do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TCL009Coll.SortByIndexWord;
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while (Items[I]).IndexWord < (Items[P]).IndexWord do Inc(I);
        while (Items[J]).IndexWord > (Items[P]).IndexWord do Dec(J);
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TCL009Coll.SortByIndexValue(propIndex: TCL009Item.TPropertyIndex);
begin
  case propIndex of
    CL009_Key: SortByIndexAnsiString;
      CL009_Description: SortByIndexAnsiString;
      CL009_units: SortByIndexAnsiString;
      CL009_inn_code: SortByIndexAnsiString;
      CL009_form_id: SortByIndexAnsiString;
      CL009_package: SortByIndexAnsiString;
      CL009_permit_owner: SortByIndexAnsiString;
      CL009_form: SortByIndexAnsiString;
      CL009_permit_number: SortByIndexAnsiString;
      CL009_quantity: SortByIndexAnsiString;
      CL009_atc: SortByIndexAnsiString;
      CL009_is_narcotic: SortByIndexAnsiString;
      CL009_inn: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL009Coll.ImportXMLNzis(cl000: TObject);
var
  Acl000: TCL000EntryCollection;
  i, j: integer;
  TempItem: TCL009Item;
  entry: TCL000EntryItem;
  idx: array of integer;
  propIdx: TCL009Item.TPropertyIndex;
  xmlName: string;
begin
  Acl000 := TCL000EntryCollection(cl000);

  // --- Build index mapping between XML meta fields and DDL properties ---
  SetLength(idx, 0);
  j := 0;

  for propIdx := Low(TCL009Item.TPropertyIndex) to High(TCL009Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    // Skip technical
    if SameText(propName, 'CL009_Key') then Continue;
    if SameText(propName, 'CL009_Description') then Continue;
    if SameText(propName, 'CL009_Logical') then Continue;

    // Remove prefix e.g. "CL000_"
    xmlName := propName.Substring(6);

    // Convert property name to XML name (replace "_" with " ")
    xmlName := xmlName.Replace('_', ' ');

    // Find matching meta-field index
    for i := 0 to Acl000.FieldsNames.Count - 1 do
    begin
      if SameText(Acl000.FieldsNames[i], xmlName) or SameText(Acl000.FieldsNames[i], propName.Substring(6)) then
      begin
        SetLength(idx, Length(idx)+1);
        idx[High(idx)] := i;
        Break;
      end;
    end;
  end;

  // --- Insert rows from XML into the generated collection ---
  for i := 0 to Acl000.Count - 1 do
  begin
    entry := Acl000.Items[i];
    TempItem := TCL009Item(Self.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

    // Key
    TempItem.PRecord.Key := entry.Key;
    Include(TempItem.PRecord.setProp, CL009_Key);

    // Description
    TempItem.PRecord.Description := entry.Descr;
    Include(TempItem.PRecord.setProp, CL009_Description);

    j := 0;

    // units
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.units := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_units);
    end;
    Inc(j);

    // inn_code
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.inn_code := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_inn_code);
    end;
    Inc(j);

    // form_id
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.form_id := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_form_id);
    end;
    Inc(j);

    // package
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.package := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_package);
    end;
    Inc(j);

    // permit_owner
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.permit_owner := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_permit_owner);
    end;
    Inc(j);

    // form
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.form := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_form);
    end;
    Inc(j);

    // permit_number
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.permit_number := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_permit_number);
    end;
    Inc(j);

    // quantity
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.quantity := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_quantity);
    end;
    Inc(j);

    // atc
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.atc := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_atc);
    end;
    Inc(j);

    // is_narcotic
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.is_narcotic := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_is_narcotic);
    end;
    Inc(j);

    // inn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      TempItem.PRecord.inn := entry.FMetaDataFields[idx[j]].Value;
      Include(TempItem.PRecord.setProp, CL009_inn);
    end;
    Inc(j);

    TempItem.InsertCL009;
    Self.streamComm.Len := Self.streamComm.Size;
    Self.cmdFile.CopyFrom(Self.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;
{NZIS_END}

end.