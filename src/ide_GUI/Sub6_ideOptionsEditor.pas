unit Sub6_ideOptionsEditor;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}

uses {$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}

     Sub6, LazIDEIntf,
IDEOptionsIntf, ProjectIntf, ProjectResourcesIntf, StdCtrls,
  Sub6_ideOptionsConfig,Sub6_ideProjectResources, Dialogs;

type

  { TSub6_ideOptionsEditor }

  TSub6_ideOptionsEditor = class(TAbstractIDEOptionsEditor)
    CheckBox1: TCheckBox;

  private
    function  _Sub6Resources_:tSub6_ideProjectResources;
  protected
    procedure doReadSettings (const Resources:TAbstractProjectResource); virtual;
    procedure doWriteSettings(const Resources:TAbstractProjectResource); virtual;
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

procedure TSub6_ideOptionsEditor.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
    CheckBox1.Checked:=false;
    //----
    {$ifDef lazExt_Sub6_EventLOG_mode}
        DEBUG(self.ClassName+'.Setup <<< END');
    {$endIf}
end;

//------------------------------------------------------------------------------

// ЧТЕНИЕ (копирование В визуальные компаненты) пользовательских настроек
procedure TSub6_ideOptionsEditor.doReadSettings(const Resources:TAbstractProjectResource);
begin
    with tSub6_ideProjectResources(Resources) do begin
        CheckBox1.Checked:=used;
    end;
end;

// ЗАПИСЬ (сохранение ИЗ визуальныех компанентов) пользовательских настроек
procedure TSub6_ideOptionsEditor.doWriteSettings(const Resources:TAbstractProjectResource);
begin
    with tSub6_ideProjectResources(Resources) do begin
        used:=CheckBox1.Checked;
    end;
end;

//------------------------------------------------------------------------------


function TSub6_ideOptionsEditor.GetTitle:String;
begin
    result:='Sub6';
end;

//------------------------------------------------------------------------------


//------------------------------------------------------------------------------

// получть ЭКЗЕМПЛЯР ресурсов 'Sub6' для текущего АКТИВНОГО проекта
function TSub6_ideOptionsEditor._Sub6Resources_:tSub6_ideProjectResources;
begin
    result:=nil;
    if Assigned(LazarusIDE) and                     //< -- такое чуство что
       Assigned(LazarusIDE.ActiveProject) and       //<    проверок слишком
       Assigned(LazarusIDE.ActiveProject.Resources) //<    много :-)
    then begin
        with TAbstractProjectResources(LazarusIDE.ActiveProject.Resources)
        do result:=tSub6_ideProjectResources(Resource[tSub6_ideProjectResources]);
    end;
end;

//------------------------------------------------------------------------------

procedure TSub6_ideOptionsEditor.ReadSettings(AOptions:TAbstractIDEOptions);
var Sub6_RSRC:tSub6_ideProjectResources;
begin
    Sub6_RSRC:=_Sub6Resources_;
    if Assigned(Sub6_RSRC) then begin
       doReadSettings(Sub6_RSRC);
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
    Sub6_RSRC:=_Sub6Resources_;
    if Assigned(Sub6_RSRC) then begin
        doWriteSettings(Sub6_RSRC);
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
begin
    // почемуто если тут указываем какой-то класс, то оно нифига не работет
    // нет вызовов ReadSettings и WriteSettings, видимо дело в типе
    // TAbstractIDEOptionsClass, надо брать кого-то из наследников ...
    // в данном случае у нас есть обходной путь, которым и воспользуемся
    result:=nil;
end;

end.

