program terminal2;

uses
  Forms,
  SysUtils,
  UserTerminal in 'UserTerminal.pas' {UserTerminalForm},
  Logo_Form in 'Lib\Task\UI\Logo_Form.pas' {LogoForm},
  Paperwork_DataModule in 'Lib\Task\DataModules\Paperwork_DataModule.pas' {Paperwork_DM: TDataModule},
  Form_ConnectionStatus in 'Lib\Common\ui\forms\Form_ConnectionStatus.pas' {ConnectionStatus_Form},
  interface_IDbTaskStatus in 'Lib\Common\interface\db\interface_IDbTaskStatus.pas',
  Form_Skined in 'Lib\Common\ui\forms\Form_Skined.pas' {SkinedForm},
  Form_Login in 'Lib\Common\ui\forms\Form_Login.pas' {LoginForm},
  List_Classes in 'Lib\Common\data\lists\List_Classes.pas',
  Data_ClassInfo in 'Lib\Common\data\items\Data_ClassInfo.pas',
  data_userInfo in 'Lib\Task\data\data_userInfo.pas',
  Authentificator in 'Lib\Task\tools\authentification\Authentificator.pas',
  Frame_Skined in 'Lib\Common\ui\frames\Frame_Skined.pas' {SkinedFrame: TFrame},
  Frame_UserWorkplace in 'Lib\Common\ui\frames\Frame_UserWorkplace.pas' {UserWorkplace: TFrame},
  _WorkplaceLoader in 'Lib\Common\tools\loaders\_WorkplaceLoader.pas',
  List_WorkplaceInfo in 'Lib\Common\data\lists\List_WorkplaceInfo.pas',
  Form_ProgressDisplayer in 'Lib\Common\ui\forms\Form_ProgressDisplayer.pas' {ProgressDisplayer},
  interface_IProgressDisplayer in 'Lib\Common\interface\interface_IProgressDisplayer.pas',
  tool_StreamHandler in 'Lib\Common\tools\handlers\tool_StreamHandler.pas',
  data_WorkplaceInfo in 'Lib\Common\data\items\data_WorkplaceInfo.pas',
  tool_GlobalLog in 'Lib\Task\tools\log\tool_GlobalLog.pas',
  data_documentInfo in 'Lib\Task\data\data_documentInfo.pas',
  data_document in 'Lib\Task\data\data_document.pas',
  list_documents in 'Lib\Task\data\lists\list_documents.pas',
  Frame_DocumentBody_Editor in 'Lib\Task\UI\frames\documents\Frame_DocumentBody_Editor.pas' {document_body_editor_frame: TFrame},
  Frame_DocumentEditor in 'Lib\Task\UI\frames\documents\Frame_DocumentEditor.pas' {document_editor_frame: TFrame},
  Frame_DocumentFooter_Editor in 'Lib\Task\UI\frames\documents\Frame_DocumentFooter_Editor.pas' {document_footer_editor_frame: TFrame},
  Frame_DocumentHeaderEditor in 'Lib\Task\UI\frames\documents\Frame_DocumentHeaderEditor.pas' {document_header_editor_frame: TFrame},
  Form_DocumentEditor in 'Lib\Task\UI\forms\documents\Form_DocumentEditor.pas' {DocumentEditorForm},
  Frame_PaperworkUser_Workplace in 'Lib\Task\UI\frames\Frame_PaperworkUser_Workplace.pas' {PaperworkUser_Workplace: TFrame},
  list_documentAttachments in 'Lib\Task\data\lists\list_documentAttachments.pas',
  data_documentAttachment in 'Lib\Task\data\data\data_documentAttachment.pas',
  list_documentDirections in 'Lib\Task\data\lists\list_documentDirections.pas',
  list_documentKinds in 'Lib\Task\data\lists\list_documentKinds.pas',
  data_documentDirection in 'Lib\Task\data\data\data_documentDirection.pas',
  data_documentKindInfo in 'Lib\Task\data\data\data_documentKindInfo.pas',
  Frame_Editor in 'Lib\Common\ui\frames\Frame_Editor.pas' {EditorFrame: TFrame},
  Frame_ContainerEditor in 'Lib\Common\ui\frames\Frame_ContainerEditor.pas' {ContainerEditorFrame: TFrame},
  loader_userData in 'Lib\Task\loaders\loader_userData.pas',
  data_user in 'Lib\Task\data\data_user.pas',
  Frame_document_attachment_viewer in 'Lib\Task\UI\frames\documents\Frame_document_attachment_viewer.pas' {document_attachment_viewer: TFrame},
  frame_document_view in 'Lib\Task\UI\frames\documents\frame_document_view.pas' {document_view_frame: TFrame},
  Frame_document_body_viewer in 'Lib\Task\UI\frames\documents\Frame_document_body_viewer.pas' {document_body_view_frame: TFrame},
  Frame_document_header_view in 'Lib\Task\UI\frames\documents\Frame_document_header_view.pas' {document_header_view_frame: TFrame},
  interface_authentificator in 'Lib\Common\interface\interface_authentificator.pas',
  interface_userInfo in 'Lib\Task\interfaces\interface_userInfo.pas',
  interface_userData in 'Lib\Task\interfaces\interface_userData.pas',
  interface_documentDirectionsList in 'Lib\Task\interfaces\interface_documentDirectionsList.pas',
  interface_documentDirection in 'Lib\Task\interfaces\interface_documentDirection.pas',
  interface_documentKindList in 'Lib\Task\interfaces\interface_documentKindList.pas',
  interface_list in 'Lib\Task\interfaces\interface_list.pas',
  interface_documentKindInfo in 'Lib\Task\interfaces\interface_documentKindInfo.pas',
  const_user in 'Lib\Task\constants\const_user.pas',
  const_userInfo in 'Lib\Task\constants\const_userInfo.pas',
  const_documentDirection in 'Lib\Task\constants\const_documentDirection.pas',
  const_documentKindInfo in 'Lib\Task\constants\const_documentKindInfo.pas',
  const_documentKindList in 'Lib\Task\constants\const_documentKindList.pas',
  const_workplaceInfoList in 'Lib\Task\constants\const_workplaceInfoList.pas',
  interface_workplaceInfoList in 'Lib\Task\interfaces\interface_workplaceInfoList.pas',
  tool_userInfo in 'Lib\Task\tools\tool_userInfo.pas',
  type_userInfo in 'Lib\Task\types\type_userInfo.pas',
  type_documentInfo in 'Lib\Task\types\type_documentInfo.pas',
  interface_document in 'Lib\Task\interfaces\interface_document.pas',
  interface_documentAttachment in 'Lib\Task\interfaces\interface_documentAttachment.pas',
  interface_documentAttachmentList in 'Lib\Task\interfaces\interface_documentAttachmentList.pas',
  const_documentAttachment in 'Lib\Task\constants\const_documentAttachment.pas',
  const_documentAttachmentList in 'Lib\Task\constants\const_documentAttachmentList.pas',
  list_persistentInterface in 'Lib\Common\data\lists\list_persistentInterface.pas',
  const_persistentInterfaceList in 'Lib\Common\data\constants\const_persistentInterfaceList.pas',
  interface_persistentInterfaceList in 'Lib\Common\interface\interface_persistentInterfaceList.pas',
  const_document in 'Lib\Task\constants\const_document.pas',
  tool_documentInfo in 'Lib\Task\tools\tool_documentInfo.pas',
  interface_documentList in 'Lib\Task\interfaces\interface_documentList.pas',
  const_authentificator in 'Lib\Task\constants\const_authentificator.pas',
  const_userDataLoader in 'Lib\Task\constants\const_userDataLoader.pas',
  interface_userDataLoader in 'Lib\Task\interfaces\interface_userDataLoader.pas',
  const_workplaceInfo in 'Lib\Task\constants\const_workplaceInfo.pas',
  interface_workplaceInfo in 'Lib\Task\interfaces\interface_workplaceInfo.pas',
  Paperwork_ClassFactory in 'Lib\Task\tools\factory\Paperwork_ClassFactory.pas',
  const_documentDirectionsList in 'Lib\Task\constants\const_documentDirectionsList.pas',
  const_documentList in 'Lib\Task\constants\const_documentList.pas',
  Form_DocumentAttachmentEditor in 'Lib\Task\UI\forms\documents\attachments\Form_DocumentAttachmentEditor.pas' {DocumentAttachment_EditorForm},
  Frame_AttachmentEditor in 'Lib\Task\UI\frames\documents\Frame_AttachmentEditor.pas' {Attachment_EditorFrame: TFrame},
  Frame_DocumentAttachments_Editor in 'Lib\Task\UI\frames\documents\Frame_DocumentAttachments_Editor.pas' {document_attachments_editor: TFrame},
  Frame_document_footer_viewer in 'Lib\Task\UI\frames\documents\Frame_document_footer_viewer.pas' {document_footer_view_frame: TFrame},
  Frame_MessageDisplayer in 'Lib\Common\ui\frames\Frame_MessageDisplayer.pas' {MessageDisplayer: TFrame},
  interface_messageSender in 'Lib\Common\interface\interface_messageSender.pas',
  tool_messageSender in 'Lib\Common\messages\tool_messageSender.pas',
  interface_documentMessageSender in 'Lib\Common\interface\interface_documentMessageSender.pas',
  tool_documentMessageSender in 'Lib\Common\messages\tool_documentMessageSender.pas',
  interface_sql_documentMessageSender in 'Lib\Task\interfaces\interface_sql_documentMessageSender.pas',
  interface_sql_documentMessageReceiver in 'Lib\Task\interfaces\interface_sql_documentMessageReceiver.pas',
  interface_documentMessage in 'Lib\Task\interfaces\interface_documentMessage.pas',
  interface_message in 'Lib\Task\interfaces\interface_message.pas',
  data_message in 'Lib\Task\data\data_message.pas',
  data_documentMessage in 'Lib\Task\data\data_documentMessage.pas',
  tool_messageReceiver in 'Lib\Task\tools\tool_messageReceiver.pas',
  tool_documentMessageReceiver in 'Lib\Task\tools\tool_documentMessageReceiver.pas',
  interface_messageClient in 'Lib\Task\interfaces\interface_messageClient.pas',
  interface_messageScaner in 'Lib\Task\interfaces\interface_messageScaner.pas',
  interface_messageReceiver in 'Lib\Task\interfaces\interface_messageReceiver.pas',
  const_messageScaner in 'Lib\Task\constants\const_messageScaner.pas',
  interface_documentMessageReceiver in 'Lib\Task\interfaces\interface_documentMessageReceiver.pas',
  const_documentMessageReceiver in 'Lib\Task\constants\const_documentMessageReceiver.pas',
  const_messageReceiver in 'Lib\Task\constants\const_messageReceiver.pas',
  const_message in 'Lib\Task\constants\const_message.pas',
  const_documentMessage in 'Lib\Task\constants\const_documentMessage.pas',
  tool_messageScaner in 'Lib\Task\tools\tool_messageScaner.pas',
  thread_messageScan in 'Lib\Task\threads\thread_messageScan.pas',
  interface_messageInformationDisplayer in 'Lib\Task\interfaces\interface_messageInformationDisplayer.pas',
  Frame_OperatorWorkplace in 'Lib\Task\UI\frames\Frame_OperatorWorkplace.pas' {OperatorWorkplace: TFrame},
  const_sql_documentMessageReceiver in 'Lib\Task\constants\const_sql_documentMessageReceiver.pas',
  const_sql_documentMessageSender in 'Lib\Task\constants\const_sql_documentMessageSender.pas',
  tool_sql_documentMessageReceiver in 'Lib\Task\tools\messages\tool_sql_documentMessageReceiver.pas',
  tool_sql_documentMessageSender in 'Lib\Task\tools\messages\tool_sql_documentMessageSender.pas',
  type_Message in 'Lib\Task\types\type_Message.pas',
  Frame_OfficeManager_Workplace in 'Lib\Task\UI\frames\Frame_OfficeManager_Workplace.pas' {OfficeManagerWorkplace: TFrame},
  thread_sql_messageScan in 'Lib\Task\threads\thread_sql_messageScan.pas';

{$R *.res}

begin
  Application.Initialize;

  paperwork_dm := TPaperwork_dm.create(nil);
  paperwork_dm.openConnection();

  try
    logoForm := TLogoForm.Create( application );
    logoForm.Show();
    logoForm.Update();

    Application.CreateForm(TUserTerminalForm, UserTerminalForm);

    logoForm.Hide();
    FreeAndNil( logoForm );

    userTerminalForm.show();
    userTerminalForm.update();
    userTerminalForm.initialize();

    Application.Run;
  finally
    FreeAndNil( paperwork_dm );
  end;//try--finally
end.
