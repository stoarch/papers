unit data_factoryUser;

interface
  uses
    //--[ data ]--
    data_user,
    //--[ interfaces ]--
    interface_factoryUserData,
    //--[ storage ]--
    storage_integerList,
    //--[ types ]--
    type_userInfo
    ;

  type
    TFactoryUserData = class( TUserData, IFactoryUserData )
     private
       m_dept_id : integer;
       m_roles   : TIntegerList;

     public
       constructor Create();override;
       destructor  Destroy();override;

      //--[ accessors ]--
      function get_dept_id() : integer;
      function get_roles_count() : integer;
      function get_system_role( index : integer ) : TSystemRole;

      //--[ mutators ]--
      procedure set_dept_id( value : integer );
      procedure set_system_role( index : integer; value : TSystemRole );

      //--[ properties ]--
      property dept_id : integer read get_dept_id write set_dept_id;
      property roles_count : integer read get_roles_count;
      property system_roles[ index : integer ]: TSystemRole read get_system_role write set_system_role;

      //--[ methods ]--
      procedure add_system_role( value : TSystemRole );
    end;//class

implementation

uses sysUtils;

{ TFactoryUserData }

procedure TFactoryUserData.add_system_role(value: TSystemRole);
begin
  m_roles.add( value );
end;

constructor TFactoryUserData.Create;
begin
  inherited;
  m_roles := TIntegerList.Create();
end;

destructor TFactoryUserData.Destroy;
begin
  FreeAndNil( m_roles );
  inherited;
end;

function TFactoryUserData.get_dept_id: integer;
begin
  result := m_dept_id;
end;

function TFactoryUserData.get_roles_count: integer;
begin
  result := m_roles.count;
end;

function TFactoryUserData.get_system_role(index: integer): TSystemRole;
begin
  result := TSystemRole( m_roles.get( index ) );
end;

procedure TFactoryUserData.set_dept_id(value: integer);
begin
  m_dept_id := value;
end;

procedure TFactoryUserData.set_system_role(index: integer;
  value: TSystemRole);
begin
  m_roles.put( index, value )
end;

end.
