unit Sub6_ideProjectResources;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
   Laz2_XMLCfg, //< !!! для работы ОБЯЗАТЕЛЬНО пользоваться этой библиотекой
   ProjectResourcesIntf;

type
 tSub6_ideProjectResources=class(TAbstractProjectResource)
  protected
    function _getConfigPATH_(const Path:string):string; virtual;
  protected
   _used_:boolean;
    procedure _used_set_(const value:boolean);
  public
    function  UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    procedure WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;
    procedure ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;
  public
    property used:boolean read _used_ write _used_set_;
  end;

implementation

function tSub6_ideProjectResources.UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean;
begin
    result:=true;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        if result
        then DEBUG(self.ClassName+'.UpdateResources=true : '+MainFilename)
        else DEBUG(self.ClassName+'.UpdateResources=FALSE : '+MainFilename);
    {$endIf}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tSub6_ideProjectResources.WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
    with TXMLConfig(AConfig) do begin
        SetDeleteValue(_getConfigPATH_(Path)+'USED', used, False);
    end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteToProjectFile  : '+Path);
    {$endIf}
end;

procedure tSub6_ideProjectResources.ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
    with TXMLConfig(AConfig) do begin
        used:=GetValue(_getConfigPATH_(Path)+'USED', False);
    end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadFromProjectFile : '+Path);
    {$endIf}
end;

//------------------------------------------------------------------------------

function tSub6_ideProjectResources._getConfigPATH_(const Path:string):string;
begin
    result:=Path+'Sub6/';
end;

//------------------------------------------------------------------------------

procedure tSub6_ideProjectResources._used_set_(const value:boolean);
begin
    if _used_<>value then begin
       _used_:=value;
        SetModified(true);
    end;
end;

end.

