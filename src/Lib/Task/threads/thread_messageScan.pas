unit thread_messageScan;

{$define DEBUG}

interface
  uses
    //--[ common ]--
    classes, dialogs, windows, sysUtils, sDialogs,
    //--[ interfaces ]--
    interface_messageClient,
    interface_messageReceiver,
    //--[ tools ]--
    tool_Environment,
    tool_GlobalLog
    ;


  type
    //$$[ TMessageScanThread ]$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    // kind: class
    // goal: provide asyncronous scan for messages and fire an event
    //       if something found
    // protocol:
    //  1. initialization
    //     1. make an instance of thread
    //     2. setup the message client - who will receive events of
    //        new message arrival
    //     3. setup the message receiver - who will check existense of new messages
    //     4. resume thread
    TMessageScanThread = class( TThread )
    private
    procedure handle_message_arrival;
    protected
      m_message_client : IMessageClient;
      m_message_receiver : IMessageReceiver;
      m_error            : string;

      function  get_thread_name() : string;virtual;
      procedure setName();

      procedure execute_receiver;

      procedure initialize();virtual;
      procedure finalize();virtual;

    public
      constructor Create( Suspended : boolean );
      destructor Destroy;override;

      //--[ methods ]--
      procedure setMessageClient( client : IMessageClient );
      procedure setMessageReceiver( receiver : IMessageReceiver );

      procedure execute();override;
    end;//class

implementation

  const
    MESSAGE_WAIT_INTERVAL = 10;//sec
    ONE_SECOND            = 1000; //msec

{ TMessageScanThread }

constructor TMessageScanThread.Create(Suspended: boolean);
begin
  inherited;

  Priority := tpLowest;
end;

destructor TMessageScanThread.Destroy;
begin
  try
{$ifdef DEBUG}
    GlobalLog.Write( 'TMessageScanThread.Destroy' );
{$endif}

    inherited;
  except
    on e:exception do
     raise Exception.create( 'TMessageScanThread.Destroy->' + e.message );
  end;//try--except
(*{$ifdef DEBUG}
  GlobalLog.Write( 'TMessageScanThread.Destroy->' + 'Destroyed!' );
{$endif}
*)
end;

procedure TMessageScanThread.execute;
begin
  assert( m_message_receiver <> nil, 'No message receiver specified!' );
  assert( m_message_client <> nil, 'No message client specified!');

  try
(*{$ifdef DEBUG}
  GlobalLog.Write( 'TMessageScanThread.Execute->initializing' );
{$endif}
*)
    setName();

    initialize();

(*{$ifdef DEBUG}
  GlobalLog.Write( 'TMessageScanThread.Execute->start scanning...' );
{$endif}
*)
    while not Terminated do
    begin
      execute_receiver();

      sleep( MESSAGE_WAIT_INTERVAL * ONE_SECOND );
    end;//while

(*{$ifdef DEBUG}
  GlobalLog.Write( 'TMessageScanThread.Execute->finalizing' );
{$endif}
*)
    finalize();
  except
    on e:exception do
    begin
      m_error := e.message;
      GlobalLog.Write( 'TMessageScanThread->execute' + m_error );
    end;//exception
  end;//try--except
end;




procedure TMessageScanThread.execute_receiver();
begin
  try
    if( m_message_receiver.execute() )then
      Synchronize( handle_message_arrival );
  except
    on e:exception do
    begin
      sShowMessage( e.message );
      GlobalLog.Write( 'TMessageScanThread->execute' + e.message );
    end;//on
  end;//try-finally
end;//proc

procedure TMessageScanThread.handle_message_arrival();
begin
   m_message_client.handle_message_arrival( m_message_receiver.get_message );
end;//proc

procedure TMessageScanThread.finalize;
begin
    m_message_client   := nil;
    m_message_receiver := nil;
end;

function TMessageScanThread.get_thread_name: string;
begin
  result := 'TMessageScanThread'
end;

procedure TMessageScanThread.initialize;
begin

end;

procedure TMessageScanThread.setMessageClient(client: IMessageClient);
begin
  m_message_client := client;
end;

procedure TMessageScanThread.setMessageReceiver(
  receiver: IMessageReceiver);
begin
  m_message_receiver := receiver;
end;

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;
{$ENDIF}


procedure TMessageScanThread.setName;
{$IFDEF MSWINDOWS}

var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := pCHar( get_thread_name() );
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
{$ENDIF}
end;

end.
