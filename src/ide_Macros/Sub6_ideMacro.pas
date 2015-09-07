unit Sub6_ideMacro;

{$mode objfpc}{$H+}
interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
  MacroIntf,MacroDefIntf,sysutils;

type

 tSub6_TransferMacro=class(TTransferMacro)
  protected
    function _MacroFunction_(const Param:string; const Data:PtrInt; var Abort:boolean):string;
  public
    constructor Create;
  end;

implementation

constructor tSub6_TransferMacro.Create;
begin
    inherited Create('Sub6', '', 'About Sub6', @_MacroFunction_, []);
end;

function tSub6_TransferMacro._MacroFunction_(const Param:string; const Data:PtrInt; var Abort:boolean):string;
begin
    if SysUtils.CompareText(Param,'Sub6')=0 then
      Result:='OKOKOKOK'//Project1.CompilerOptions.GetSrcPath(false)
    {else if SysUtils.CompareText(Param,'IncPath')=0 then
      Result:=Project1.CompilerOptions.GetIncludePath(false)
    else if SysUtils.CompareText(Param,'UnitPath')=0 then
      Result:=Project1.CompilerOptions.GetUnitPath(false)
    else if SysUtils.CompareText(Param,'InfoFile')=0 then
      Result:=Project1.ProjectInfoFile
    else if SysUtils.CompareText(Param,'OutputDir')=0 then
      Result:=Project1.CompilerOptions.GetUnitOutPath(false) }
    else begin
      result:='qwerqwerqwer';
      //Result:='<Invalid parameter for macro Sub6:'+Param+'>';
      {if ConsoleVerbosity>=0 then
        debugln('WARNING: TMainIDE.MacroFuncProject: ',Result); }
    end;
  //end else begin
  //  Result:='';
  //end;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'._MacroFunction_ : Param="'+Param+'"'+' Data='+ptrI2txt(Data));
    {$endIf}
end;

end.
