unit CodeGenHelpers;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SynEditHighlighter, SynEditCodeFolding,
  SynHighlighterPas, SynMemo, SynEdit, Vcl.Grids, Vcl.ValEdit, SynEditTypes, SynEditMiscClasses, SynEditSearch,
  Vcl.ComCtrls, IBX.IBSQL, IBX.IBDatabase, Data.DB;

  type
  TFieldInfo = record
    PropName: string;   // напр. PREGLED_ID
    FieldType: string;  // integer, word, boolean, AnsiString, TDate, Logical...
  end;


  function BuildOnSetTextSearchEDT(const TableName: string; const Fields: TStrings): string;
  function BuildFillPropCode(const TableName: string; const Fields: TArray<TFieldInfo>): string;
  function BuildReadCmdCode(const TableName, LogSizeStr: string): string;

implementation

function BuildFillPropCode(const TableName: string; const Fields: TArray<TFieldInfo>): string;
var
  i: Integer;
  line: string;
begin
  Result :=
    'procedure T' + TableName + 'Item.FillProp' + TableName +
    '(propIndex: TPropertyIndex; stream: TStream);' + sLineBreak +
    'var' + sLineBreak +
    '  lenStr: Word;' + sLineBreak +
    'begin' + sLineBreak +
    '  case propIndex of' + sLineBreak;

  for i := 0 to High(Fields) do
  begin
    line := '    ' + TableName + '_' + Fields[i].PropName + ':' + sLineBreak + '    begin' + sLineBreak;

    if SameText(Fields[i].FieldType, 'integer') then
      line := line + '      stream.Read(Self.PRecord.' + Fields[i].PropName +
                      ', SizeOf(Integer));' + sLineBreak;

    if SameText(Fields[i].FieldType, 'word') then
      line := line + '      stream.Read(Self.PRecord.' + Fields[i].PropName +
                      ', SizeOf(Word));' + sLineBreak;

    if SameText(Fields[i].FieldType, 'boolean') then
      line := line + '      stream.Read(Self.PRecord.' + Fields[i].PropName +
                      ', SizeOf(Byte));' + sLineBreak;

    if SameText(Fields[i].FieldType, 'double') then
      line := line + '      stream.Read(Self.PRecord.' + Fields[i].PropName +
                      ', SizeOf(Double));' + sLineBreak;

    if SameText(Fields[i].FieldType, 'TDate') then
      line := line + '      stream.Read(Self.PRecord.' + Fields[i].PropName +
                      ', SizeOf(TDate));' + sLineBreak;

    if SameText(Fields[i].FieldType, 'TTime') then
      line := line + '      stream.Read(Self.PRecord.' + Fields[i].PropName +
                      ', SizeOf(TTime));' + sLineBreak;

    if SameText(Fields[i].FieldType, 'AnsiString') then
      line := line +
        '      stream.Read(lenStr, 2);' + sLineBreak +
        '      SetLength(Self.PRecord.' + Fields[i].PropName + ', lenStr);' + sLineBreak +
        '      stream.Read(Self.PRecord.' + Fields[i].PropName + '[1], lenStr);' + sLineBreak;

    if SameText(Fields[i].FieldType, 'Logical') then
      line := line +
        '      stream.Read(Self.PRecord.' + Fields[i].PropName +
        ', SizeOf(Self.PRecord.' + Fields[i].PropName + '));' + sLineBreak;

    line := line + '    end;' + sLineBreak;

    Result := Result + line;
  end;

  Result := Result + '  end;' + sLineBreak + 'end;';
end;




function BuildReadCmdCode(const TableName, LogSizeStr: string): string;
begin
  Result :=
    'procedure T' + TableName + 'Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;' + sLineBreak +
    '  vCmd: PVirtualNode; CmdItem: TCmdItem);' + sLineBreak +
    'var' + sLineBreak +
    '  delta: integer;' + sLineBreak +
    '  flds: TLogicalData' + LogSizeStr + ';' + sLineBreak +
    '  propIndex: T' + TableName + 'Item.TPropertyIndex;' + sLineBreak +
    '  vCmdProp: PVirtualNode;' + sLineBreak +
    '  dataCmdProp: PAspRec;' + sLineBreak +
    'begin' + sLineBreak +
    '  delta := SizeOf(TLogicalData128) - SizeOf(TLogicalData' + LogSizeStr + ');' + sLineBreak +
    sLineBreak +
    '  stream.Read(flds, SizeOf(TLogicalData' + LogSizeStr + '));' + sLineBreak +
    '  stream.Position := stream.Position + delta;' + sLineBreak +
    sLineBreak +
    '  New(Self.PRecord);' + sLineBreak +
    '  Self.PRecord.setProp := T' + TableName + 'Item.TSetProp(flds);' + sLineBreak +
    sLineBreak +
    '  for propIndex := Low(T' + TableName + 'Item.TPropertyIndex) to High(T' + TableName + 'Item.TPropertyIndex) do' + sLineBreak +
    '  begin' + sLineBreak +
    '    if not (propIndex in Self.PRecord.setProp) then' + sLineBreak +
    '      Continue;' + sLineBreak +
    sLineBreak +
    '    if vtrTemp <> nil then' + sLineBreak +
    '    begin' + sLineBreak +
    '      vCmdProp := vtrTemp.AddChild(vCmd, nil);' + sLineBreak +
    '      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);' + sLineBreak +
    '      dataCmdProp.index := Ord(propIndex);' + sLineBreak +
    '      dataCmdProp.vid := vv' + TableName + ';' + sLineBreak +
    '    end;' + sLineBreak +
    sLineBreak +
    '    Self.FillProp' + TableName + '(propIndex, stream);' + sLineBreak +
    '  end;' + sLineBreak +
    sLineBreak +
    '  CmdItem.AdbItem := Self;' + sLineBreak +
    'end;';
end;



function BuildOnSetTextSearchEDT(const TableName: string; const Fields: TStrings): string;
var
  SL: TStringList;
  i: Integer;
  FieldName, FieldType, ProcBody: string;
begin
  SL := TStringList.Create;
  try
    SL.Add(Format('procedure T%sColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);', [TableName]));
    SL.Add('var');
    SL.Add('  AText: string;');
    SL.Add('  ADate: TDate;');
    SL.Add('  AInt: Integer;');
    SL.Add('  ALog: Boolean;');
    SL.Add('begin');
    SL.Add('  if Text = '''' then');
    SL.Add('  begin');
    SL.Add(Format('    Exclude(ListForFinder[0].PRecord.setProp, T%sItem.TPropertyIndex(Field));', [TableName]));
    SL.Add('  end');
    SL.Add('  else');
    SL.Add('  begin');
    SL.Add('    if not (cotSens in Condition) then');
    SL.Add('      AText := AnsiUpperCase(Text)');
    SL.Add('    else');
    SL.Add('      AText := Text;');
    SL.Add(Format('    Include(ListForFinder[0].PRecord.setProp, T%sItem.TPropertyIndex(Field));', [TableName]));
    SL.Add('  end;');
    SL.Add(Format('  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;', [TableName]));
    SL.Add('');
    SL.Add('  case T' + TableName + 'Item.TPropertyIndex(Field) of');

    // Генерира case клонове
    for i := 0 to Fields.Count - 1 do
    begin
      FieldName := Trim(Fields.Names[i]);
      FieldType := Trim(Fields.ValueFromIndex[i]);

      if FieldType = '' then
        Continue;

      if SameText(FieldType, 'AnsiString') then
        ProcBody := Format('    %s_%s: ListForFinder[0].PRecord.%s := AText;',
          [TableName, FieldName, FieldName])
      else if SameText(FieldType, 'TDate') then
        ProcBody := Format('    %s_%s: ListForFinder[0].PRecord.%s := StrToDateDef(Text, 0);',
          [TableName, FieldName, FieldName])
      else if SameText(FieldType, 'integer') then
        ProcBody := Format('    %s_%s: ListForFinder[0].PRecord.%s := StrToIntDef(Text, 0);',
          [TableName, FieldName, FieldName])
      else if SameText(FieldType, 'double') then
        ProcBody := Format('    %s_%s: ListForFinder[0].PRecord.%s := StrToFloatDef(Text, 0);',
          [TableName, FieldName, FieldName])
      else if Pos('Logical', FieldType) > 0 then
        ProcBody := Format('    %s_%s: ListForFinder[0].PRecord.%s := ALog;',
          [TableName, FieldName, FieldName])
      else
        Continue;

      SL.Add(ProcBody);
    end;

    SL.Add('  end;');
    SL.Add('end;');

    Result := SL.Text;
  finally
    SL.Free;
  end;
end;


end.
