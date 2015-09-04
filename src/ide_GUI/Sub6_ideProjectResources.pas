unit Sub6_ideProjectResources;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
   ProjectResourcesIntf;

type
  tSub6_ideProjectResources=class(TAbstractProjectResource)
   protected
   _used_:boolean;
    procedure _used_set_(const value:boolean);
   public
    function  UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean; override;
    procedure WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;
    procedure ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String); override;

   public
    used:boolean;
   end;

implementation

function tSub6_ideProjectResources.UpdateResources(AResources: TAbstractProjectResources; const MainFilename: string): Boolean;
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.UpdateResources');
    {$endIf}
    result:=true;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.UpdateResources <<< END');
    {$endIf}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tSub6_ideProjectResources.WriteToProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteToProjectFile');
    {$endIf}
    //result:=true;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.WriteToProjectFile <<< END');
    {$endIf}
end;

procedure tSub6_ideProjectResources.ReadFromProjectFile(AConfig: {TXMLConfig}TObject; Path: String);
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadFromProjectFile');
    {$endIf}
    //result:=true;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.ReadFromProjectFile <<< END');
    {$endIf}
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

