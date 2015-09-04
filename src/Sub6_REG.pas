unit Sub6_REG;

{$mode objfpc}{$H+}

interface
{$I Sub6_INI.inc}
 uses
{$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
    Sub6,
Sub6_ideOptionsEditor, Sub6_ideProjectResources,
  IDEOptionsIntf, ProjectResourcesIntf;




procedure REGISTER;

implementation

procedure REGISTER;
begin
    Sub6_CRT8INIT;
    RegisterProjectResource(tSub6_ideProjectResources);
    RegisterIDEOptionsEditor(GroupProject, TSub6_ideOptionsEditor, ProjectOptionsVersionInfo-1);
    {$ifDef lazExt_Sub6_EventLOG_mode}
    Sub6_wndDebug.RegisterInIdeLAZARUS;
    {$endIf}
    Sub6_wndDebug.DEBUG_window_SHOW;

end;

end.

