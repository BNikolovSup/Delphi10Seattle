unit Nzis.Nomen.baseCL000;

interface
uses
  System.Generics.Collections, system.Classes, system.SysUtils,
  SuperObject, VirtualTrees, Tee.Grid.Columns, Tee.GridData.Strings,
  VCLTee.Control, VCLTee.Grid, Tee.Grid.CSV, Tee.Grid, aspects.collections,
  Vcl.dialogs, forms,
  table.cl024, Table.CL038, table.CL142, table.Cl088, Table.CL132,
  Table.CL139, table.cl134, Table.CL022, Table.CL037, table.cl006,
  Table.CL144, Table.NomenNzis, RealObj.NzisNomen;

type

  TCL000Vid= (cvNone, cvRoot, cvContent, cvHeader, cvNomen, cvEntryRoot, cvNomenID, cvEntry,
            cvEntryIndex, cvKey, cvDescription, cvMeta, cvMetaRoot, cvMetaIndex, cvMetaValue, cvMetaName);

  PSuperNodeCL009 = ^TSuperNodeCL009;
  TSuperNodeCL009 = record
    index: Integer;
    name: string;
    obj: ISuperObject;
    vid: TCL000Vid;
  end;

  PNodeRec = ^TNodeRec;
  TNodeRec = record
    index: Integer;
    vid: TCL000Vid;
  end;




  TCL000MetaItem = class(TCollectionItem)
  private
    FName: string;
    FValue: string;
    FColumn: integer;
    FvalIsEmpty: boolean;
    procedure SetColumn(const Value: integer);
    procedure SetName(const Value: string);
    procedure SetValue(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    property Name: string read FName write SetName;
    property Value: string read FValue write SetValue;
    property Column: integer read FColumn write SetColumn;
    property valIsEmpty: boolean read FvalIsEmpty;

  end;

  TCL000MetaCollection = class(TCollection)
  private
    FOwner : TComponent;
  protected
    function GetItem(Index: Integer): TCL000MetaItem;
    procedure SetItem(Index: Integer; Value: TCL000MetaItem);
  public
    constructor Create(AOwner : TComponent);
    property Items[Index: Integer]: TCL000MetaItem read GetItem write SetItem;
  end;

  TCL000EntryItem = class(TCollectionItem)
  private
    FKey: string;
    FDescr: string;


  protected

  public
    FMetaData: TList<TCL000MetaItem>;
    FMetaDataFields: TList<TCL000MetaItem>;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Key: string read FKey write FKey;
    property Descr: string read FDescr write FDescr;

  end;

  TCL000EntryCollection = class(TCollection)
  private
    FOwner : TComponent;
  protected
    function GetItem(Index: Integer): TCL000EntryItem;
    procedure SetItem(Index: Integer; Value: TCL000EntryItem);
  public
    currentType: TCL000Vid;
    TV: TVirtualStringTree;
    FieldsNames: TStringList;

    constructor Create(AOwner : TComponent);
    destructor destroy; override;
    procedure GetNodeXML(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
    function GetColNames: string;
    procedure GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
    procedure SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
    procedure ShowGrid(Grid: TTeeGrid);
    procedure GenerateDDL;

    procedure ImportCl006(TempColl: TCL006Coll);
    procedure ImportCl022(TempColl: TCL022Coll);
    procedure ImportCl024(TempColl: TCL024Coll);
    procedure ImportCl037(TempColl: TCL037Coll);
    procedure ImportCl038(TempColl: TCL038Coll);
    procedure ImportCl132(TempColl: TCL132Coll);
    procedure ImportCl134(TempColl: TCL134Coll);
    procedure ImportCl139(TempColl: TCL139Coll);
    procedure ImportCl142(TempColl: TCL142Coll);
    procedure ImportCl144(TempColl: TCL144Coll);
    procedure ImportCl088(TempColl: TCL088Coll);


    //procedure ImportCl024(ADB: TMappedFile);
//    procedure ImportCl038(ADB: TMappedFile);
//    procedure ImportCl132(ADB: TMappedFile);
//    procedure ImportCl134(ADB: TMappedFile);
//    procedure ImportCl139(ADB: TMappedFile);
//    procedure ImportCl142(ADB: TMappedFile);
//    procedure ImportCl144(ADB: TMappedFile);
    procedure ImportCl088Local(coll: TRealCL088Coll);



    procedure NenormalenRemontCl088(cl088: TCL088Item);
    class procedure ImportNomenList(ADB: TMappedFile);


    property Items[Index: Integer]: TCL000EntryItem read GetItem write SetItem;


  end;



implementation

{ TCL000EntryItem }

constructor TCL000EntryItem.Create(Collection: TCollection);
begin
  inherited;
  FMetaData  := TList<TCL000MetaItem>.Create;
  FMetaDataFields  := TList<TCL000MetaItem>.Create;
  FMetaDataFields.Count := 30;
end;

destructor TCL000EntryItem.Destroy;
begin
  FreeAndNil(FMetaData);
  FreeAndNil(FMetaDataFields);
  inherited;
end;

{ TCL000MetaCollection }

constructor TCL000MetaCollection.Create(AOwner: TComponent);
begin
  inherited Create(TCL000MetaItem);
end;

function TCL000MetaCollection.GetItem(Index: Integer): TCL000MetaItem;
begin
  Result := TCL000MetaItem(inherited GetItem(Index));
end;

procedure TCL000MetaCollection.SetItem(Index: Integer; Value: TCL000MetaItem);
begin
  inherited SetItem(Index, Value);
end;

{ TCL000EntryCollection }

constructor TCL000EntryCollection.Create(AOwner: TComponent);
begin
  inherited Create(TCL000EntryItem);
  FieldsNames := TStringList.Create;

end;

destructor TCL000EntryCollection.destroy;
begin
  FieldsNames.Free;
  inherited;
end;

procedure TCL000EntryCollection.GenerateDDL;
begin
  //
end;

procedure TCL000EntryCollection.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Entry: TCL000EntryItem;
  ACol: Integer;
  Field: TCL000MetaItem;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  if ACol = FieldsNames.Count then
  begin
    AValue := IntToStr(ARow + 1);
    Exit;
  end;



  Entry := Items[ARow];
  case ACol of
    0:
    begin
      AValue := Entry.FKey;
      Exit;
    end;
    1:
    begin
      AValue := Entry.FDescr;
      Exit;
    end;
  end;
  Field := Entry.FMetaDataFields[ACol];
  if Field= nil then Exit;
  if (acol <> 4) and (field.Name = 'cl022') then
    acol := 4;
  AValue := Field.Value;
end;

function TCL000EntryCollection.GetColNames: string;
var
  i, j: Integer;
  meta: TCL000MetaItem;
 //ls: TStringList;
begin
  //ls := TStringList.Create;
  FieldsNames.Clear;
  FieldsNames.Add('Key');
  FieldsNames.Add('Description');
  for i := 0 to Count - 1 do
  begin
    for j := 0 to Items[i].FMetaData.Count - 1 do
    begin
      meta := Items[i].FMetaData[j];
      meta.Column := FieldsNames.IndexOf(meta.FName);
      if meta.Column < 0 then
      begin
         meta.Column := FieldsNames.Add(meta.FName);
      end;
      Items[i].FMetaDataFields[meta.Column] := meta;
    end;
  end;
  Result := FieldsNames.Text;
end;

function TCL000EntryCollection.GetItem(Index: Integer): TCL000EntryItem;
begin
  Result := TCL000EntryItem(inherited GetItem(Index));
end;

procedure TCL000EntryCollection.GetNodeXML(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
var
  data, dataParent, dataChild: PSuperNodeCL009;
  vMetaName, vMetaValue: PVirtualNode;
  dataMetaName, dataMetaValue: PSuperNodeCL009;
  meta: TCL000MetaItem;
begin
  data := tv.GetNodeData(Node);

  if data.name[5]  = ':'  then  // ne e atribut
  begin
    case data.name[6] of
      'e':  //entry
      begin
        //inc(currentIndex);
        Self.Add;
        //Memo.Lines.Add('entry ' + IntToStr(currentIndex));
        currentType := cvEntry;
        data.vid := currentType;

      end;
      'm':  //meta
      begin
        //Memo.Lines.Add('meta');
        currentType := cvMeta;
        data.vid := currentType;

      end;
      'n':  //name
      begin
        if currentType in [cvMeta, cvMetaValue] then
        begin
          //Memo.Lines.Add('name');


          case currentType of
            cvMeta:
            begin
              dataChild := TV.GetNodeData(Node.FirstChild);
              meta  := TCL000MetaItem.Create(nil);
              meta.Name := Trim(dataChild.obj.AsString);
              Self.Items[Count - 1].FMetaData.Add(meta);

            end;
            cvMetaValue:
            begin
              dataChild := TV.GetNodeData(Node.FirstChild);
              if Self.Items[Count - 1].FMetaData.Last.Name = '' then
              begin
                meta  := Self.Items[Count - 1].FMetaData.Last;
                meta.Name := Trim(dataChild.obj.AsString);
              end
              else
              begin
                meta  := TCL000MetaItem.Create(nil);
                meta.Name := Trim(dataChild.obj.AsString);
                Self.Items[Count - 1].FMetaData.Add(meta);
              end;
            end;
          end;
          currentType := cvMetaName;
          data.vid := currentType;
        end;
      end;
      'v':  //value
      begin
        if currentType in [cvMeta, cvMetaName] then
        begin
          //Memo.Lines.Add('value');


          case currentType of
            cvMeta:
            begin
              dataChild := TV.GetNodeData(Node.FirstChild);
              meta  := TCL000MetaItem.Create(nil);
              meta.Value := Trim(dataChild.obj.AsString);
              Self.Items[Count - 1].FMetaData.Add(meta);

            end;
            cvMetaName:
            begin
              dataChild := TV.GetNodeData(Node.FirstChild);
              if (Self.Items[Count - 1].FMetaData.Last.FValue = '') and (Self.Items[Count - 1].FMetaData.Last.valIsEmpty) then
              begin
                meta  := Self.Items[Count - 1].FMetaData.Last;
                meta.Value := Trim(dataChild.obj.AsString);
              end
              else
              begin
                meta  := TCL000MetaItem.Create(nil);
                meta.Value := Trim(dataChild.obj.AsString);
                Self.Items[Count - 1].FMetaData.Add(meta);
              end;
            end;
          end;
          currentType := cvMetaValue;
          data.vid := currentType;
        end;

      end;
      'k':  //key
      begin
        //if currentType in [cvMeta, cvMetaName] then
        begin
          //Memo.Lines.Add('key');
          dataChild := TV.GetNodeData(Node.FirstChild);
          Self.Items[Count - 1].Key := Trim(dataChild.obj.AsString);
          currentType := cvKey;
          data.vid := currentType;
        end;

      end;
      'd':  //description
      begin
        //if currentType in [cvMeta, cvMetaName] then
        begin
          //Memo.Lines.Add('description');
          dataChild := TV.GetNodeData(Node.FirstChild);
          Self.Items[Count - 1].Descr := Trim(dataChild.obj.AsString);
          currentType := cvDescription;
          data.vid := currentType;
        end;

      end;
    end;
  end
  else
  begin
    dataParent := TV.GetNodeData(Node.Parent);
    if dataParent = nil then Exit;

    case (dataParent.name[6]) of
      'e':  //entry
      begin
        if currentType <> cvEntry then
        begin
          //inc(currentIndex);
          Self.Add;
          //Memo.Lines.Add('entry ' + IntToStr(currentIndex));
          currentType := cvEntryIndex;
          data.vid := currentType;
        end
        else
        begin
          currentType := cvEntryIndex;
          data.vid := currentType;
        end;

      end;
    end;

  end;
end;

procedure TCL000EntryCollection.ImportCl006(TempColl: TCL006Coll);
var
  i: integer;
  j: word;
  TempItem: TCL006Item;
  entry: TCL000EntryItem;
  idx: array[0..4] of integer;
begin
  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('nhif code');
  idx[2] := self.FieldsNames.IndexOf('clinical_speciality');
  idx[3] := self.FieldsNames.IndexOf('nhif name');
  idx[4] := self.FieldsNames.IndexOf('role');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL006Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL006_Key, CL006_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL006_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.nhif_code := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL006_nhif_code);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.clinical_speciality := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL006_clinical_speciality);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.nhif_name := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL006_nhif_name);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.role := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL006_role);
    end;



    TempItem.InsertCL006;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl022(TempColl: TCL022Coll);
var
  i: integer;
  j: word;
  TempItem: TCL022Item;
  entry: TCL000EntryItem;
  idx: array[0..5] of integer;
begin
  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('achi block');
  idx[2] := self.FieldsNames.IndexOf('nhif_package');
  idx[3] := self.FieldsNames.IndexOf('achi code');
  idx[4] := self.FieldsNames.IndexOf('achi chapter');
  idx[5] := self.FieldsNames.IndexOf('nhif code');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL022Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL022_Key, CL022_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL022_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.achi_block := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL022_achi_block);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.nhif_package := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL022_nhif_package);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.achi_code := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL022_achi_code);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.achi_chapter := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL022_achi_chapter);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.nhif_code := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL022_nhif_code);
    end;


    TempItem.InsertCL022;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl024(TempColl: TCL024Coll);
var
  i: integer;
  j: word;
  TempItem: TCL024Item;
  entry: TCL000EntryItem;
  idx: array[0..6] of integer;
begin
  idx[0] := self.FieldsNames.IndexOf('ucum');
  idx[1] := self.FieldsNames.IndexOf('cl032');
  idx[2] := self.FieldsNames.IndexOf('cl028');
  idx[3] := self.FieldsNames.IndexOf('old key');
  idx[4] := self.FieldsNames.IndexOf('cl022');
  idx[5] := self.FieldsNames.IndexOf('loinc');
  idx[6] := self.FieldsNames.IndexOf('units');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL024Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL024_Key, CL024_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.ucum := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL024_ucum);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.cl032 := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL024_cl032);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.cl028 := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL024_cl028);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.old_key := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL024_old_key);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.cl022 := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL024_cl022);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.loinc := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL024_loinc);
    end;
    if Entry.FMetaDataFields[idx[6]] <> nil then
    begin
      TempItem.PRecord.units := Entry.FMetaDataFields[idx[6]].FValue;
      include(TempItem.PRecord.setProp, CL024_units);
    end;

    TempItem.InsertCL024;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl037(TempColl: TCL037Coll);
var
  i: integer;
  j: word;
  TempItem: TCL037Item;
  entry: TCL000EntryItem;
  idx: array[0..19] of integer;
begin
  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('target_disease');
  idx[2] := self.FieldsNames.IndexOf('permit_owner');
  idx[3] := self.FieldsNames.IndexOf('permit_number');
  idx[4] := self.FieldsNames.IndexOf('days_to_next_dose');
  idx[5] := self.FieldsNames.IndexOf('inn');
  idx[6] := self.FieldsNames.IndexOf('atc');
  idx[7] := self.FieldsNames.IndexOf('vaccine_group');
  idx[8] := self.FieldsNames.IndexOf('days_to_next_dose_booster');
  idx[9] := self.FieldsNames.IndexOf('mh_code');
  idx[10] := self.FieldsNames.IndexOf('number_of_doses');
  idx[11] := self.FieldsNames.IndexOf('vaccine_code_lot_number');
  idx[12] := self.FieldsNames.IndexOf('cert_text');
  idx[13] := self.FieldsNames.IndexOf('medicament');
  idx[14] := self.FieldsNames.IndexOf('permit_owner_id');
  idx[15] := self.FieldsNames.IndexOf('dose_quantity');
  idx[16] := self.FieldsNames.IndexOf('days_to_next_dose_booster_special');
  idx[17] := self.FieldsNames.IndexOf('dose_quantity_in_pack');
  idx[18] := self.FieldsNames.IndexOf('nhif_vaccine_code');
  idx[19] := self.FieldsNames.IndexOf('doses_in_pack');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL037Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL037_Key, CL037_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL037_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.target_disease := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL037_target_disease);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.permit_owner := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL037_permit_owner);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.permit_number := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL037_permit_number);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.days_to_next_dose := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL037_days_to_next_dose);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.inn := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL037_inn);
    end;
    if Entry.FMetaDataFields[idx[6]] <> nil then
    begin
      TempItem.PRecord.atc := Entry.FMetaDataFields[idx[6]].FValue;
      include(TempItem.PRecord.setProp, CL037_atc);
    end;
    if Entry.FMetaDataFields[idx[7]] <> nil then
    begin
      TempItem.PRecord.vaccine_group := Entry.FMetaDataFields[idx[7]].FValue;
      include(TempItem.PRecord.setProp, CL037_vaccine_group);
    end;
    if Entry.FMetaDataFields[idx[8]] <> nil then
    begin
      TempItem.PRecord.days_to_next_dose_booster := Entry.FMetaDataFields[idx[8]].FValue;
      include(TempItem.PRecord.setProp, CL037_days_to_next_dose_booster);
    end;
    if Entry.FMetaDataFields[idx[9]] <> nil then
    begin
      TempItem.PRecord.mh_code := Entry.FMetaDataFields[idx[9]].FValue;
      include(TempItem.PRecord.setProp, CL037_mh_code);
    end;
    if Entry.FMetaDataFields[idx[10]] <> nil then
    begin
      TempItem.PRecord.number_of_doses := Entry.FMetaDataFields[idx[10]].FValue;
      include(TempItem.PRecord.setProp, CL037_number_of_doses);
    end;
    if Entry.FMetaDataFields[idx[11]] <> nil then
    begin
      TempItem.PRecord.vaccine_code_lot_number := Entry.FMetaDataFields[idx[11]].FValue;
      include(TempItem.PRecord.setProp, CL037_vaccine_code_lot_number);
    end;
    if Entry.FMetaDataFields[idx[12]] <> nil then
    begin
      TempItem.PRecord.cert_text := Entry.FMetaDataFields[idx[12]].FValue;
      include(TempItem.PRecord.setProp, CL037_cert_text);
    end;
    if Entry.FMetaDataFields[idx[13]] <> nil then
    begin
      TempItem.PRecord.medicament := Entry.FMetaDataFields[idx[13]].FValue;
      include(TempItem.PRecord.setProp, CL037_medicament);
    end;
    if Entry.FMetaDataFields[idx[14]] <> nil then
    begin
      TempItem.PRecord.permit_owner_id := Entry.FMetaDataFields[idx[14]].FValue;
      include(TempItem.PRecord.setProp, CL037_permit_owner_id);
    end;
    if Entry.FMetaDataFields[idx[15]] <> nil then
    begin
      TempItem.PRecord.dose_quantity := Entry.FMetaDataFields[idx[15]].FValue;
      include(TempItem.PRecord.setProp, CL037_dose_quantity);
    end;
    if Entry.FMetaDataFields[idx[16]] <> nil then
    begin
      TempItem.PRecord.days_to_next_dose_booster_special := Entry.FMetaDataFields[idx[16]].FValue;
      include(TempItem.PRecord.setProp, CL037_days_to_next_dose_booster_special);
    end;
    if Entry.FMetaDataFields[idx[17]] <> nil then
    begin
      TempItem.PRecord.dose_quantity_in_pack := Entry.FMetaDataFields[idx[17]].FValue;
      include(TempItem.PRecord.setProp, CL037_dose_quantity_in_pack);
    end;
    if Entry.FMetaDataFields[idx[18]] <> nil then
    begin
      TempItem.PRecord.nhif_vaccine_code := Entry.FMetaDataFields[idx[18]].FValue;
      include(TempItem.PRecord.setProp, CL037_nhif_vaccine_code);
    end;
    if Entry.FMetaDataFields[idx[19]] <> nil then
    begin
      TempItem.PRecord.doses_in_pack := Entry.FMetaDataFields[idx[19]].FValue;
      include(TempItem.PRecord.setProp, CL037_doses_in_pack);
    end;

    TempItem.InsertCL037;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl038(TempColl: TCL038Coll);
var
  i: integer;
  j: word;
  TempItem: TCL038Item;
  entry: TCL000EntryItem;
  idx: array[0..2] of integer;
begin
  idx[0] := self.FieldsNames.IndexOf('immun_type');
  idx[1] := self.FieldsNames.IndexOf('dose_number');
  idx[2] := self.FieldsNames.IndexOf('vaccine_code');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL038Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL038_Key, CL038_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.immun_type := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL038_immun_type);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.dose_number := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL038_dose_number);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.vaccine_code := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL038_vaccine_code);
    end;


    TempItem.InsertCL038;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl088(TempColl: TCL088Coll);
var
  i: integer;
  j: word;
  TempItem: TCL088Item;

  entry: TCL000EntryItem;
  idx: array[0..9] of integer;
begin

  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('ucum');
  idx[2] := self.FieldsNames.IndexOf('cl050');
  idx[3] := self.FieldsNames.IndexOf('cl012');
  idx[4] := self.FieldsNames.IndexOf('cl028');
  idx[5] := self.FieldsNames.IndexOf('cl032');
  idx[6] := self.FieldsNames.IndexOf('cl138');
  idx[7] := self.FieldsNames.IndexOf('conclusion');
  idx[8] := self.FieldsNames.IndexOf('note');
  idx[9] := self.FieldsNames.IndexOf('cl142');


  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL088Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL088_Key, CL088_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL088_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.ucum := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL088_ucum);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.cl050 := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl050);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.cl012 := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl012);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.cl028 := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl028);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.cl032 := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl032);
    end;
    if Entry.FMetaDataFields[idx[6]] <> nil then
    begin
      TempItem.PRecord.cl138 := Entry.FMetaDataFields[idx[6]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl138);
    end;
    if Entry.FMetaDataFields[idx[7]] <> nil then
    begin
      TempItem.PRecord.conclusion := Entry.FMetaDataFields[idx[7]].FValue;
      include(TempItem.PRecord.setProp, CL088_conclusion);
    end;
    if Entry.FMetaDataFields[idx[8]] <> nil then
    begin
      TempItem.PRecord.note := Entry.FMetaDataFields[idx[8]].FValue;
      include(TempItem.PRecord.setProp, CL088_note);
    end;
    if Entry.FMetaDataFields[idx[9]] <> nil then
    begin
      TempItem.PRecord.cl142 := Entry.FMetaDataFields[idx[9]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl142);
    end;



    TempItem.InsertCL088;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;

  end;
end;

procedure TCL000EntryCollection.ImportCl088Local(coll: TRealCL088Coll);
var
  i: integer;
  j: word;
  TempItem: TCL088Item;
  entry: TCL000EntryItem;
  idx: array[0..9] of integer;
begin
  coll.FCL088New := TRealCL088Coll.Create(TRealCL088Item);

  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('ucum');
  idx[2] := self.FieldsNames.IndexOf('cl050');
  idx[3] := self.FieldsNames.IndexOf('cl012');
  idx[4] := self.FieldsNames.IndexOf('cl028');
  idx[5] := self.FieldsNames.IndexOf('cl032');
  idx[6] := self.FieldsNames.IndexOf('cl138');
  idx[7] := self.FieldsNames.IndexOf('conclusion');
  idx[8] := self.FieldsNames.IndexOf('note');
  idx[9] := self.FieldsNames.IndexOf('cl142');


  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL088Item(coll.FCL088New.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL088_Key, CL088_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL088_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.ucum := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL088_ucum);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.cl050 := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl050);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.cl012 := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl012);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.cl028 := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl028);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.cl032 := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl032);
    end;
    if Entry.FMetaDataFields[idx[6]] <> nil then
    begin
      TempItem.PRecord.cl138 := Entry.FMetaDataFields[idx[6]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl138);
    end;
    if Entry.FMetaDataFields[idx[7]] <> nil then
    begin
      TempItem.PRecord.conclusion := Entry.FMetaDataFields[idx[7]].FValue;
      include(TempItem.PRecord.setProp, CL088_conclusion);
    end;
    if Entry.FMetaDataFields[idx[8]] <> nil then
    begin
      TempItem.PRecord.note := Entry.FMetaDataFields[idx[8]].FValue;
      include(TempItem.PRecord.setProp, CL088_note);
    end;
    if Entry.FMetaDataFields[idx[9]] <> nil then
    begin
      TempItem.PRecord.cl142 := Entry.FMetaDataFields[idx[9]].FValue;
      include(TempItem.PRecord.setProp, CL088_cl142);
    end;

  end;
end;

procedure TCL000EntryCollection.ImportCl132(TempColl: TCL132Coll);
var
  i: integer;
  j: word;
  TempItem: TCL132Item;
  entry: TCL000EntryItem;
  idx: array[0..13] of integer;
begin

  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('group');
  idx[2] := self.FieldsNames.IndexOf('cl047');
  idx[3] := self.FieldsNames.IndexOf('cl136');
  idx[4] := self.FieldsNames.IndexOf('cl011');
  idx[5] := self.FieldsNames.IndexOf('event_trigger');
  idx[6] := self.FieldsNames.IndexOf('common_index');
  idx[7] := self.FieldsNames.IndexOf('min_interval');
  idx[8] := self.FieldsNames.IndexOf('max_interval');
  idx[9] := self.FieldsNames.IndexOf('min_age');
  idx[10] := self.FieldsNames.IndexOf('max_age');
  idx[11] := self.FieldsNames.IndexOf('recurring');
  idx[12] := self.FieldsNames.IndexOf('repeat_years');
  idx[13] := self.FieldsNames.IndexOf('gender');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL132Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL132_Key, CL132_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.Display_Value_EN := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL132_Display_Value_EN);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.Group := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL132_Group);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.CL047_Mapping := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL132_CL047_Mapping);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.CL136_Mapping := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL132_CL136_Mapping);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.CL011_Mapping := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL132_CL011_Mapping);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.Event_Trigger := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL132_Event_Trigger);
    end;
    if Entry.FMetaDataFields[idx[6]] <> nil then
    begin
      TempItem.PRecord.Common_index := Entry.FMetaDataFields[idx[6]].FValue;
      include(TempItem.PRecord.setProp, CL132_Common_index);
    end;
    if Entry.FMetaDataFields[idx[7]] <> nil then
    begin
      TempItem.PRecord.Min_interval_from_common_index := Entry.FMetaDataFields[idx[7]].FValue;
      include(TempItem.PRecord.setProp, CL132_Min_interval_from_common_index);
    end;
    if Entry.FMetaDataFields[idx[8]] <> nil then
    begin
      TempItem.PRecord.Max_interval_from_common_index := Entry.FMetaDataFields[idx[8]].FValue;
      include(TempItem.PRecord.setProp, CL132_Max_interval_from_common_index);
    end;
    if Entry.FMetaDataFields[idx[9]] <> nil then
    begin
      TempItem.PRecord.Age := Entry.FMetaDataFields[idx[9]].FValue;
      include(TempItem.PRecord.setProp, CL132_Age);
    end;
    if Entry.FMetaDataFields[idx[10]] <> nil then
    begin
      TempItem.PRecord.Max_Age := Entry.FMetaDataFields[idx[10]].FValue;
      include(TempItem.PRecord.setProp, CL132_Max_Age);
    end;
    if Entry.FMetaDataFields[idx[11]] <> nil then
    begin
      TempItem.PRecord.Recurring := Entry.FMetaDataFields[idx[11]].FValue;
      include(TempItem.PRecord.setProp, CL132_Recurring);
    end;
    if Entry.FMetaDataFields[idx[12]] <> nil then
    begin
      TempItem.PRecord.Repeat_Every_x_Years := Entry.FMetaDataFields[idx[12]].FValue;
      include(TempItem.PRecord.setProp, CL132_Repeat_Every_x_Years);
    end;
    if Entry.FMetaDataFields[idx[13]] <> nil then
    begin
      TempItem.PRecord.Gender := Entry.FMetaDataFields[idx[13]].FValue;
      include(TempItem.PRecord.setProp, CL132_Gender);
    end;

    TempItem.InsertCL132;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl134(TempColl: TCL134Coll);
var
  i: integer;
  j: word;
  TempItem: TCL134Item;
  entry: TCL000EntryItem;
  idx: array[0..5] of integer;
begin
  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('cl133');
  idx[2] := self.FieldsNames.IndexOf('answer_type');
  idx[3] := self.FieldsNames.IndexOf('answer_nomenclature');
  idx[4] := self.FieldsNames.IndexOf('multiple_choice');
  idx[5] := self.FieldsNames.IndexOf('cl028');


  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL134Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL134_Key, CL134_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.Display_Value_EN := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL134_Display_Value_EN);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.cl133 := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL134_cl133);
    end;
    //if Entry.FMetaDataFields[idx[2]] <> nil then // dublirana
//    begin
//      TempItem.PRecord.answer_type := Entry.FMetaDataFields[idx[2]].FValue;
//      include(TempItem.PRecord.setProp, CL134_answer_type);
//    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.answer_nomenclature := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL134_answer_nomenclature);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.multiple_choice := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL134_multiple_choice);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.cl028 := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL134_cl028);
    end;


    TempItem.InsertCL134;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl139(TempColl: TCL139Coll);
var
  i: integer;
  j: word;
  TempItem: TCL139Item;
  entry: TCL000EntryItem;
  idx: array[0..1] of integer;
  ArrNhifCode: TArray<string>;
begin
  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('cl138');

  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL139Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL139_Key, CL139_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL139_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.cl138 := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL139_cl138);
    end;


    TempItem.InsertCL139;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

procedure TCL000EntryCollection.ImportCl142(TempColl: TCL142Coll);
var
  i: integer;
  j: word;
  TempItem: TCL142Item;
  entry: TCL000EntryItem;
  idx: array[0..4] of integer;
  ArrNhifCode: TArray<string>;
begin

  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('achi_block');
  idx[2] := self.FieldsNames.IndexOf('achi_chapter');
  idx[3] := self.FieldsNames.IndexOf('achi_code');
  idx[4] := self.FieldsNames.IndexOf('nhif_code');
  //idx[5] := self.FieldsNames.IndexOf('cl048');
//  idx[6] := self.FieldsNames.IndexOf('cl006');
//  idx[7] := self.FieldsNames.IndexOf('highly');



  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    if Entry.FMetaDataFields[idx[4]].FValue <> '' then
    begin
      ArrNhifCode := Entry.FMetaDataFields[idx[4]].FValue.Split([';', ',']);
    end
    else
    begin
      SetLength(ArrNhifCode, 1);
      ArrNhifCode[0] := '';
    end;

    for j := 0 to Length(ArrNhifCode) - 1 do
    begin
      TempItem := TCL142Item(TempColl.Add);
      New(TempItem.PRecord);
      TempItem.PRecord.setProp := [CL142_Key, CL142_Description];
      TempItem.PRecord.Key := entry.FKey;
      TempItem.PRecord.Description := entry.FDescr;
      if Entry.FMetaDataFields[idx[0]] <> nil then
      begin
        TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
        include(TempItem.PRecord.setProp, CL142_DescriptionEn);
      end;
      if Entry.FMetaDataFields[idx[1]] <> nil then
      begin
        TempItem.PRecord.achi_block := Entry.FMetaDataFields[idx[1]].FValue;
        include(TempItem.PRecord.setProp, CL142_achi_block);
      end;
      if Entry.FMetaDataFields[idx[2]] <> nil then
      begin
        TempItem.PRecord.achi_chapter := Entry.FMetaDataFields[idx[2]].FValue;
        include(TempItem.PRecord.setProp, CL142_achi_chapter);
      end;
      if Entry.FMetaDataFields[idx[3]] <> nil then
      begin
        TempItem.PRecord.achi_code := Entry.FMetaDataFields[idx[3]].FValue;
        include(TempItem.PRecord.setProp, CL142_achi_code);
      end;
      if Entry.FMetaDataFields[idx[4]] <> nil then
      begin
        TempItem.PRecord.nhif_code := Trim(ArrNhifCode[j]);
        include(TempItem.PRecord.setProp, CL142_nhif_code);
      end;
      //if Entry.FMetaDataFields[idx[5]] <> nil then
//      begin
//        TempItem.PRecord.cl048 := Entry.FMetaDataFields[idx[5]].FValue;
//        include(TempItem.PRecord.setProp, CL142_cl048);
//      end;
//      if Entry.FMetaDataFields[idx[6]] <> nil then
//      begin
//        TempItem.PRecord.cl006 := Entry.FMetaDataFields[idx[6]].FValue;
//        include(TempItem.PRecord.setProp, CL142_cl006);
//      end;
//      if Entry.FMetaDataFields[idx[7]] <> nil then
//      begin
//        TempItem.PRecord.highly := Entry.FMetaDataFields[idx[7]].FValue;
//        include(TempItem.PRecord.setProp, CL142_highly);
//      end;


      TempItem.InsertCL142;
      TempColl.streamComm.Len := TempColl.streamComm.Size;
      TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
      Dispose(TempItem.PRecord);
      TempItem.PRecord := nil;
    end;
  end;
end;

procedure TCL000EntryCollection.ImportCl144(TempColl: TCL144Coll);
var
  i: integer;
  j: word;
  TempItem: TCL144Item;
  entry: TCL000EntryItem;
  idx: array[0..7] of integer;
  ArrNhifCode: TArray<string>;
begin
  idx[0] := self.FieldsNames.IndexOf('DescriptionEn');
  idx[1] := self.FieldsNames.IndexOf('units');
  idx[2] := self.FieldsNames.IndexOf('cl142');
  idx[3] := self.FieldsNames.IndexOf('cl012');
  idx[4] := self.FieldsNames.IndexOf('cl028');
  idx[5] := self.FieldsNames.IndexOf('cl138');
  idx[6] := self.FieldsNames.IndexOf('conclusion');
  idx[7] := self.FieldsNames.IndexOf('note');



  for i := 0 to self.count - 1 do
  begin
    entry := self.Items[i];
    TempItem := TCL144Item(TempColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [CL144_Key, CL144_Description];
    TempItem.PRecord.Key := entry.FKey;
    TempItem.PRecord.Description := entry.FDescr;
    if Entry.FMetaDataFields[idx[0]] <> nil then
    begin
      TempItem.PRecord.DescriptionEn := Entry.FMetaDataFields[idx[0]].FValue;
      include(TempItem.PRecord.setProp, CL144_DescriptionEn);
    end;
    if Entry.FMetaDataFields[idx[1]] <> nil then
    begin
      TempItem.PRecord.units := Entry.FMetaDataFields[idx[1]].FValue;
      include(TempItem.PRecord.setProp, CL144_units);
    end;
    if Entry.FMetaDataFields[idx[2]] <> nil then
    begin
      TempItem.PRecord.cl142 := Entry.FMetaDataFields[idx[2]].FValue;
      include(TempItem.PRecord.setProp, CL144_cl142);
    end;
    if Entry.FMetaDataFields[idx[3]] <> nil then
    begin
      TempItem.PRecord.cl012 := Entry.FMetaDataFields[idx[3]].FValue;
      include(TempItem.PRecord.setProp, CL144_cl012);
    end;
    if Entry.FMetaDataFields[idx[4]] <> nil then
    begin
      TempItem.PRecord.cl028 := Entry.FMetaDataFields[idx[4]].FValue;
      include(TempItem.PRecord.setProp, CL144_cl028);
    end;
    if Entry.FMetaDataFields[idx[5]] <> nil then
    begin
      TempItem.PRecord.cl138 := Entry.FMetaDataFields[idx[5]].FValue;
      include(TempItem.PRecord.setProp, CL144_cl138);
    end;
    if Entry.FMetaDataFields[idx[6]] <> nil then
    begin
      TempItem.PRecord.conclusion := Entry.FMetaDataFields[idx[6]].FValue;
      include(TempItem.PRecord.setProp, CL144_conclusion);
    end;
    if Entry.FMetaDataFields[idx[7]] <> nil then
    begin
      TempItem.PRecord.note := Entry.FMetaDataFields[idx[7]].FValue;
      include(TempItem.PRecord.setProp, CL144_note);
    end;
    TempItem.InsertCL144;
    TempColl.streamComm.Len := TempColl.streamComm.Size;
    TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
  end;
end;

class procedure TCL000EntryCollection.ImportNomenList(ADB: TMappedFile);
var
  ListNomenNames: TStringList;
  openDialog : TOpenDialog;
  i: integer;
  ArrStr: Tarray<string>;
  streamCmdFile: TFileStream;
  lenSave: word;

  TempItem: TNomenNzisItem;
  TempColl: TNomenNzisColl;
  pCardinalData: pcardinal;
begin
  openDialog := TOpenDialog.Create(application);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofFileMustExist];
  if openDialog.Execute then
  begin
    ListNomenNames := TStringList.Create;
    TempColl := TNomenNzisColl.Create(TNomenNzisItem);
    TempColl.Buf := ADB.Buf;
    TempColl.posData := ADB.FPosData;
    ListNomenNames.LoadFromFile(openDialog.FileName, TEncoding.UTF8);
    streamCmdFile := TFileStream.Create('d:\NomenNzis.cmd', fmOpenReadWrite);
    streamCmdFile.Position := streamCmdFile.Size;
    for i := 0 to ListNomenNames.Count - 1 do
    begin
      ArrStr := ListNomenNames[i].Split([#9]);
      TempItem := TNomenNzisItem(TempColl.Add);
      New(TempItem.PRecord);
      TempItem.PRecord.setProp := [NomenNzis_NomenName, NomenNzis_NomenID];
      TempItem.PRecord.NomenName := ArrStr[0];
      TempItem.PRecord.NomenID := ArrStr[1];


      TempItem.InsertNomenNzis;
      TempColl.streamComm.Len := TempColl.streamComm.Size;
      streamCmdFile.CopyFrom(TempColl.streamComm, 0);
      Dispose(TempItem.PRecord);
      TempItem.PRecord := nil;
    end;
  end;

  openDialog.Free;

  // после записвам на края на командния поток  FLenMetaData и  FLenData
  lensave := 10;
  streamCmdFile.Write(lensave, 2);
  pCardinalData := pointer(PByte(adb.buf) + 4);
  adb.FLenMetaData := pCardinalData^;
  streamCmdFile.Write(adb.FLenMetaData, 4);
  pCardinalData := pointer(PByte(adb.buf) + 12);
  adb.FLenData := pCardinalData^;
  streamCmdFile.Write(adb.FLenData, 4);

  // а накрая записвам в аспектската база размера на командния поток
  pCardinalData :=  pointer(PByte(adb.buf) + 36);
  pCardinalData^ := streamCmdFile.size;

  streamCmdFile.Free;
  FreeAndNil(TempColl);

end;

procedure TCL000EntryCollection.NenormalenRemontCl088(cl088: TCL088Item);
begin
  if trim (cl088.PRecord.cl050) = '38-030' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '64-121' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-226' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '65-253' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '65-263' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-265' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-266' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-360' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '66-187' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '66-281' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '68-147' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-337' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-338' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '74-339' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '75-175' then  cl088.PRecord.cl028 := ' ';
  if trim (cl088.PRecord.cl050) = '76-168' then  cl088.PRecord.cl028 := ' ';
  if trim (cl088.PRecord.cl050) = '75-390' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '77-394' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-395' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-397' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '78-391' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '98-001' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '98-002' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '98-012' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '98-012' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '98-012' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '98-012' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '98-012' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '98-012' then  cl088.PRecord.cl028 := '1';
  if trim (cl088.PRecord.cl050) = '99-001' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '99-002' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '99-003' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '99-004' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '99-005' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '99-005' then  cl088.PRecord.cl028 := '2';
  if trim (cl088.PRecord.cl050) = '99-006' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '02-002' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '09-019' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '10-022' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '09-023' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '11-025' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '14-032' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '17-041' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '19-043' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '19-044' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '24-003' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '20-006' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '20-007' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '29-011' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '27-016' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '29-019' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '31-023' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '36-037' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '36-038' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '36-040' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '35-041' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '47-046' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '58-087' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '56-088' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '60-103' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '60-104' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '64-119' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '64-120' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-122' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-135' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-136' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '67-143' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '68-146' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '68-148' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '68-149' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '69-150' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '69-152' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '70-161' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '67-189' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-193' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '65-229' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-231' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-232' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '69-296' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-305' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-306' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '70-343' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-350' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-352' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '69-378' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-384' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-385' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '67-386' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '80-389' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '79-390' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-392' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-396' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-398' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-399' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-401' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-402' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-403' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '77-404' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '59-095' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-157' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-388' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-195' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-287' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-288' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-289' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-290' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-291' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '70-344' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '70-345' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-346' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-347' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-348' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-349' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '73-355' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '70-359' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-383' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-190' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-303' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '74-304' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '28-010' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '33-020' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '67-387' then  cl088.PRecord.cl028 := '3';
  if trim (cl088.PRecord.cl050) = '71-353' then  cl088.PRecord.cl028 := '3';

end;

procedure TCL000EntryCollection.SetCell(Sender: TObject; const AColumn: TColumn;
  const ARow: Integer; var AValue: String);
begin

end;

procedure TCL000EntryCollection.SetItem(Index: Integer; Value: TCL000EntryItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL000EntryCollection.ShowGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldsNames.Count + 1, self.Count);
  for i := 0 to self.FieldsNames.Count - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.FieldsNames[i];
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldsNames.Count] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue := self.GetCell;
  TVirtualModeData(Grid.Data).OnSetValue:=self.SetCell;


  for i := 0 to self.FieldsNames.Count - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
    Grid.Columns[i].ReadOnly := True;
  end;

  Grid.Columns[self.FieldsNames.Count].Width.Value := 50;
  Grid.Columns[self.FieldsNames.Count].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
end;


{ TCL000MetaItem }

constructor TCL000MetaItem.Create(Collection: TCollection);
begin
  inherited create (Collection);
  FColumn := -1;
  FvalIsEmpty := true;
end;

procedure TCL000MetaItem.SetColumn(const Value: integer);
begin
  FColumn := Value;
end;

procedure TCL000MetaItem.SetName(const Value: string);
begin

  FName := Value;
end;

procedure TCL000MetaItem.SetValue(const Value: string);
begin
  FvalIsEmpty := (value <> '');
  FValue := Value;
end;

end.
