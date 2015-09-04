unit Sub6_ideOptionsEditor;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}

     Sub6,
IDEOptionsIntf, ProjectIntf, ProjectResourcesIntf, StdCtrls,
  Sub6_ideOptionsConfig,Sub6_ideProjectResources, Dialogs;

type

  { TSub6_ideOptionsEditor }

  TSub6_ideOptionsEditor = class(TAbstractIDEOptionsEditor)
    CheckBox1: TCheckBox;
  public
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  public
    function GetTitle:string; override;
  public
    procedure Setup(ADialog:TAbstractOptionsEditorDialog);  override;
    procedure ReadSettings(AOptions:TAbstractIDEOptions);   override;
    procedure WriteSettings(AOptions:TAbstractIDEOptions);  override;
  end;

implementation

{$R *.lfm}

function TSub6_ideOptionsEditor.GetTitle:String;
begin
    result:='Sub6';
end;

//------------------------------------------------------------------------------

procedure TSub6_ideOptionsEditor.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
    CheckBox1.Checked:=false;
    //----
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.Setup <<< END');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure TSub6_ideOptionsEditor.ReadSettings(AOptions:TAbstractIDEOptions);
var Sub6_RSRC:tSub6_ideProjectResources;
begin
    Sub6_RSRC:=Sub6_INSTANCE.ActiveProject_Sub6Resources;
    if Assigned(Sub6_RSRC) then begin
       CheckBox1.Checked:=Sub6_RSRC.used;
       {$ifDef lazExt_Sub6_EventLOG_mode}
           DEBUG(self.ClassName+'.ReadSettings [ Sub6_RSRC'+addr2txt(Sub6_RSRC)+']');
       {$endIf}
    end
    {$ifDef lazExt_Sub6_EventLOG_mode}
    else begin
        DEBUG(self.ClassName+'.ReadSettings [ERR]:Sub6_RSRC=NIL');
    end
    {$endIf};
end;

procedure TSub6_ideOptionsEditor.WriteSettings(AOptions:TAbstractIDEOptions);
var Sub6_RSRC:tSub6_ideProjectResources;
begin
    Sub6_RSRC:=Sub6_INSTANCE.ActiveProject_Sub6Resources;
    if Assigned(Sub6_RSRC) then begin
        Sub6_RSRC.used:=CheckBox1.Checked;
        {$ifDef lazExt_Sub6_EventLOG_mode}
            DEBUG(self.ClassName+'.WriteSettings [ Sub6_RSRC'+addr2txt(Sub6_RSRC)+']');
        {$endIf}
    end
    {$ifDef lazExt_Sub6_EventLOG_mode}
    else begin
        DEBUG(self.ClassName+'.WriteSettings [ERR]:Sub6_RSRC=NIL');
    end
    {$endIf};
end;

//------------------------------------------------------------------------------

class function TSub6_ideOptionsEditor.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin // почемуто если тут указываем какой-то класс, то оно нифига не работет
      // нет вызовов ReadSettings и WriteSettings ... разбираться нада
      // в данном случае у нас есть обходной путь, которым и воспользуемся
      {todo : need brain}
    result:=nil;
    {$ifDef lazExt_Sub6_EventLOG_mode}
        //if Assigned(result)
        //then DEBUG(self.ClassName+'.SupportedOptionsClass = '+addr2txt(result)+' : '+result.ClassName)
        //else DEBUG(self.ClassName+'.SupportedOptionsClass = NIL');
    {$endIf}
end;

end.

