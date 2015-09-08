unit Sub6_node;

{$mode objfpc}{$H+}
interface
{$I Sub6_INI.inc}

uses

{$ifDef lazExt_Sub6_DEBUG_mode}
    {$define _DEBUG_}
    {$define _TSTPRM_}
{$else}
    {$define _INLINE_}
{$endIf}

{$ifDef lazExt_Sub6_EventLOG_mode}Sub6_wndDebug,{$endIf}
  SysUtils;





type
//Node
 //File

 tSub6_node=class
  protected
   _next_:tSub6_node;
   _IDNT_:string; //< строка иденификатор (`ProductName`, `LegalTrademarks` ...)
    function _idnt_compare(const text:string):integer;
  protected
   _used_ :boolean;
   _value_:boolean;
  protected
    property Identifier:string read _IDNT_;
    function Get_asTEXT:string; virtual;
  public
    constructor Create(const identifier:string); virtual;
    destructor DESTROY; override;
  end;

 tSub6_nodeList_core=class
  protected
   _nodes_:tSub6_node;
  protected
    function  _node_getNext(const node:tObject):tObject;
    procedure _node_setNext(const node:tObject; const value:tObject);
  protected
    procedure _nodes_CLR_;
    function  _nodes_FND_(const IDNT:string):tObject;
    procedure _nodes_INS_(const node:tObject);
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    function Insert(const node:tSub6_node):boolean;
  end;


implementation

constructor tSub6_node.Create(const identifier:string);
begin
   _IDNT_:=identifier;
end;

destructor tSub6_node.DESTROY;
begin
    _IDNT_:=''; //< наследие Дельфи (уж какая версия не помню)
end;

//------------------------------------------------------------------------------

function tSub6_node._idnt_compare(const text:string):integer;
begin
    result:=SysUtils.CompareText(_IDNT_,text);
end;

//==============================================================================

constructor tSub6_nodeList_core.Create;
begin
    inherited;
   _nodes_:=nil;
end;

destructor tSub6_nodeList_core.DESTROY;
begin
   _nodes_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

function tSub6_nodeList_core.Insert(const node:tSub6_node):boolean;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    if not Assigned(_nodes_FND_(node._IDNT_)) then begin
       _nodes_INS_(node)
        result:=true;
    end;
    else result:=false
end;

//------------------------------------------------------------------------------

function tSub6_nodeList_core._node_getNext(const node:TObject):TObject;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
        Assert(node is tSub6_node,'NODE mast by tSub6_node');
    {$endIF}
    result:=tSub6_node(node)._next_;
end;

procedure tSub6_nodeList_core._node_setNext(const node:TObject; const value:TObject);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
        Assert(node is tSub6_node,'NODE mast by tSub6_node');
    {$endIF}
    tSub6_node(node)._next_:=value;
end;

//------------------------------------------------------------------------------

{procedure tSub6_nodeList_core._nodes_setFIRST(const value:tObject);
begin

end;

function  tSub6_nodeList_core._nodes_getFIRST:tObject;
begin

end;}

//------------------------------------------------------------------------------

// очистка списка узлов (уничтожение)
procedure tSub6_nodeList_core._nodes_CLR_;
var tmp:tSub6_node;
begin
    tmp:=_nodes_;
    while Assigned(tmp) do begin
       _nodes_:=tmp._next_;
        tmp.FREE;
        tmp:=_nodes_;
    end;
end;

// поиск в спискае узла с совпадающим идентификатором
function tSub6_nodeList_core._nodes_FND_(const IDNT:string):tObject;
begin
    {$ifDef _TSTPRM_}
        Assert(IDNT='','IDNT === NIL string');
    {$endIF}
    result:=_nodes_;
    while Assigned(result) do begin
        if 0=tSub6_node(result)._idnt_compare(IDNT) then BREAK;
        result:=tSub6_node(result)._next_;
    end;
end;

procedure tSub6_nodeList_core._nodes_INS_(const node:tObject);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
        Assert(node is tSub6_node,'NODE mast by tSub6_node');
    {$endIF}
    tSub6_node(node)._next_:=_nodes_;
   _nodes_:=node;
end;

end.

