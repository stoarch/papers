unit Paperwork_DataModule;

interface

uses
  SysUtils, Classes, DB, ADODB,
  //-- interfaces --
  interface_IDbTaskStatus,
  //--[ tools ]--
  tool_documentInfo,
  tool_userInfo,
  //--[ zeos ]--
  ZDataset, ZAbstractRODataset,
  ZAbstractDataset,ZAbstractTable, ZConnection
  ;

type
  TPaperwork_DM = class(TDataModule)
    paperwork_connection: TZConnection;
    work_query: TZQuery;
  private
    { Private declarations }
    m_istatus : IDbTaskStatus;
    procedure setStatus_DbName(name: string);
    procedure setStatus_Task(task: string);

  public
    { Public declarations }
    constructor Create( AOwner : TComponent );override;
    destructor Destroy();override;

    procedure OpenConnection();
    procedure close_connection();

    procedure setTaskStatus( istatus : IDbTaskStatus );

  end;

var
  Paperwork_DM: TPaperwork_DM;

implementation

{$R *.dfm}

{ TPaperwork_DM }

procedure TPaperwork_DM.OpenConnection;
begin
  setStatus_DbName( '���������������' );
  setStatus_Task( '���������� � �����...' );

  paperwork_connection.Connect;

  setStatus_Task( '��������� ����������...' );
  work_query.SQL.Clear();
  work_query.SQL.Add( 'set character set cp1251' );
  work_query.ExecSQL();

  setStatus_Task( '�������� ������������...' );
  tool_documentInfo.initialize();
  tool_userInfo.initialize();


  setStatus_Task( '������!' );
end;

procedure TPaperwork_DM.setTaskStatus(istatus: IDbTaskStatus);
begin
  m_istatus := istatus;
end;


procedure TPaperwork_DM.setStatus_DbName( name : string );
begin
  if( m_istatus <> nil )then
    m_istatus.setDbName( name );
end;//proc

procedure TPaperwork_DM.setStatus_Task( task : string );
begin
  if( m_istatus <> nil )then
    m_istatus.setTaskName( task );
end;//proc

constructor TPaperwork_DM.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TPaperwork_DM.Destroy;
begin
  close_connection();

  if( m_istatus <> nil )then
    m_istatus := nil;

  inherited;
end;

procedure TPaperwork_DM.close_connection;
begin
  paperwork_connection.Disconnect;
end;

end.
