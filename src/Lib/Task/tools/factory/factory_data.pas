unit factory_data;

interface
  uses
     //--[ common ]--
     ActiveX, classes, sysUtils
     ;


  type
    data_factory = class
      class function createInstance( clsid : TGUID; iid : TGUID ) : IInterface;
    end;//class
implementation
  uses
    //--[ constants ]--
    const_user,
    //--[ data ]--
    data_user
     ;

{ data_factory }

class function data_factory.createInstance(clsid, iid: TGUID): IInterface;
  var
    obj : TInterfacedObject;
    intf : IInterface;
    hr  : HRESULT;
begin
  obj := nil;
  result := nil;

  //*make an object
  if( IsEqualGUID( clsid, CLSID_UserData ))then
    obj := TUserData.create()
  ;

  if( obj = nil )then
  begin
    raise Exception.create( 'Paperwrk_ClassFactory.createInstance>>������ ������ ���� �� ��������������!' );
  end;//if

 intf := obj as IInterface;

 hr := intf.queryInterface( iid, result );

 intf := nil;

 if( failed( hr ))then
  begin
    raise Exception.create( 'Paperwrk_ClassFactory.createInstance>>��������� �� ��������������!' );
  end;//if
end;

end.
 