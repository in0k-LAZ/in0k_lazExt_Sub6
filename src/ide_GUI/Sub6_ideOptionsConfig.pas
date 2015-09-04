unit Sub6_ideOptionsConfig;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
    LazIDEIntf, IDEOptionsIntf, ProjectIntf, DIALOGS;//,LazarusIDEStrConsts;


type

 tSub6_ideOptionsConfig=class(TAbstractIDEEnvironmentOptions)
  public
    class function GetGroupCaption:string;          override;
    class function GetInstance:TAbstractIDEOptions; override;
  end;

implementation

class function tSub6_ideOptionsConfig.GetGroupCaption:string;
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.GetGroupCaption >>><<<');
    {$endIf}
    result:='Sub6';
end;

{type

_tSub6_Project_=class(TLazProject)
  protected
    function _getIdeOPTIONs_:TAbstractIDEOptions;
  end;

function _tSub6_Project_._getIdeOPTIONs_:TAbstractIDEOptions;
begin
    result:=self.FIDEOptions;
end;  }

class function tSub6_ideOptionsConfig.GetInstance:TAbstractIDEOptions;
begin
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.GetInstance');
    {$endIf}
    //result:=nil;
    //if Assigned(LazarusIDE.ActiveProject)
    //then result:=_tSub6_Project_(LazarusIDE.ActiveProject)._getIdeOPTIONs_;
    //result:=TAbstractIDEOptions(tobject(LazarusIDE.ActiveProject));//.Resources;
    //if Assigned(result)
    //then ShowMessage('resource FIND:'+result.ClassName)
    //else ShowMessage('resource NOT FIND');
    result:=nil;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.GetInstance <<< Ok');
    {$endIf}
end;


var i:tSub6_ideOptionsConfig;

initialization
  i:= tSub6_ideOptionsConfig.Create;

  //RegisterIDEOptionsGroup(GroupProject+1, tSub6_ideOptionsConfig);


end.

