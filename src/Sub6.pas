unit Sub6;

{$mode objfpc}{$H+}

interface

uses Sub6_ideProjectResources,Classes, SysUtils,

Sub6_node,
ProjectIntf,
       ProjectResourcesIntf,
  LazIDEIntf;


type

  // ГЛАВНЫЙ класс расширения. Связывает воедино весь функционал.
 tSub6=class
  public
    function NodeLIST_Insert(const List:tSub6_nodeList_core; Node:tSub6_node):boolean;

  public
    function _Sub6Resources_find_(const prj:TLazProject):tSub6_ideProjectResources;
    function ActiveProject_Sub6Resources:tSub6_ideProjectResources;



  end;





procedure Sub6_CRT8INIT;
function  Sub6_INSTANCE:tSub6;

implementation


type
_tSub6_Project_=class(TLazProject)
  protected
    function _getIdeOPTIONs_:tSub6_ideProjectResources;
  end;

function _tSub6_Project_._getIdeOPTIONs_:tSub6_ideProjectResources;
var i:integer;
begin

  result:=tSub6_ideProjectResources(TAbstractProjectResources(Resources).Resource[tSub6_ideProjectResources]);
  {if Assigned(result)
  then ShowMessage('resource FIND:'+result.ClassName)
  else ShowMessage('resource NOT FIND');
  }
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



function tSub6._Sub6Resources_find_(const prj:TLazProject):tSub6_ideProjectResources;
begin

end;

// получть ЭКЗЕМПЛЯР ресурсов 'Sub6' для текущего АКТИВНОГО проекта
function tSub6.ActiveProject_Sub6Resources:tSub6_ideProjectResources;
begin
    result:=nil;
    if Assigned(LazarusIDE) and                     //< -- такое чуство что
       Assigned(LazarusIDE.ActiveProject) and       //<    проверок слишком
       Assigned(LazarusIDE.ActiveProject.Resources) //<    много
    then begin
        with TAbstractProjectResources(LazarusIDE.ActiveProject.Resources)
        do result:=tSub6_ideProjectResources(Resource[tSub6_ideProjectResources]);
    end;
end;


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

function tSub6.NodeLIST_Insert(const List:tSub6_nodeList_core; Node:tSub6_node):boolean;
begin
    //result:=List.Insert(Node);
end;











//------------------------------------------------------------------------------

var _Sub6_:tSub6;

procedure Sub6_CRT8INIT;
begin
   _Sub6_:=tSub6.Create;
end;

function Sub6_INSTANCE:tSub6;
begin
    result:=_Sub6_;
end;

initialization
 _Sub6_:=nil;
finalization
 _Sub6_.Free;

end.

