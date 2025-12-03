unit MainGenerator; //GetCellFromRecord  !VirtualTrees! read   real   TLogical  templ  === DATE SEARCH HANDLER ===

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SynEditHighlighter, SynEditCodeFolding,
  SynHighlighterPas, SynMemo, SynEdit, Vcl.Grids, Vcl.ValEdit, SynEditTypes, SynEditMiscClasses, SynEditSearch,
  Vcl.ComCtrls, IBX.IBSQL, IBX.IBDatabase, Data.DB, System.StrUtils, DDLGenerator;

type
  TfrmMainGenerator = class(TForm)
    pnlTop: TPanel;
    edtNameTable: TEdit;
    SynPasSyn1: TSynPasSyn;
    SynMemo1: TSynMemo;
    btnGenCode: TButton;
    vlsProp: TValueListEditor;
    btnProcInsert: TButton;
    SynEditSearch1: TSynEditSearch;
    pnlWork: TPanel;
    pgcWork: TPageControl;
    tsTable: TTabSheet;
    tsAddTable: TTabSheet;
    pnlAddTable: TPanel;
    btnAddTable: TButton;
    synmaddTable: TSynMemo;
    tsDDL: TTabSheet;
    mmoDDL: TMemo;
    pnlTopDDL: TPanel;
    DBMain: TIBDatabase;
    traMain: TIBTransaction;
    ibsqlCMD: TIBSQL;
    btnGenDDL: TButton;
    cbbTableName: TComboBox;
    btnLoadProp: TButton;
    lblNameTable: TLabel;
    btnDBHelperUpdate: TButton;
    btnDbHelperInsert: TButton;
    tsInsertField: TTabSheet;
    btnCMDFillProp: TButton;
    dlgOpenDDL: TOpenDialog;
    btnDDlFromFile: TButton;
    dlgOpenPas: TOpenDialog;
    procedure btnGenCodeClick(Sender: TObject);
    procedure btnProcInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddTableClick(Sender: TObject);
    procedure cbbTableNameDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGenDDLClick(Sender: TObject);
    procedure btnLoadPropClick(Sender: TObject);
    procedure btnDBHelperUpdateClick(Sender: TObject);
    procedure btnDbHelperInsertClick(Sender: TObject);
    procedure btnCMDFillPropClick(Sender: TObject);
    procedure btnDDlFromFileClick(Sender: TObject);
  private
    FlogSizeStr: string;
    FfldSizeStr: string;
    function ConvertValueToString(valType: string): string;
    function ConvertValueToString1(valType: string): string;
    function ConvertStringToValue(valType: string): string;
    function ConvertStringToField(valType: string): string;

    function getPropertyIndex: string;
    function getVirtualTrees: string;
    function getTLogical: TStringList;
    function getProcTRec: TStringList;
    function getIndexFrom1: TStringList;
    function getIndexFrom2: TStringList;
    function getProcInsert: TStringList;
    function getProcUpdate: TStringList;
    function getProcSave: TStringList;
    function getProcSetCell: TStringList;
    function getProcSetField: TStringList;
    function getProcCompareOldCel: TStringList;
    function getGetMapProc(indexKey: integer): string;

    function getProcCompareOldField: TStringList;
    function getProcDisplayName: TStringList;
    function getProcCellFromRecord: TStringList;
    function getProcCellFromMap1: TStringList;
    function getProcCellFromMap: TStringList;
    function IsTreeLink: Boolean;
    function getProcIndexValue: TStringList;
    function getProcSetSearchingValue: TStringList;
    function getProcImportXMLNzis: TStringList;
    function getProcSortByIndexValue: TStringList;
    function getProcIsFullFinded: TStringList;
    function GetProcPropType: TStringList;
    function getProcCheckForSave: TStringList;
    function getProcSetTextField: TStringList;
    function getProcSetDateField: TStringList;
    function getProcSetNumField: TStringList;
    function getProcSetLogicalField: TStringList;
    function getProcDisplayLogicalName: TStringList;
    procedure SetlogSizeStr(const Value: string);

    function getProcFillProp: TStringList;
    procedure SetfldSizeStr(const Value: string);
    function IsNzisNomenclature(const s: string): Boolean;
    procedure RemoveTaggedBlock(sl: TStrings; const startTag, endTag: string; AStartOf: integer = -1);

  public
    FTLogical: TStringList;
    property logSizeStr: string read FlogSizeStr write SetlogSizeStr;
    property fldSizeStr: string read FfldSizeStr write SetfldSizeStr;
  end;

var
  frmMainGenerator: TfrmMainGenerator;

implementation

{$R *.dfm}

procedure TfrmMainGenerator.btnAddTableClick(Sender: TObject);
var
  i: Integer;
  ls: TStringList;
begin
  ls := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]] = 'integer' then
    begin
      ls.Add(Format('    if not ibsql%s.Fields[%d].IsNull then', [edtNameTable.Text, i-1]));
      ls.Add('    begin');
      ls.Add(Format('       TempItem.PRecord.%s := ibsql%s.Fields[%d].AsInteger;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('       Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'AnsiString' then
    begin
      ls.Add(Format('    if not ibsql%s.Fields[%d].IsNull then', [edtNameTable.Text, i-1]));
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsString;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'word' then
    begin
      ls.Add(Format('    if not ibsql%s.Fields[%d].IsNull then', [edtNameTable.Text, i-1]));
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsInteger;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'boolean' then
    begin
      ls.Add(Format('    if not ibsql%s.Fields[%d].IsNull then', [edtNameTable.Text, i-1]));
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsString = ''Y'';',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TDate' then
    begin
      ls.Add(Format('    if not ibsql%s.Fields[%d].IsNull then', [edtNameTable.Text, i-1]));
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsDate;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TTime' then
    begin
      ls.Add(Format('    if not ibsql%s.Fields[%d].IsNull then', [edtNameTable.Text, i-1]));
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsTime;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end

  end;



  synmaddTable.Lines.Assign(ls);
  ls.Free;
end;

procedure TfrmMainGenerator.btnGenDDLClick(Sender: TObject);
begin
  mmoDDL.Lines.Clear;
  ibsqlCMD.Close;
  ibsqlCMD.SQL.Text :=
    'SELECT' + #13#10 +
    'F.RDB$FIELD_TYPE,' + #13#10 +
    'CASE F.RDB$FIELD_TYPE' + #13#10 +
     'WHEN 7 THEN ''word''' + #13#10 +
     'WHEN 8 THEN ''integer''' + #13#10 +
     'WHEN 9 THEN ''QUAD''' + #13#10 +
     'WHEN 10 THEN ''double''' + #13#10 +
     'WHEN 11 THEN ''D_FLOAT''' + #13#10 +
     'WHEN 12 THEN ''TDate''' + #13#10 +
     'WHEN 13 THEN ''TTime''' + #13#10 +
     'WHEN 14 THEN ''AnsiString''' + #13#10 +
     'WHEN 16 THEN ''INT64''' + #13#10 +
     'WHEN 27 THEN ''double''' + #13#10 +
     'WHEN 35 THEN ''TIMESTAMP''' + #13#10 +
     'WHEN 37 THEN ''AnsiString''' + #13#10 +
     'WHEN 40 THEN ''CSTRING''' + #13#10 +
     'WHEN 261 THEN ''AnsiString''' + #13#10 +  //blob
     'ELSE ''UNKNOWN''' + #13#10 +
    'END AS field_type,' + #13#10 +
    'F.RDB$FIELD_LENGTH AS field_length,' + #13#10 +
    'R.RDB$FIELD_NAME AS field_name,' + #13#10 +
    'R.RDB$FIELD_SOURCE AS dom' + #13#10 +
    'FROM RDB$RELATION_FIELDS R' + #13#10 +
    'LEFT JOIN RDB$FIELDS F ON R.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME' + #13#10 +
    'WHERE R.RDB$RELATION_NAME= :TableName' + #13#10 +
    'ORDER BY 4';
  ibsqlCMD.ParamByName('TableName').AsString := cbbTableName.Text;
  ibsqlCMD.ExecQuery;
  while not ibsqlCMD.Eof do
  begin
    if not((Trim(ibsqlCMD.Fields[1].AsString) = 'AnsiString') and (Trim(ibsqlCMD.Fields[4].AsString) = 'TLOGICAL')) then
    begin
      mmoDDL.Lines.Add(Trim(ibsqlCMD.Fields[3].AsString) + '=' + Trim(ibsqlCMD.Fields[1].AsString));
    end
    else
    begin
      mmoDDL.Lines.Add(Trim(ibsqlCMD.Fields[3].AsString) + '=' + 'boolean');
    end;
    ibsqlCMD.Next;
  end;
end;

procedure TfrmMainGenerator.btnLoadPropClick(Sender: TObject);
var
  str: string;
begin
  if mmoDDL.Text <> '' then
  begin
    vlsProp.Strings.Assign(mmoDDL.Lines);
  end
  else
  begin
    if dlgOpenDDL.Execute then
    begin
      str := ExtractFileName(dlgOpenDDL.FileName);
      edtNameTable.Text := str.Split(['.'])[1];
      mmoDDL.Lines.LoadFromFile(dlgOpenDDL.FileName);
      vlsProp.Strings.LoadFromFile(dlgOpenDDL.FileName);
    end;
  end;
end;

procedure TfrmMainGenerator.btnProcInsertClick(Sender: TObject);
var
  i: Integer;
  ls: TStringList;
begin
  ls := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    ls.Add('    ' + edtNameTable.Text + '_' + vlsProp.Keys[i] + ':' + #13#10);
    if vlsProp.Values[vlsProp.Keys[i]] = 'AnsiString' then
    begin

      ls.Add('    begin' + #13#10);
      ls.Add('      stream.Read(lenStr, 2);' + #13#10);
      ls.Add('      setlength(FillItem.PRecord.' + vlsProp.Keys[i] + ', lenstr);' + #13#10);
      ls.Add('      stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + '[1], lenStr);' + #13#10);
      ls.Add('    end;' + #13#10);
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'integer' then
    begin
      ls.Add('    begin' + #13#10);
      ls.Add('      stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 4);' + #13#10);
      ls.Add('    end;' + #13#10);
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'word' then
    begin
      ls.Add('    begin' + #13#10);
      ls.Add('      stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 2);' + #13#10);
      ls.Add('    end;' + #13#10);
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'boolean' then
    begin
      ls.Add('    begin' + #13#10);
      ls.Add('      stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 1);' + #13#10);
      ls.Add('    end;' + #13#10);
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TDate' then
    begin
      ls.Add('    begin' + #13#10);
      ls.Add('      stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 8);' + #13#10);
      ls.Add('    end;' + #13#10);
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TTime' then
    begin
      ls.Add('    begin' + #13#10);
      ls.Add('      stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 8);' + #13#10);
      ls.Add('    end;' + #13#10);
    end

  end;

  synmaddTable.Lines.Assign(ls);
  ls.Free;
end;



procedure TfrmMainGenerator.btnCMDFillPropClick(Sender: TObject);
var
  i: Integer;
  ls: TStringList;
begin


  ls := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    ls.Add('    ' + edtNameTable.Text + '_' + vlsProp.Keys[i] + ':');
    ls.Add('    begin');
    if vlsProp.Values[vlsProp.Keys[i]] = 'AnsiString' then
    begin
      ls.Add('       stream.Read(lenStr, 2);');
      ls.Add('       setlength(FillItem.PRecord.' + vlsProp.Keys[i] + ', lenstr);');
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + '[1], lenStr);')
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'integer' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 4);');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'cardinal' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 4);');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'word' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 2);');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'boolean' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 2);');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TDate' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 8);');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TTime' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 8);');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'double' then
    begin
      ls.Add('       stream.Read(FillItem.PRecord.' + vlsProp.Keys[i] + ', 8);');
    end;
    ls.Add('    end;');
  end;

  synmaddTable.Lines.Assign(ls);
  ls.Free;
end;

procedure TfrmMainGenerator.btnDbHelperInsertClick(Sender: TObject);
var
  i: Integer;
  ls: TStringList;
begin


  ls := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]] = 'integer' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull) ', [edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('       TempItem.PRecord.%s := ibsql%s.Fields[%d].AsInteger;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('       Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'AnsiString' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsString;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'word' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsInteger;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'boolean' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsString = ''Y'';',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TDate' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsDate;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TTime' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsTime;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end

  end;



  synmaddTable.Lines.Assign(ls);
  ls.Free;
end;

procedure TfrmMainGenerator.btnDBHelperUpdateClick(Sender: TObject);
var
  i: Integer;
  ls: TStringList;
begin


  ls := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]] = 'integer' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull) ', [edtNameTable.Text, i-1]));
      ls.Add(format('        and (TempItem.getIntMap(buf, datPos, word(%s_%s))<>ibsql%s.Fields[%d].AsInteger)',
             [edtNameTable.Text, vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('       TempItem.PRecord.%s := ibsql%s.Fields[%d].AsInteger;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('       Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'AnsiString' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add(format('        and (TempItem.getAnsiStringMap(buf, datPos, word(%s_%s))<>ibsql%s.Fields[%d].AsString)',
             [edtNameTable.Text, vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsString;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'word' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add(format('        and (TempItem.getWordMap(buf, datPos, word(%s_%s))<>ibsql%s.Fields[%d].AsInteger)',
             [edtNameTable.Text, vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsInteger;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'boolean' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add(format('        and (TempItem.getBooldMap(buf, datPos, word(%s_%s))<>ibsql%s.Fields[%d].Asstring)',
             [edtNameTable.Text, vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsString = ''Y'';',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TDate' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add(format('        and (TempItem.getDateMap(buf, datPos, word(%s_%s))<>ibsql%s.Fields[%d].AsDate)',
             [edtNameTable.Text, vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsDate;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]] = 'TTime' then
    begin
      ls.Add(Format('    if (not ibsql%s.Fields[%d].IsNull)', [edtNameTable.Text, i-1]));
      ls.Add(format('        and (TempItem.getTimeMap(buf, datPos, word(%s_%s))<>ibsql%s.Fields[%d].AsTime)',
             [edtNameTable.Text, vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add('    then');
      ls.Add('    begin');
      ls.Add(Format('      TempItem.PRecord.%s := ibsql%s.Fields[%d].AsTime;',
           [vlsProp.Keys[i], edtNameTable.Text, i-1]));
      ls.Add(Format('      Include(TempItem.PRecord.setProp, %s_%s);',[edtNameTable.Text, vlsProp.Keys[i]]));
      ls.Add('    end;');
    end

  end;



  synmaddTable.Lines.Assign(ls);
  ls.Free;
end;

procedure TfrmMainGenerator.btnDDlFromFileClick(Sender: TObject);
begin
  if dlgOpenPas.Execute then
  begin
    mmoDDL.Text := TDDLGenerator.GenerateDDLFromPas(dlgOpenPas.FileName);
    edtNameTable.Text :=  TDDLGenerator.FClassName;
  end;
end;

procedure TfrmMainGenerator.btnGenCodeClick(Sender: TObject);
var
  tableName: string;
begin
  tableName := edtNameTable.Text;

  SynMemo1.SearchReplace('!PropertyIndex!', getPropertyIndex, [ssoReplace]);
  SynMemo1.SearchReplace('!TRec!', Trim(getProcTRec.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!IndexFrom1!', Trim(getIndexFrom1.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcInsert!', Trim(getProcInsert.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcIsFullFinded!', Trim(getProcIsFullFinded.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcFillProp!', Trim(getProcFillProp.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSave!', Trim(getProcSave.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcUpdate!', Trim(getProcUpdate.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcCheckForSave!', Trim(getProcCheckForSave.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcDisplayName!', Trim(getProcDisplayName.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcDisplayLogicalName!', Trim(getProcDisplayLogicalName.Text), [ssoReplace]);

  SynMemo1.SearchReplace('!FieldCount!', IntToStr(vlsProp.RowCount - 1), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcCellFromRecord!', Trim(getProcCellFromRecord.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcCellFromMap!', Trim(getProcCellFromMap.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!IndexFrom2!', Trim(getIndexFrom2.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcIndexValue!', Trim(getProcIndexValue.Text), [ssoReplace]);

  SynMemo1.SearchReplace('!ProcSetTextField!', Trim(getProcSetTextField.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSetDateField!', Trim(getProcSetDateField.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSetNumField!', Trim(getProcSetNumField.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSetLogicalField!', Trim(getProcSetLogicalField.Text), [ssoReplace]);

  SynMemo1.SearchReplace('!ProcPropType!', Trim(GetProcPropType.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcCompareOldCell!', Trim(getProcCompareOldCel.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSetCell!', Trim(getProcSetCell.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcCompareOldField!', Trim(getProcCompareOldField.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSetField!', Trim(getProcSetField.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSetSearchingValue!', Trim(getProcSetSearchingValue.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcSortByIndexValue!', Trim(getProcSortByIndexValue.Text), [ssoReplace]);
  SynMemo1.SearchReplace('!ProcImportXMLNzis!', Trim(getProcImportXMLNzis.Text), [ssoReplace]);

  SynMemo1.CaretX := 0;
  SynMemo1.CaretY := 0;

  SynMemo1.CaretX := 0;
  SynMemo1.CaretY := 0;
  SynMemo1.SearchReplace('TLogical!TableName!', FTLogical.Text, [ssoReplace]);



  SynMemo1.CaretX := 0;
  SynMemo1.CaretY := 0;
  SynMemo1.SearchReplace('!TableName!', tableName, [ssoReplaceAll]);
  SynMemo1.CaretX := 0;
  SynMemo1.CaretY := 0;
  SynMemo1.SearchReplace('!fldSizeStr!', fldSizeStr, [ssoReplaceAll]);


  if not IsNzisNomenclature(edtNameTable.Text) then
  begin
    RemoveTaggedBlock(SynMemo1.Lines, 'NZIS_START', 'NZIS_END');
  end;

  SynMemo1.Lines.SaveToFile('..\Table.' + tableName + '.pas2', TEncoding.ANSI);

  vlsProp.Strings.SaveToFile('..\Table.' + tableName + '.ddl', TEncoding.ANSI);


end;


function TfrmMainGenerator.getProcFillProp: TStringList;
var
  i: Integer;
  fldName, fldType: string;
  prefix: string;
begin
  Result := TStringList.Create;

  for i := 1 to vlsProp.RowCount - 1 do
  begin
    fldName := vlsProp.Keys[i];
    fldType := vlsProp.Values[fldName];

    if i = 1 then prefix := '        '
             else prefix := '            ';

    case fldType[1] of

      // INTEGER
      'i':
        Result.Add(prefix + '!TableName!_' + fldName +
                   ': stream.Read(Self.PRecord.' + fldName +
                   ', SizeOf(Integer));');

      // WORD
      'w':
        Result.Add(prefix + '!TableName!_' + fldName +
                   ': stream.Read(Self.PRecord.' + fldName +
                   ', SizeOf(Word));');

      // CARDINAL
      'c':
        Result.Add(prefix + '!TableName!_' + fldName +
                   ': stream.Read(Self.PRecord.' + fldName +
                   ', SizeOf(Cardinal));');

      // ANSI STRING
      'A':
        Result.Add(prefix + '!TableName!_' + fldName + ':' + sLineBreak +
                   prefix + 'begin' + sLineBreak +
                   prefix + '  stream.Read(lenStr, 2);' + sLineBreak +
                   prefix + '  SetLength(Self.PRecord.' + fldName + ', lenStr);' + sLineBreak +
                   prefix + '  stream.Read(Self.PRecord.' + fldName + '[1], lenStr);' + sLineBreak +
                   prefix + 'end;');

      // STRING (ако имаш ShortString)
      'S':
        Result.Add(prefix + '!TableName!_' + fldName +
                   ': stream.Read(Self.PRecord.' + fldName +
                   ', Length(Self.PRecord.' + fldName + '));');

      // DATE / TIME (TDate, TTime)
      'T':
        begin
          if fldType.Contains('TD') then
            Result.Add(prefix + '!TableName!_' + fldName +
                       ': stream.Read(Self.PRecord.' + fldName +
                       ', SizeOf(TDate));')
          else if fldType.Contains('TT') then
            Result.Add(prefix + '!TableName!_' + fldName +
                       ': stream.Read(Self.PRecord.' + fldName +
                       ', SizeOf(TTime));');
        end;

      // BOOLEAN
      'b':
        Result.Add(prefix + '!TableName!_' + fldName +
                   ': stream.Read(Self.PRecord.' + fldName +
                   ', SizeOf(Boolean));');

      // LOGICAL SET
      't':
        Result.Add(prefix + '!TableName!_' + fldName +
                   ': stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData' +
                   logSizeStr + '));');

    end; // case
  end;
end;






procedure TfrmMainGenerator.cbbTableNameDblClick(Sender: TObject);
begin
  cbbTableName.Items.Clear;
  ibsqlCMD.Close;
  ibsqlCMD.SQL.Text :=
    'SELECT RDB$RELATION_NAME ' + #13#10 +
    'FROM RDB$RELATIONS a ' + #13#10 +
    'WHERE  RDB$SYSTEM_FLAG = 0 and RDB$VIEW_SOURCE is null ' + #13#10 +
    'order by 1';
  ibsqlCMD.ExecQuery;
  while not ibsqlCMD.Eof do
  begin
    cbbTableName.Items.Add(ibsqlCMD.Fields[0].AsString);
    ibsqlCMD.Next;
  end;
end;

function TfrmMainGenerator.ConvertStringToField(valType: string): string;
begin
  if valType = 'integer' then Result := ' := StrToInt(AFieldText);';
  if valType = 'cardinal' then Result := ' := StrToInt(AFieldText);';
  if valType = 'String' then Result := ' := AFieldText;';
  if valType = 'boolean' then Result := ' := StrToBool(AFieldText);';
  if valType = 'double' then Result := ' := StrToFloat(AFieldText);';
  if valType = 'word' then Result := ' := StrToInt(AFieldText);';
  if valType = 'Byte' then Result := ' := StrToInt(AFieldText);';
  if valType = 'TDate' then Result := ' := StrToDate(AFieldText);';
  if valType = 'PVirtualNode' then Result := ' := Pointer(StrToInt(AFieldText));';
  if valType = 'AnsiString' then Result := ' := AFieldText;';
  if valType = 'TTime' then Result := ' := StrToTime(AFieldText);';
  //if valType = 'ArrInt' then Result := ' := StrToTime(AFieldText);';
  if valType.StartsWith( 'tLogicalSet:') then Result := ' := tlogical!TableName!Set(!TableName!.StrToLogical' + logSizeStr + '(AFieldText));';

end;

function TfrmMainGenerator.ConvertStringToValue(valType: string): string;
begin
  if valType = 'integer' then Result := ' := StrToInt(AValue);';
  if valType = 'cardinal' then Result := ' := StrToInt(AValue);';
  if valType = 'String' then Result := ' := AValue;';
  if valType = 'boolean' then Result := ' := StrToBool(AValue);';
  if valType = 'double' then Result := ' := StrToFloat(AValue);';
  if valType = 'word' then Result := ' := StrToInt(AValue);';
  if valType = 'Byte' then Result := ' := StrToInt(AValue);';
  if valType = 'TDate' then Result := ' := StrToDate(AValue);';
  if valType = 'PVirtualNode' then Result := ' := Pointer(StrToInt(AValue));';
  if valType = 'AnsiString' then Result := ' := AValue;';
  if valType = 'TTime' then Result := ' := StrToTime(AValue);';
  if valType.StartsWith( 'tLogicalSet:') then Result := ' := tlogical!TableName!Set(!TableName!.StrToLogical' + logSizeStr + '(AValue));';

end;

function TfrmMainGenerator.ConvertValueToString(valType: string): string;
begin
  if valType = 'integer' then Result := 'inttostr(';
  if valType = 'cardinal' then Result := 'inttostr(';
  if valType = 'String' then Result := '(';
  if valType = 'boolean' then Result := 'BoolToStr(';
  if valType = 'double' then Result := 'FloatToStr(';
  if valType = 'word' then Result := 'inttostr(';
  if valType = 'byte' then Result := 'inttostr(';
  if valType = 'TDate' then Result := 'AspDateToStr(';
  if valType = 'PVirtualNode' then Result := '''PVN '' + inttostr(Integer(';
  if valType = 'AnsiString' then Result := '(';
  if valType = 'TTime' then Result := 'TimeToStr(';
  if valType.StartsWith( 'tLogicalSet32:') then Result := 'Logical32ToStr(TLogicalData32(';
  if valType.StartsWith( 'tLogicalSet16:') then Result := 'Logical16ToStr(TLogicalData16(';
  if valType.StartsWith( 'tLogicalSet48:') then Result := 'Logical48ToStr(TLogicalData48(';
end;

function TfrmMainGenerator.ConvertValueToString1(valType: string): string;
begin
  if valType = 'integer' then Result := 'int);';
  if valType = 'cardinal' then Result := 'int);';
  if valType = 'String' then Result := 'pstr, len);';
  if valType = 'boolean' then Result := 'PBl);';
  if valType = 'double' then Result := 'pDbl);';
  if valType = 'word' then Result := 'wrd);';
  if valType = 'byte' then Result := 'bt);';
  if valType = 'TDate' then Result := 'pDbl);';
  if valType = 'PVirtualNode' then Result := '!TableName!.PRecord.piTreeNode);';
  if valType = 'AnsiString' then Result := 'pstr, len);';
  if valType = 'TTime' then Result := 'pDbl);';
end;

procedure TfrmMainGenerator.FormCreate(Sender: TObject);
begin
  SynMemo1.Lines.LoadFromFile('Template.tmp', TEncoding.UTF8);
  FTLogical := TStringList.Create;
  mmoDDL.Clear;
end;

procedure TfrmMainGenerator.FormShow(Sender: TObject);
begin
  cbbTableNameDblClick(nil);
end;

function TfrmMainGenerator.getGetMapProc(indexKey: integer): string;
begin
  case vlsProp.Values[vlsProp.Keys[indexKey]][1] of
      'i':Result := 'getIntMap';//integer

      'w':Result := 'getWordMap';//word

      'c':Result := 'getIntMap';//cardinal

      'd':Result := 'getDoubleMap';//cardinal

      'S':Result := 'getStringMap';//stringove

      'A':Result := 'getAnsiStringMap';//Ansi stringove

      'T':
      begin
        case vlsProp.Values[vlsProp.Keys[indexKey]][2] of
          'D':Result := 'getDateMap';//Date

          'T':Result := 'getTimeMap';//Time
        end;
      end;



      'b':Result := 'getBooleanMap';//boolean
      't':Result := ''; //tLogicalSet  getlog
  end;
end;

function TfrmMainGenerator.getIndexFrom1: TStringList;
begin
  Result := TStringList.Create;
  if IsTreeLink then
  begin
    Result.Add('    function IndexFromDataPos(dataPos: Cardinal): Cardinal;');
    Result.Add('    function IndexFromNode(node: PVirtualNode): Cardinal;');
  end
  else
  begin
    Result.Text := '';
  end;
end;

function TfrmMainGenerator.getIndexFrom2: TStringList;
begin
  Result := TStringList.Create;
  if IsTreeLink then
  begin
    Result.Text :=
    'function T!TableName!Coll.IndexFromDataPos(dataPos: Cardinal): Cardinal;' + #13#10 +
    'var' + #13#10 +
      '  LoIndex, HiIndex, MidIndex: Integer;' + #13#10 +
      'begin' + #13#10 +
      '  Result := 0;' + #13#10 +
      '  LoIndex := 1;' + #13#10 +
      '  HiIndex := Count;' + #13#10 +
      '  MidIndex := Count div 2;' + #13#10 +
      '  while (Items[MidIndex].FDataPos <> dataPos) do' + #13#10 +
      '  begin' + #13#10 +
        '    if Items[MidIndex].FDataPos > dataPos then' + #13#10 +
        '    begin' + #13#10 +
          '      if HiIndex = MidIndex then' + #13#10 +
            '        Exit;' + #13#10 +
          '      HiIndex := MidIndex;' + #13#10 +
          '      MidIndex := LoIndex + (HiIndex - LoIndex) div 2;' + #13#10 +
        '    end' + #13#10 +
        '    else if Items[MidIndex].FDataPos < dataPos then' + #13#10 +
        '    begin' + #13#10 +
          '      if LoIndex = MidIndex then' + #13#10 +
            '        Exit;' + #13#10 +
          '      LoIndex := MidIndex;' + #13#10 +
          '      MidIndex := LoIndex + (HiIndex - LoIndex) div 2;' + #13#10 +
        '    end;' + #13#10 +
      '  end;' + #13#10 +
      '  Result := MidIndex' + #13#10 +
      'end;' + #13#10 +
      '' + #13#10 +
      'function T!TableName!Coll.IndexFromNode(node: PVirtualNode): Cardinal;' + #13#10 +
      'var' + #13#10 +
      '  p: ^integer;' + #13#10 +
      'begin' + #13#10 +
      '  p := Pointer(PByte(node) - 4);' + #13#10 +
      '  Result := IndexFromDataPos(p^);' + #13#10 +
      'end;';
  end
  else
    Result.Text := '';

end;

function TfrmMainGenerator.getProcCellFromRecord: TStringList;
var
  i: Integer;
begin
  //piIncMdnId: str := inttostr(!TableName!.PRecord.piIncMdnId);
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]] = 'boolean' then
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str := ' + ConvertValueToString(vlsProp.Values[vlsProp.Keys[i]]) +
                   '!TableName!.PRecord.' + vlsProp.Keys[i] + ', True);')
      else
        Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str := ' + ConvertValueToString(vlsProp.Values[vlsProp.Keys[i]]) +
                   '!TableName!.PRecord.' + vlsProp.Keys[i] + ', True);')
    end
    else
    if vlsProp.Values[vlsProp.Keys[i]].StartsWith( 'tLogicalSet') then
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str := !TableName!.Logical' + logSizeStr + 'ToStr(TLogicalData' + logSizeStr + '(' + ConvertValueToString(vlsProp.Values[vlsProp.Keys[i]]) +
                   '!TableName!.PRecord.' + vlsProp.Keys[i] + '));')
      else
        Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str := !TableName!.Logical' + logSizeStr + 'ToStr(TLogicalData' + logSizeStr + '(' + ConvertValueToString(vlsProp.Values[vlsProp.Keys[i]]) +
                   '!TableName!.PRecord.' + vlsProp.Keys[i] + '));')
    end
    else
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str := ' + ConvertValueToString(vlsProp.Values[vlsProp.Keys[i]]) +
                   '!TableName!.PRecord.' + vlsProp.Keys[i] + ');')
      else
        Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str := ' + ConvertValueToString(vlsProp.Values[vlsProp.Keys[i]]) +
                   '!TableName!.PRecord.' + vlsProp.Keys[i] + ');')
    end;
  end;
end;

function TfrmMainGenerator.getProcCheckForSave: TStringList;
var
  i: Integer;
  fldName, fldType: string;
  cmpLines: TStringList;
  logicalKind: string;
begin
  Result := TStringList.Create;
  cmpLines := TStringList.Create;
  try
    // Въвеждащ коментар/заглавие (можеш да го промениш)
    cmpLines.Add('  // === проверки за запазване (CheckForSave) ===');
    cmpLines.Add('');

    for i := 1 to vlsProp.RowCount - 1 do
    begin
      fldName := Trim(vlsProp.Cells[0, i]);
      fldType := Trim(LowerCase(vlsProp.Cells[1, i]));
      if fldName = '' then Continue;

      // Логикал (специален случай)
      if fldType.Contains('logical') or fldType.Contains('tlogical') or fldType.Contains('tlogicalset') then
      begin
        // Опитваме се да разпознаем дали е 40 или 32 битов логикал по описанието
        //logSizeStr
        begin
          cmpLines.Add(Format('  if (%s_%s in tempItem.PRecord.setProp) and (TLogicalData' + logSizeStr + '(tempItem.PRecord.%s) <> Self.getLogical' + logSizeStr + 'Map(tempItem.DataPos, word(%s_%s))) then',
            ['!TableName!', fldName, fldName, '!TableName!', fldName]));
        end;

        cmpLines.Add('  begin');
        cmpLines.Add('    inc(cnt);');
        cmpLines.Add('    exit;');
        cmpLines.Add('  end;');
        cmpLines.Add('');
        Continue;
      end;

      // Текстови полета (AnsiString / string)
      if fldType.Contains('ansistring') or fldType.Contains('string') then
      begin
        cmpLines.Add(Format('  if (%s_%s in tempItem.PRecord.setProp) and (tempItem.PRecord.%s <> Self.getAnsiStringMap(tempItem.DataPos, word(%s_%s))) then',
          ['!TableName!', fldName, fldName, '!TableName!', fldName]));
        cmpLines.Add('  begin');
        cmpLines.Add('    inc(cnt);');
        cmpLines.Add('    exit;');
        cmpLines.Add('  end;');
        cmpLines.Add('');
        Continue;
      end;

      // Дати/време
      if fldType.Contains('tdate') or fldType.Contains('ttime') or fldType.Contains('timestamp') then
      begin
        cmpLines.Add(Format('  if (%s_%s in tempItem.PRecord.setProp) and (tempItem.PRecord.%s <> Self.getDateMap(tempItem.DataPos, word(%s_%s))) then',
          ['!TableName!', fldName, fldName, '!TableName!', fldName]));
        cmpLines.Add('  begin');
        cmpLines.Add('    inc(cnt);');
        cmpLines.Add('    exit;');
        cmpLines.Add('  end;');
        cmpLines.Add('');
        Continue;
      end;

      // Integer / Word / Cardinal / Int64
      if fldType.Contains('integer') or fldType.Contains('word') or fldType.Contains('cardinal') or fldType.Contains('int64') then
      begin
        cmpLines.Add(Format('  if (%s_%s in tempItem.PRecord.setProp) and (tempItem.PRecord.%s <> Self.getIntMap(tempItem.DataPos, word(%s_%s))) then',
          ['!TableName!', fldName, fldName, '!TableName!', fldName]));
        cmpLines.Add('  begin');
        cmpLines.Add('    inc(cnt);');
        cmpLines.Add('    exit;');
        cmpLines.Add('  end;');
        cmpLines.Add('');
        Continue;
      end;

      // Double / Float
      if fldType.Contains('double') or fldType.Contains('float') then
      begin
        cmpLines.Add(Format('  if (%s_%s in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.%s - Self.getDoubleMap(tempItem.DataPos, word(%s_%s))) > 0.000001) then',
          ['!TableName!', fldName, fldName, '!TableName!', fldName]));
        cmpLines.Add('  begin');
        cmpLines.Add('    inc(cnt);');
        cmpLines.Add('    exit;');
        cmpLines.Add('  end;');
        cmpLines.Add('');
        Continue;
      end;

      // Cardinal / other fallback
      cmpLines.Add(Format('  if (%s_%s in tempItem.PRecord.setProp) and (tempItem.PRecord.%s <> Self.getCardinalMap(tempItem.DataPos, word(%s_%s))) then',
        ['!TableName!', fldName, fldName, '!TableName!', fldName]));
      cmpLines.Add('  begin');
      cmpLines.Add('    inc(cnt);');
      cmpLines.Add('    exit;');
      cmpLines.Add('  end;');
      cmpLines.Add('');
    end;

    // Добавяме крайните редове към резултата (можеш да промениш заглавието/вкарване)
    Result.AddStrings(cmpLines);
  finally
    cmpLines.Free;
  end;
end;


function TfrmMainGenerator.getProcCompareOldCel: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    case vlsProp.Values[vlsProp.Keys[i]][1] of
      'i'://integer
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);');
      end;

      'w'://word
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);');
      end;

      'c'://cardinal
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);');
      end;

      'S'://stringove
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;');
      end;

      'A'://Ansi stringove
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;');
      end;

      'T':
      begin
        case vlsProp.Values[vlsProp.Keys[i]][2] of
          'D'://Date
          begin
            if i = 1 then
              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);')
            else
              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);');
          end;

          'T'://Time
          begin
            if i = 1 then
              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);')
            else
              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);');
          end;
        end;
      end;



      'b'://boolean
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);');
      end;
      't': //tLogicalSet
      begin

      end;
    end;



  end;
end;

function TfrmMainGenerator.getProcCompareOldField: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    case vlsProp.Values[vlsProp.Keys[i]][1] of
      'i'://integer
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);');
      end;

      'w'://word
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);');
      end;

      'c'://cardinal
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);');
      end;

      'S'://stringove
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AFieldText;')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AFieldText;');
      end;

      'A'://Ansi stringove
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;');
      end;

      'T':
      begin
        case vlsProp.Values[vlsProp.Keys[i]][2] of
          'D'://Date
          begin
            if i = 1 then
              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);')
            else
              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);');
          end;

          'T'://Time
          begin
            if i = 1 then
              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AFieldText);')
            else
              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AFieldText);');
          end;
        end;
      end;



      'b'://boolean
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);');
      end;
      't': //tLogicalSet
      begin

      end;
    end;



  end;
end;

function TfrmMainGenerator.getProcCellFromMap: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    case vlsProp.Values[vlsProp.Keys[i]][1] of
      'i'://integer
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  inttostr(!TableName!.getIntMap(Self.Buf, Self.posData, propIndex));')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  inttostr(!TableName!.getIntMap(Self.Buf, Self.posData, propIndex));');
      end;

      'w'://word
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  inttostr(!TableName!.getWordMap(Self.Buf, Self.posData, propIndex));')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  inttostr(!TableName!.getWordMap(Self.Buf, Self.posData, propIndex));');
      end;

      'c'://cardinal
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  inttostr(!TableName!.getIntMap(Self.Buf, Self.posData, propIndex));')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  inttostr(!TableName!.getIntMap(Self.Buf, Self.posData, propIndex));');
      end;

      'S'://stringove
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  !TableName!.getStringMap(Self.Buf, Self.posData, propIndex);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  !TableName!.getStringMap(Self.Buf, Self.posData, propIndex);');
      end;

      'A'://Ansi stringove
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  !TableName!.getAnsiStringMap(Self.Buf, Self.posData, propIndex);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  !TableName!.getAnsiStringMap(Self.Buf, Self.posData, propIndex);');
      end;

      'T':
      begin
        case vlsProp.Values[vlsProp.Keys[i]][2] of
          'D'://Date
          begin
            if i = 1 then
              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  AspDateToStr(!TableName!.getDateMap(Self.Buf, Self.posData, propIndex));')
            else
              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  AspDateToStr(!TableName!.getDateMap(Self.Buf, Self.posData, propIndex));');
          end;
          'T'://Time
          begin
            if i = 1 then
              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  TimeToStr(!TableName!.getTimeMap(Self.Buf, Self.posData, propIndex));')
            else
              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  TimeToStr(!TableName!.getTimeMap(Self.Buf, Self.posData, propIndex));');
          end;
        end;

      end;



      'b'://boolean
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  BoolToStr(!TableName!.getBooleanMap(Self.Buf, Self.posData, propIndex), true);')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  BoolToStr(!TableName!.getBooleanMap(Self.Buf, Self.posData, propIndex), true);');
      end;
      't': //tLogicalSet
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str :=  !TableName!.Logical' + logSizeStr + 'ToStr(!TableName!.getLogical' + logSizeStr + 'Map(Self.Buf, Self.posData, propIndex));')
        else
          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str :=  !TableName!.Logical' + logSizeStr + 'ToStr(!TableName!.getLogical' + logSizeStr + 'Map(Self.Buf, Self.posData, propIndex));');
      end;
    end;


  end;
end;

function TfrmMainGenerator.getProcCellFromMap1: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if i = 1 then
      Result.Add('!TableName!_' + vlsProp.Keys[i] + ': str := !TableName!.ValueToString(propIndex, '
                 + ConvertValueToString1(vlsProp.Values[vlsProp.Keys[i]]))
    else
      Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': str := !TableName!.ValueToString(propIndex, '
                 + ConvertValueToString1(vlsProp.Values[vlsProp.Keys[i]]));
  end;
end;

function TfrmMainGenerator.getProcDisplayLogicalName: TStringList;
var
  i: Integer;
  logicalLine, logicalFlags: string;
  flags: TArray<string>;
begin
  Result := TStringList.Create;

  // намираме реда с "Logical=" от таблицата
  logicalLine := '';
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if StartsText('Logical', vlsProp.Cells[0, i]) then
    begin
      logicalLine := vlsProp.Cells[1, i];
      Break;
    end;
  end;

  if logicalLine <> '' then
  begin
    // взимаме частта след двоеточието
    logicalFlags := Copy(logicalLine, Pos(':', logicalLine) + 1, MaxInt);
    flags := logicalFlags.Split([',']);

    for i := 0 to High(flags) do
      Result.Add(Format('    %d: Result := ''%s'';', [i, Trim(flags[i])]));
  end;
end;


function TfrmMainGenerator.getProcDisplayName: TStringList;
var
  i: Integer;
begin
  //piIncMdnId: Result := 'piIncMdnId';
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if i = 1 then
      Result.Add('!TableName!_' + vlsProp.Keys[i] + ': Result := ''' + vlsProp.Keys[i] + ''';')
    else
      Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': Result := ''' + vlsProp.Keys[i] + ''';');
  end;
end;

function TfrmMainGenerator.getProcIndexValue: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    case vlsProp.Values[vlsProp.Keys[i]][1] of
      'i'://integer
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;')
        else
          Result.Add('      ' + '!TableName!_' + vlsProp.Keys[i] + ': TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;');
      end;

      'w'://word
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;')
        else
          Result.Add('      ' + '!TableName!_' + vlsProp.Keys[i] + ': TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;');
      end;
//      'c'://cardinal
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);');
//      end;
//
//      'S'://stringove
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;');
//      end;
//
     'A'://Ansi stringove
      begin
        if i = 1 then
        begin
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ':') ;
          Result.Add('begin');
          Result.Add('  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);');
          Result.Add('  if TempItem.IndexAnsiStr <> nil then');
          Result.Add('  begin');
          Result.Add('    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);');
          Result.Add('  end');
          Result.Add('  else');
          Result.Add('    TempItem.IndexAnsiStr1 := '''';');
          Result.Add('end;');
        end
        else
        begin
          Result.Add('      !TableName!_' + vlsProp.Keys[i] + ':') ;
          Result.Add('      begin');
          Result.Add('        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);');
          Result.Add('        if TempItem.IndexAnsiStr <> nil then');
          Result.Add('        begin');
          Result.Add('          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);');
          Result.Add('        end');
          Result.Add('        else');
          Result.Add('          TempItem.IndexAnsiStr1 := '''';');
          Result.Add('      end;');
        end;
      end;
//
//      'T':
//      begin
//        case vlsProp.Values[vlsProp.Keys[i]][2] of
//          'D'://Date
//          begin
//            if i = 1 then
//              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);')
//            else
//              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);');
//          end;
//
//          'T'://Time
//          begin
//            if i = 1 then
//              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);')
//            else
//              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);');
//          end;
//        end;
//      end;
//
//
//
//      'b'://boolean
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);');
//      end;
//      't': //tLogicalSet
//      begin
//
//      end;
    end;



  end;
end;

function TfrmMainGenerator.getProcSetTextField: TStringList;
var
  i: Integer;
  fldName, fldType: string;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    fldName := Trim(vlsProp.Cells[0, i]);
    fldType := Trim(LowerCase(vlsProp.Cells[1, i]));

    if fldType.Contains('ansistring') or fldType.Contains('string') then
      Result.Add(Format('    !TableName!_%s: ListForFinder[0].PRecord.%s := AText;', [fldName, fldName]));
  end;
end;


function TfrmMainGenerator.getProcSetDateField: TStringList;
var
  i: Integer;
  fldName, fldType: string;
begin
  Result := TStringList.Create;
  Result.Add('    case T!TableName!Item.TPropertyIndex(Field) of');


  for i := 1 to vlsProp.RowCount - 1 do
  begin
    fldName := Trim(vlsProp.Cells[0, i]);
    fldType := Trim(LowerCase(vlsProp.Cells[1, i]));

    if fldType.Contains('tdate') or fldType.Contains('ttime') or fldType.Contains('timestamp') then
      Result.Add(Format('    !TableName!_%s: ListForFinder[0].PRecord.%s := Value;', [fldName, fldName]));
  end;
  if Result.Count > 1 then
    Result.Add('    end;')
  else
    Result.Clear;
end;


function TfrmMainGenerator.getProcSetNumField: TStringList;
var
  i: Integer;
  fldName, fldType: string;
begin
  Result := TStringList.Create;
  Result.Add('    case T!TableName!Item.TPropertyIndex(Field) of');
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    fldName := Trim(vlsProp.Cells[0, i]);
    fldType := Trim(LowerCase(vlsProp.Cells[1, i]));

    if fldType.Contains('integer') or fldType.Contains('word') or fldType.Contains('double') or
       fldType.Contains('cardinal') or fldType.Contains('int64') then
      Result.Add(Format('    !TableName!_%s: ListForFinder[0].PRecord.%s := Value;', [fldName, fldName]));
  end;
  if Result.Count > 1 then
    Result.Add('    end;')
  else
    Result.Clear;
end;


function TfrmMainGenerator.getProcSetLogicalField: TStringList;
var
  i: Integer;
  fldName, fldType: string;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    fldName := Trim(vlsProp.Cells[0, i]);
    fldType := Trim(LowerCase(vlsProp.Cells[1, i]));

    if fldType.Contains('tlogical') or fldType.Contains('bool') then
      Result.Add(Format('    !TableName!_%s: ListForFinder[0].PRecord.%s := Value;', [fldName, fldName]));
  end;
end;

function TfrmMainGenerator.getProcInsert: TStringList;
var
  i: Integer;
begin
  //piIncMdnId: SaveData(PRecord.piIncMdnId, PropPosition, metaPosition, dataPosition);
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]].StartsWith( 'tLogicalSet:') then
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SaveData(TLogicalData' + logSizeStr + '(PRecord.Logical),' +
                   ', PropPosition, metaPosition, dataPosition);')
      else
        Result.Add('            ' + '!TableName!_' +  vlsProp.Keys[i] + ': SaveData(TLogicalData' + logSizeStr + '(PRecord.Logical),' +
                   ' PropPosition, metaPosition, dataPosition);');
        Exit;
    end;

    if i = 1 then
      Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SaveData(PRecord.' +
                 vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);')
    else
      Result.Add('            ' + '!TableName!_' +  vlsProp.Keys[i] + ': SaveData(PRecord.' +
                 vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);');
  end;
end;

function TfrmMainGenerator.getProcIsFullFinded: TStringList;
var
  i: Integer;
begin
  //PatientNew_BABY_NUMBER: Result := IsFinded(ATempItem.PRecord.BABY_NUMBER, buf, FPosDataADB, word(PatientNew_BABY_NUMBER), cot);
  //IsFinded(TLogicalData32(ATempItem.PRecord.Logical), buf, FPosDataADB, word(PatientNew_Logical), cot);
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]].StartsWith( 'tLogicalSet:') then
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': Result := IsFinded(TLogicalData' + logSizeStr + '(ATempItem.PRecord.Logical),' +
                   ' buf, FPosDataADB, word(' + '!TableName!_' + vlsProp.Keys[i]  + '), cot);')
      else
        Result.Add('            ' + '!TableName!_' + vlsProp.Keys[i] + ': Result := IsFinded(TLogicalData' + logSizeStr + '(ATempItem.PRecord.Logical),' +
                   ' buf, FPosDataADB, word(' + '!TableName!_' + vlsProp.Keys[i]  + '), cot);');
    end
    else
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': Result := IsFinded(ATempItem.PRecord.' +
                   vlsProp.Keys[i] + ', buf, FPosDataADB, word(' + '!TableName!_' + vlsProp.Keys[i]  + '), cot);')
      else
        Result.Add('            ' + '!TableName!_' + vlsProp.Keys[i] + ': Result := IsFinded(ATempItem.PRecord.' +
                   vlsProp.Keys[i] + ', buf, FPosDataADB, word(' + '!TableName!_' + vlsProp.Keys[i]  + '), cot);');
    end;
  end;
end;

function TfrmMainGenerator.getProcSave: TStringList;
var
  i: Integer;
begin
  //piIncMdnId: SaveData(PRecord.piIncMdnId, PropPosition, metaPosition, dataPosition);
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]].StartsWith( 'tLogicalSet:') then
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SaveData(TLogicalData' + logSizeStr + '(PRecord.Logical),' +
                   ' PropPosition, metaPosition, dataPosition);')
      else
        Result.Add('            ' + '!TableName!_' + vlsProp.Keys[i] + ': SaveData(TLogicalData' + logSizeStr + '(PRecord.Logical),' +
                   ' PropPosition, metaPosition, dataPosition);');
    end
    else
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SaveData(PRecord.' +
                   vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);')
      else
        Result.Add('            ' + '!TableName!_' + vlsProp.Keys[i] + ': SaveData(PRecord.' +
                   vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);');
    end;
  end;
end;

function TfrmMainGenerator.getProcSetCell: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': !TableName!.PRecord.' +
                   vlsProp.Keys[i] + ConvertStringToValue(vlsProp.Values[vlsProp.Keys[i]]))
      else
        Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': !TableName!.PRecord.' +
                   vlsProp.Keys[i] + ConvertStringToValue(vlsProp.Values[vlsProp.Keys[i]]));
    end;
  end;
end;

function TfrmMainGenerator.getProcSetField: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if i = 1 then
      Result.Add('!TableName!_' + vlsProp.Keys[i] + ': !TableName!.PRecord.' +
                 vlsProp.Keys[i] + ConvertStringToField(vlsProp.Values[vlsProp.Keys[i]]))
    else
      Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': !TableName!.PRecord.' +
                 vlsProp.Keys[i] + ConvertStringToField(vlsProp.Values[vlsProp.Keys[i]]));
  end;
end;

function TfrmMainGenerator.getProcSetSearchingValue: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    case vlsProp.Values[vlsProp.Keys[i]][1] of
      'i'://integer
      begin
        if i = 1 then
        begin
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': ');
          Result.Add('begin');
          Result.Add('  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then');
          Result.Add('  begin');
          Result.Add('    List!TableName!Search.Add(self.Items[i]);');
          Result.Add('  end;');
          Result.Add('end;');
        end
        else
        begin
          Result.Add('      !TableName!_' + vlsProp.Keys[i] + ': ');
          Result.Add('      begin');
          Result.Add('        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then');
          Result.Add('        begin');
          Result.Add('          List!TableName!Search.Add(self.Items[i]);');
          Result.Add('        end;');
          Result.Add('      end;');
        end;
      end;

     'w'://word
      begin
        if i = 1 then
        begin
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': ');
          Result.Add('begin');
          Result.Add('  if IntToStr(self.Items[i].IndexWord) = FSearchingValue then');
          Result.Add('  begin');
          Result.Add('    List!TableName!Search.Add(self.Items[i]);');
          Result.Add('  end;');
          Result.Add('end;');
        end
        else
        begin
          Result.Add('      !TableName!_' + vlsProp.Keys[i] + ': ');
          Result.Add('      begin');
          Result.Add('        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then');
          Result.Add('        begin');
          Result.Add('          List!TableName!Search.Add(self.Items[i]);');
          Result.Add('        end;');
          Result.Add('      end;');
        end;
      end;
//      'c'://cardinal
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);');
//      end;
//
//      'S'://stringove
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;');
//      end;
//
     'A'://Ansi stringove
      begin
        if i = 1 then
        begin
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ':') ;
          Result.Add('begin');
          Result.Add('  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then');
          Result.Add('  begin');
          Result.Add('    List!TableName!Search.Add(self.Items[i]);');
          Result.Add('  end;');
          Result.Add('end;');
        end
        else
        begin
          Result.Add('      !TableName!_' + vlsProp.Keys[i] + ':') ;
          Result.Add('      begin');
          Result.Add('        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then');
          Result.Add('        begin');
          Result.Add('          List!TableName!Search.Add(self.Items[i]);');
          Result.Add('        end;');
          Result.Add('      end;');
        end;
      end;
//
//      'T':
//      begin
//        case vlsProp.Values[vlsProp.Keys[i]][2] of
//          'D'://Date
//          begin
//            if i = 1 then
//              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);')
//            else
//              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);');
//          end;
//
//          'T'://Time
//          begin
//            if i = 1 then
//              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);')
//            else
//              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);');
//          end;
//        end;
//      end;
//
//
//
//      'b'://boolean
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);');
//      end;
//      't': //tLogicalSet
//      begin
//
//      end;
    end;



  end;
end;

//function TfrmMainGenerator.getProcImportXMLNzis: TStringList;
//var
//  i: Integer;
//  fld, propEnum: string;
//begin
//  Result := TStringList.Create;
//
//  Result.Add('  Acl000 := TCL000EntryCollection(cl000);');
//  Result.Add('');
//  Result.Add('  // --- Build index mapping between XML meta fields and DDL properties ---');
//  Result.Add('  SetLength(idx, 0);');
//  Result.Add('  j := 0;');
//  Result.Add('');
//  Result.Add('  for propIdx := Low(T!TableName!Item.TPropertyIndex) to High(T!TableName!Item.TPropertyIndex) do');
//  Result.Add('  begin');
//  Result.Add('    propName := TRttiEnumerationType.GetName(propIdx);');
//  Result.Add('');
//  Result.Add('    // Skip technical');
//  Result.Add('    if SameText(propName, ''!TableName!_Key'') then Continue;');
//  Result.Add('    if SameText(propName, ''!TableName!_Description'') then Continue;');
//  Result.Add('    if SameText(propName, ''!TableName!_Logical'') then Continue;');
//  Result.Add('');
//  Result.Add('    // Remove prefix e.g. "CL000_"');
//  Result.Add('    xmlName := propName.Substring(' + IntToStr(Length(edtNameTable.Text) + 1) + ');');
//  Result.Add('');
//  Result.Add('    // Convert property name to XML name (replace "_" with " ")');
//  Result.Add('    xmlName := xmlName.Replace(''_'', '' '');');
//  Result.Add('');
//  Result.Add('    // Find matching meta-field index');
//  Result.Add('    for i := 0 to Acl000.FieldsNames.Count - 1 do');
//  Result.Add('    begin');
//  Result.Add('      if SameText(Acl000.FieldsNames[i], xmlName) or SameText(Acl000.FieldsNames[i], propName.Substring(' + IntToStr(Length(edtNameTable.Text) + 1) + ')) then');
//  Result.Add('      begin');
//  Result.Add('        SetLength(idx, Length(idx)+1);');
//  Result.Add('        idx[High(idx)] := i;');
//  Result.Add('        Break;');
//  Result.Add('      end;');
//  Result.Add('    end;');
//  Result.Add('  end;');
//  Result.Add('');
//  Result.Add('  // --- Insert rows from XML into the generated collection ---');
//  Result.Add('  for i := 0 to Acl000.Count - 1 do');
//  Result.Add('  begin');
//  Result.Add('    entry := Acl000.Items[i];');
//  Result.Add('    TempItem := T!TableName!Item(Self.Add);');
//  Result.Add('    New(TempItem.PRecord);');
//  Result.Add('    TempItem.PRecord.setProp := [];');
//  Result.Add('');
//  Result.Add('    // Key');
//  Result.Add('    TempItem.PRecord.Key := entry.Key;');
//  Result.Add('    Include(TempItem.PRecord.setProp, !TableName!_Key);');
//  Result.Add('');
//  Result.Add('    // Description');
//  Result.Add('    TempItem.PRecord.Description := entry.Descr;');
//  Result.Add('    Include(TempItem.PRecord.setProp, !TableName!_Description);');
//  Result.Add('');
//  Result.Add('    j := 0;');
//  Result.Add('');
//  // генериране на всички полета, без първите 2 и едно за заглавието на vlsProp
//  for i := 3 to vlsProp.RowCount - 1 do
//  begin
//    fld := vlsProp.Keys[i];               // e.g. "DescriptionEn"
//    if fld = 'Logical' then continue;
//
//    propEnum := '!TableName!_' + fld; // e.g. "CL006_DescriptionEn"
//
//    Result.Add('    // ' + fld);
//    Result.Add('    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then');
//    Result.Add('    begin');
//    Result.Add('      TempItem.PRecord.' + fld + ' := entry.FMetaDataFields[idx[j]].Value;');
//    Result.Add('      Include(TempItem.PRecord.setProp, ' + propEnum + ');');
//    Result.Add('    end;');
//    Result.Add('    Inc(j);');
//    Result.Add('');
//  end;
//
//  Result.Add('    TempItem.Insert!TableName!;');
//  Result.Add('    Self.streamComm.Len := Self.streamComm.Size;');
//  Result.Add('    Self.cmdFile.CopyFrom(Self.streamComm, 0);');
//  Result.Add('    Dispose(TempItem.PRecord);');
//  Result.Add('    TempItem.PRecord := nil;');
//  Result.Add('  end;');
//
//
//end;
//DDL property name
function TfrmMainGenerator.getProcImportXMLNzis: TStringList;
var
  i: Integer;
  fld, propEnum: string;
begin
  Result := TStringList.Create;

  Result.Add('  Acl000 := TCL000EntryCollection(cl000);');
  Result.Add('  IsNew := Count = 0;');
  Result.Add('');

  // ==== OLD → mark all existing as OLD (except deleted) ====
  Result.Add('  for i := 0 to Count - 1 do');
  Result.Add('  begin');
  Result.Add('    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ct!TableName!Del) then');
  Result.Add('      Continue;');
  Result.Add('    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ct!TableName!Old);');
  Result.Add('  end;');
  Result.Add('');

  // ==== KEY DICT ====
  Result.Add('  BuildKeyDict(Ord(!TableName!_Key));');
  Result.Add('');

  // ==== BUILD XML INDEX MAP ====
  Result.Add('  j := 0;');
  Result.Add('  SetLength(idx, 0);');
  Result.Add('');
  Result.Add('  for propIdx := Low(T!TableName!Item.TPropertyIndex) to High(T!TableName!Item.TPropertyIndex) do');
  Result.Add('  begin');
  Result.Add('    propName := TRttiEnumerationType.GetName(propIdx);');
  Result.Add('');
  Result.Add('    if SameText(propName, ''!TableName!_Key'') then Continue;');
  Result.Add('    if SameText(propName, ''!TableName!_Description'') then Continue;');
  Result.Add('    if SameText(propName, ''!TableName!_Logical'') then Continue;');
  Result.Add('');
  Result.Add('    xmlName := propName.Substring(Length(''!TableName!_''));');
  Result.Add('    xmlName := xmlName.Replace(''_'', '' '');');
  Result.Add('');
  Result.Add('    for i := 0 to Acl000.FieldsNames.Count - 1 do');
  Result.Add('      if SameText(Acl000.FieldsNames[i], xmlName) or');
  Result.Add('         SameText(Acl000.FieldsNames[i], xmlName.Replace('' '', ''_'')) then');
  Result.Add('      begin');
  Result.Add('        SetLength(idx, Length(idx)+1);');
  Result.Add('        idx[High(idx)] := i;');
  Result.Add('        Break;');
  Result.Add('      end;');
  Result.Add('  end;');
  Result.Add('');

  // ==== PROCESS XML ENTRIES ====
  Result.Add('  for i := 0 to Acl000.Count - 1 do');
  Result.Add('  begin');
  Result.Add('    entry := Acl000.Items[i];');
  Result.Add('');
  Result.Add('    if KeyDict.TryGetValue(entry.Key, idxOld) then');
  Result.Add('    begin');
  Result.Add('      item := Items[idxOld];');
  Result.Add('      kindDiff := dkChanged;');
  Result.Add('    end');
  Result.Add('    else');
  Result.Add('    begin');
  Result.Add('      item := T!TableName!Item(Add);');
  Result.Add('      kindDiff := dkNew;');
  Result.Add('    end;');
  Result.Add('');

  Result.Add('    if item.PRecord <> nil then');
  Result.Add('      Dispose(item.PRecord);');
  Result.Add('    New(item.PRecord);');
  Result.Add('    item.PRecord.setProp := [];');
  Result.Add('');

  // ==== KEY ====
  Result.Add('    newValue := entry.Key;');
  Result.Add('    oldValue := getAnsiStringMap(item.DataPos, Ord(!TableName!_Key));');
  Result.Add('    item.PRecord.Key := newValue;');
  Result.Add('    if oldValue <> newValue then Include(item.PRecord.setProp, !TableName!_Key);');
  Result.Add('');

  // ==== DESCRIPTION ====
  Result.Add('    newValue := entry.Descr;');
  Result.Add('    oldValue := getAnsiStringMap(item.DataPos, Ord(!TableName!_Description));');
  Result.Add('    item.PRecord.Description := newValue;');
  Result.Add('    if oldValue <> newValue then Include(item.PRecord.setProp, !TableName!_Description);');
  Result.Add('');

  // ==== DYNAMIC META FIELDS ====
  Result.Add('    j := 0;');

  for i := 3 to vlsProp.RowCount - 1 do
  begin
    fld := vlsProp.Keys[i];               // e.g. "DescriptionEn"
    if fld = 'Logical' then continue;

    propEnum := '!TableName!_' + fld; // e.g. "CL006_DescriptionEn"

    Result.Add('    // ' + fld);
    Result.Add('    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then');
    Result.Add('    begin');
    Result.Add('      newValue := entry.FMetaDataFields[idx[j]].Value;');
    Result.Add('      oldValue := getAnsiStringMap(item.DataPos, Ord(' + propEnum + '));');
    Result.Add('');
    Result.Add('      Item.PRecord.' + fld + ' := entry.FMetaDataFields[idx[j]].Value;');
    Result.Add('      if (oldValue <> newValue) then Include(item.PRecord.setProp, ' + propEnum + ');');
    Result.Add('    end;');
    Result.Add('    Inc(j);');
    Result.Add('');

  end;
  // ==== INSERT / UPDATE decision ====
  Result.Add('    // NEW');
  Result.Add('    if kindDiff = dkNew then');
  Result.Add('    begin');
  Result.Add('      if IsNew then');
  Result.Add('      begin');
  Result.Add('        item.Insert!TableName!;');
  Result.Add('        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ct!TableName!);');
  Result.Add('        Self.streamComm.Len := Self.streamComm.Size;');
  Result.Add('        Self.cmdFile.CopyFrom(Self.streamComm, 0);');
  Result.Add('        Dispose(item.PRecord);');
  Result.Add('        item.PRecord := nil;');
  Result.Add('      end;');
  Result.Add('    end');
  Result.Add('    else');
  Result.Add('    begin');
  Result.Add('      // UPDATE');
  Result.Add('      if item.PRecord.setProp <> [] then');
  Result.Add('      begin');
  Result.Add('        if IsNew then');
  Result.Add('        begin');
  Result.Add('          pCardinalData := pointer(PByte(Buf) + 12);');
  Result.Add('          dataPosition := pCardinalData^ + PosData;');
  Result.Add('          item.Save!TableName!(dataPosition);');
  Result.Add('          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ct!TableName!);');
  Result.Add('          Self.streamComm.Len := Self.streamComm.Size;');
  Result.Add('          Self.cmdFile.CopyFrom(Self.streamComm, 0);');
  Result.Add('          pCardinalData^ := dataPosition - PosData;');
  Result.Add('        end');
  Result.Add('        else');
  Result.Add('          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ct!TableName!);');
  Result.Add('      end');
  Result.Add('      else');
  Result.Add('      begin');
  Result.Add('        Dispose(item.PRecord);');
  Result.Add('        item.PRecord := nil;');
  Result.Add('        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ct!TableName!);');
  Result.Add('      end;');
  Result.Add('    end;');
  Result.Add('  end;');
end;





function TfrmMainGenerator.getProcSortByIndexValue: TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    case vlsProp.Values[vlsProp.Keys[i]][1] of
      'i'://integer
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SortByIndexInt;')
        else
          Result.Add('      ' + '!TableName!_' + vlsProp.Keys[i] + ': SortByIndexInt;');
      end;

      'w'://word
      begin
        if i = 1 then
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SortByIndexWord;')
        else
          Result.Add('      ' + '!TableName!_' + vlsProp.Keys[i] + ': SortByIndexWord;');
      end;
//      'c'://cardinal
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);');
//      end;
//
//      'S'://stringove
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getStringMap(Self.Buf, Self.posData, ACol) = AValue;');
//      end;
//
     'A'://Ansi stringove
      begin
        if i = 1 then
        begin
          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': SortByIndexAnsiString;') ;
        end
        else
        begin
          Result.Add('      !TableName!_' + vlsProp.Keys[i] + ': SortByIndexAnsiString;') ;
        end;
      end;
//
//      'T':
//      begin
//        case vlsProp.Values[vlsProp.Keys[i]][2] of
//          'D'://Date
//          begin
//            if i = 1 then
//              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);')
//            else
//              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);');
//          end;
//
//          'T'://Time
//          begin
//            if i = 1 then
//              Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);')
//            else
//              Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getTimeMap(Self.Buf, Self.posData, ACol) = StrToTime(AValue);');
//          end;
//        end;
//      end;
//
//
//
//      'b'://boolean
//      begin
//        if i = 1 then
//          Result.Add('!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);')
//        else
//          Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': isOld :=  !TableName!.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);');
//      end;
//      't': //tLogicalSet
//      begin
//
//      end;
    end;



  end;
end;

function TfrmMainGenerator.getProcTRec: TStringList;
var
  i, j: Integer;
  prefix: string;
  SetStr: string;
  arrStr: TArray<String>;
  LogSize, fldSize: Integer;
begin

  //piIncMdnId: integer;
  if ((vlsProp.RowCount - 1) mod 8 ) = 0 then
  begin
    fldSize := ((vlsProp.RowCount - 1) div 8) * 8;
  end
  else
  begin
    fldSize := (((vlsProp.RowCount - 1) div 8) + 1) * 8;
  end;
  fldSizeStr := Format('%.2d', [fldSize]);

  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    prefix := '';
    if vlsProp.Values[vlsProp.Keys[i]] = 'DATE' then
      prefix := 'T';
    if vlsProp.Values[vlsProp.Keys[i]] = 'TIME' then
      prefix := 'T';
    if vlsProp.Values[vlsProp.Keys[i]].StartsWith( 'tLogicalSet') then
    begin
      FTLogical.Text := 'TLogical!TableName! = (';
      SetStr := Copy(vlsProp.Values[vlsProp.Keys[i]], 13, length(vlsProp.Values[vlsProp.Keys[i]])- 12);
      arrStr  := setStr.Split([',']);
      for j := 0 to Length(arrStr) - 1 do
      begin
        if j = Length(arrStr) - 1 then
        begin
          FTLogical.Add('    ' + arrStr[j] + ');');
        end
        else
        begin
          FTLogical.Add('    ' + arrStr[j] + ',');
        end;
      end;
      FTLogical.Add('Tlogical!TableName!Set = set of TLogical!TableName!;');
      Result.Add('        ' + vlsProp.Keys[i] + ': Tlogical!TableName!Set' + ';');



      if (Length(arrStr) mod 8) = 0 then
      begin
        LogSize := ((Length(arrStr) div 8)) * 8;
      end
      else
      begin
        LogSize := ((Length(arrStr) div 8) + 1) * 8;
      end;
      logSizeStr := Format('%.2d', [logSize]);

      Continue;
    end;
    if i = 1 then
      Result.Add(vlsProp.Keys[i] + ': ' + prefix + vlsProp.Values[vlsProp.Keys[i]] + ';')
    else
      Result.Add('        ' + vlsProp.Keys[i] + ': ' + prefix + vlsProp.Values[vlsProp.Keys[i]] + ';');

  end;
end;

function TfrmMainGenerator.getProcUpdate: TStringList;
var
  i: Integer;
begin
  //piIncMdnId: UpdateData(PRecord.piIncMdnId, PropPosition, metaPosition, dataPosition);
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Values[vlsProp.Keys[i]].StartsWith( 'tLogicalSet') then
    begin
      //if i = 1 then
//        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': UpdateData(PRecord.' +
//                   vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);')
//      else
//        Result.Add('            ' + '!TableName!_' + vlsProp.Keys[i] + ': UpdateData(PRecord.' +
//                   vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);');
    end
    else
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': UpdateData(PRecord.' +
                   vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);')
      else
        Result.Add('            ' + '!TableName!_' + vlsProp.Keys[i] + ': UpdateData(PRecord.' +
                   vlsProp.Keys[i] + ', PropPosition, metaPosition, dataPosition);');
    end;
  end;
end;

function TfrmMainGenerator.getPropertyIndex: string;
var
  i: Integer;
  arr: array of string;
begin
  SetLength(arr, vlsProp.RowCount - 1);
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if i = 1 then
    begin
      arr[i - 1] := '       !TableName!_' + vlsProp.Keys[i];
    end
    else
    begin
     arr[i - 1] := '!TableName!_' + vlsProp.Keys[i];
    end;
  end;
  Result := 'TPropertyIndex = (' + #13#10 + Result.Join(#13#10 + '       , ', arr) + #13#10'       );';
end;



function TfrmMainGenerator.getTLogical: TStringList;
begin

end;

function TfrmMainGenerator.getVirtualTrees: string;
begin
  if true then
    Result := ', VirtualTrees'
  else
    Result := '';
end;

function TfrmMainGenerator.IsTreeLink: Boolean;
begin
  Result := vlsProp.Values[vlsProp.Keys[1]] = 'PVirtualNode';
end;

procedure TfrmMainGenerator.SetfldSizeStr(const Value: string);
begin
  FfldSizeStr := Value;
end;

procedure TfrmMainGenerator.SetlogSizeStr(const Value: string);
begin
  FlogSizeStr := Value;
end;

function TfrmMainGenerator.GetProcPropType: TStringList;
var
  i: Integer;
begin
  //PatientNew_EGN: Result := actAnsiString;
  Result := TStringList.Create;
  for i := 1 to vlsProp.RowCount - 1 do
  begin
    if vlsProp.Keys[i] = 'Logical' then
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': Result := actLogical;' )
      else
        Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': Result := actLogical;');
    end
    else
    begin
      if i = 1 then
        Result.Add('!TableName!_' + vlsProp.Keys[i] + ': Result := act' + vlsProp.Values[vlsProp.Keys[i]] + ';')
      else
        Result.Add('    ' + '!TableName!_' + vlsProp.Keys[i] + ': Result := act' + vlsProp.Values[vlsProp.Keys[i]]+ ';');
    end;
  end;
end;

function TfrmMainGenerator.IsNzisNomenclature(const s: string): Boolean;
begin
  // CL + exactly 3 digits
  Result :=
     (Length(s) = 5) and
     (Copy(s,1,2) = 'CL') and
     (CharInSet(s[3], ['0'..'9'])) and
     (CharInSet(s[4], ['0'..'9'])) and
     (CharInSet(s[5], ['0'..'9']));
end;

procedure TfrmMainGenerator.RemoveTaggedBlock(sl: TStrings; const startTag, endTag: string; AStartOf: integer = -1);
var
  i, startIdx, endIdx: Integer;
begin
  startIdx := AStartOf;
  endIdx := -1;

  // find start tag
  for i := 0 to sl.Count - 1 do
    if Pos('{' + startTag + '}', sl[i]) > 0 then
    begin
      startIdx := i;
      Break;
    end;

  if startIdx = -1 then Exit; // no block → nothing to remove

  // find end tag
  for i := startIdx + 1 to sl.Count - 1 do
    if Pos('{' + endTag + '}', sl[i]) > 0 then
    begin
      endIdx := i;
      Break;
    end;

  if endIdx = -1 then Exit; // malformed → fail safe

  // delete EVERYTHING including the tags
  for i := endIdx downto startIdx do
    sl.Delete(i);

  RemoveTaggedBlock(sl, startTag, endTag, startIdx);

end;


end.

