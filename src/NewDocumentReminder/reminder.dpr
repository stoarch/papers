program reminder;

{%ToDo 'reminder.todo'}

uses
  Forms,
  sysUtils,
  Main_ReminderForm in 'Main_ReminderForm.pas' {NewDocument_Status_Form},
  tool_messageScaner in '..\SmartClient\Lib\Task\tools\tool_messageScaner.pas',
  thread_sql_messageScan in '..\SmartClient\Lib\Task\threads\thread_sql_messageScan.pas',
  tool_Environment in '..\SmartClient\Lib\Task\tools\tool_Environment.pas',
  tool_sql_documentMessageReceiver_ArrivalChecker in '..\SmartClient\Lib\Task\tools\messages\tool_sql_documentMessageReceiver_ArrivalChecker.pas',
  factory_receiver in '..\SmartClient\Lib\Task\tools\factory\factory_receiver.pas',
  interface_messageClient in '..\SmartClient\Lib\Task\interfaces\interface_messageClient.pas',
  interface_message in '..\SmartClient\Lib\Task\interfaces\interface_message.pas',
  const_sql_documentMessageReceiver in '..\SmartClient\Lib\Task\constants\const_sql_documentMessageReceiver.pas',
  tool_sql_documentMessageReceiver in '..\SmartClient\Lib\Task\tools\messages\tool_sql_documentMessageReceiver.pas',
  const_documentMessage in '..\SmartClient\Lib\Task\constants\const_documentMessage.pas',
  interface_documentMessage in '..\SmartClient\Lib\Task\interfaces\interface_documentMessage.pas',
  interface_sql_documentMessageReceiver in '..\SmartClient\Lib\Task\interfaces\interface_sql_documentMessageReceiver.pas',
  interface_documentMessageReceiver in '..\SmartClient\Lib\Task\interfaces\interface_documentMessageReceiver.pas',
  interface_messageReceiver in '..\SmartClient\Lib\Task\interfaces\interface_messageReceiver.pas',
  interface_userData in '..\SmartClient\Lib\Task\interfaces\interface_userData.pas',
  const_strings in '..\SmartClient\Lib\Common\constants\const_strings.pas',
  factory_data in '..\SmartClient\Lib\Task\tools\factory\factory_data.pas',
  tool_Settings in '..\SmartClient\Lib\Task\tools\tool_Settings.pas',
  interface_compoundMessage in '..\SmartClient\Lib\Task\interfaces\interface_compoundMessage.pas',
  const_sql_documentMessageReceiver_Compound in '..\SmartClient\Lib\Task\constants\const_sql_documentMessageReceiver_Compound.pas',
  interface_sql_documentMessageReceiver_Compound in '..\SmartClient\Lib\Task\interfaces\interface_sql_documentMessageReceiver_Compound.pas',
  tool_sql_documentMessageReceiver_Compound in '..\SmartClient\Lib\Task\tools\messages\tool_sql_documentMessageReceiver_Compound.pas',
  interface_messageList in '..\SmartClient\Lib\Task\interfaces\interface_messageList.pas',
  factory_list in '..\SmartClient\Lib\Task\tools\factory\factory_list.pas',
  list_messages in '..\SmartClient\Lib\Task\data\lists\list_messages.pas';

{$R *.res}
 procedure initialize();
 begin
   Settings.initialize( 'reminder.ini' );
   Settings.connect();

   Environment.set_string( c_protocol,  Settings.get_string( c_protocol, c_db_settings ) );
   Environment.set_string( c_host_name, Settings.get_string( c_host_name, c_db_settings ) );
   Environment.set_string( c_database,  Settings.get_string( c_database, c_db_settings ) );
   Environment.set_string( c_user,      Settings.get_string( c_user, c_db_settings ) );
   Environment.set_variant( c_db_port,  Settings.get_integer( c_db_port, c_db_settings ) );
   Environment.set_variant( c_login_prompt, Settings.get_boolean( c_login_prompt, c_db_settings ) );
 end;//proc

 procedure finalize();
 begin
   Settings.disconnect();
   Settings.finalize();
   
 end;//proc

begin
  initialize();

  Application.Initialize;
  try
    Application.CreateForm(TNewDocument_Status_Form, NewDocument_Status_Form);
  NewDocument_Status_Form.Visible := false;
    NewDocument_Status_Form.Top := 5000;
    NewDocument_Status_Form.Left := 5000;
    NewDocument_Status_Form.initialize();
    NewDocument_Status_Form.Visible := false;

    Application.Run;
  finally
    FreeAndNil( NewDocument_Status_Form );

    finalize();
  end;//try-finally
end.
