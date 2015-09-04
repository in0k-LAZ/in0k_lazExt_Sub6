unit Sub6_ideOptionsEditor;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}


IDEOptionsIntf, ProjectIntf, ProjectResourcesIntf, StdCtrls,
  Sub6_ideOptionsConfig,Sub6_ideProjectResources, Dialogs;

type

  { TSub6_ideOptionsEditor }

  TSub6_ideOptionsEditor = class(TAbstractIDEOptionsEditor)
    CheckBox1: TCheckBox;
  public
    function GetTitle:string; override;
    procedure Setup(ADialog: TAbstractOptionsEditorDialog);  override;
    procedure ReadSettings(AOptions: TAbstractIDEOptions);   override;
    procedure WriteSettings(AOptions: TAbstractIDEOptions);  override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}


type
_tSub6_Project_=class(TLazProject)
  protected
    function _getIdeOPTIONs_:tSub6_ideProjectResources;
  end;

function _tSub6_Project_._getIdeOPTIONs_:tSub6_ideProjectResources;
var i:integer;
begin

  result:=tSub6_ideProjectResources(TAbstractProjectResources(Resources).Resource[tSub6_ideProjectResources]);
  if Assigned(result)
  then ShowMessage('resource FIND:'+result.ClassName)
  else ShowMessage('resource NOT FIND');

  {

  for i := 0 to Resources.Count - 1 do
  begin
    Result := TAbstractProjectResource(FResources[i]);
    if Result.InheritsFrom(AIndex) then
      Exit;
  end;
  Result := nil;
end;
    Result := TProjectVersionInfo(GetProjectResource(TProjectVersionInfo));
  }
end;







class function TSub6_ideOptionsEditor.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=tSub6_ideOptionsConfig;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.SupportedOptionsClass '+addr2txt(result));
    {$endIf}
end;

//------------------------------------------------------------------------------

function TSub6_ideOptionsEditor.GetTitle:String;
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.GetTitle');
    {$endIf}
    result:='Sub6';
end;

procedure TSub6_ideOptionsEditor.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.Setup');
    {$endIf}
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.Setup <<< END');
    {$endIf}
end;

procedure TSub6_ideOptionsEditor.ReadSettings(AOptions: TAbstractIDEOptions);
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadSettings');
    {$endIf}
    if Assigned(AOptions) //and
       //(TObject(AOptions). is TLazProject)
    then begin
       CheckBox1.Checked:=_tSub6_Project_(TObject(AOptions))._getIdeOPTIONs_.used;
    end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadSettings <<< END');
    {$endIf}
end;

procedure TSub6_ideOptionsEditor.WriteSettings(AOptions: TAbstractIDEOptions);
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteSettings');
    {$endIf}
    if Assigned(AOptions) //and
       //(TObject(AOptions) is TLazProject)
    then begin
       _tSub6_Project_(TObject(AOptions))._getIdeOPTIONs_.used:=CheckBox1.Checked;
    end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteSettings <<< END');
    {$endIf}
end;


initialization

  //RegisterIDEOptionsEditor(GroupProject, TSub6_ideOptionsEditor, ProjectOptionsVersionInfo-1);


end.

