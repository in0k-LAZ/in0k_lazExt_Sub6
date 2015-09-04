{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_Sub6;

interface

uses
  Sub6_REG, Sub6, Sub6_ideMacro, Sub6_ideMacro_LIST, Sub6_ideOptionsEditor, 
  Sub6_ideOptionsConfig, Sub6_ideProjectResources, Sub6_wndDebug, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Sub6_REG', @Sub6_REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_Sub6', @Register);
end.
